component accessors="true" {

    property beanFactory;
    property formatterService;
	property daoService;
	property utilService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}

    function order_viewer(struct rc){

        if(structkeyexists(url, 'trans_id')){

            rc.transaction  =   variables.daoService.get_transaction(url.trans_id);
            rc.routes       =   variables.daoService.find_work_item(url.trans_id);

        }



    }
    function new_order(struct rc){

        if(structkeyexists(form, 'cancel')){

            fileDelete(expandpath(session.new_o_struct.gpx_file_loc));

            structdelete(session, 'new_o_struct');
        }

        if(NOT structkeyexists(session, 'new_o_struct')){
            session.new_o_struct    = {};
        }
        

        if(structkeyexists(url, 'use_trans')){

            
            session.new_o_struct.use_trans       = url.use_trans;

            session.has_open_plans  = false;

        }
        if(NOT structkeyexists(session.new_o_struct, 'use_trans')){
            //first figure out if the user has credits on an existing multi-pack.
            rc.open_plans   =   variables.utilService.credit_checker(session.user_pyld.user_id);
            if(NOT rc.open_plans.recordcount IS 0){
                var     cur_count   =   rc.open_plans.prod_units - rc.open_plans.count;
            }
            else{
                var     cur_count   =   0;
            }
            

            if(NOT cur_count IS 0){
                session.has_open_plans = true;
            }
            else{
                session.has_open_plans = false;
            }
            
        }
        else{
            rc.transaction  =   variables.daoService.get_transaction(session.new_o_struct.use_trans);
            rc.open_plans   =   variables.utilService.credit_checker(session.user_pyld.user_id);
            session.new_o_struct.cur_count      =       Evaluate(rc.transaction.prod_units - rc.transaction.count)
            session.new_o_struct.prod_units     =       rc.transaction.prod_units;
            if(session.new_o_struct.cur_count IS 0){
                session.has_open_plans          =       false;
            }
            
        }

        if(structkeyexists(url, 'new')){

            //handle the gpx file upload.
            var gpx_ul 						=	    fileUpload(expandpath(application.gpx_dir), "form.gpxfile", " ", "makeunique");

            if(gpx_ul.serverfile CONTAINS " "){
                var     s_file          =       Replace(gpx_ul.serverfile, " ", "_", "ALL");
                var     s_loc_old       =       application.gpx_dir & "/" & gpx_ul.serverfile;
                var     s_loc_new       =       application.gpx_dir & "/" & s_file;

                                                fileMove(expandPath(s_loc_old), expandpath(s_loc_new));

                session.new_o_struct.gpx_file		=       s_file;
            }
            else{
                session.new_o_struct.gpx_file		=       gpx_ul.serverfile;
            }
                session.new_o_struct.gpx_file_loc	=       application.gpx_dir & "/" & session.new_o_struct.gpx_file;
                session.new_o_struct.caption        =       form.caption;

        }
        if(structkeyexists(form, 'confirm')){

            var     new_o_struct        =   {};
            new_o_struct.user_id        =   session.user_pyld.user_id;
            new_o_struct.gpx_location   =   session.new_o_struct.gpx_file_loc;
            new_o_struct.gpx_file       =   session.new_o_struct.gpx_file;
            new_o_struct.user_caption   =   session.new_o_struct.caption;
            new_o_struct.transaction_id =   session.new_o_struct.use_trans;
            new_o_struct.amt_left       =   session.new_o_struct.cur_count;
            new_o_struct.prod_units     =   session.new_o_struct.prod_units;

            
            var     do_setup        =   variables.daoService.setup_new_internal_order(new_o_struct);

                   
        }
        
        rc.routes   =   variables.daoService.show_routes(session.user_pyld.user_id);
    }
    function route_library(struct rc){

        rc.routes   =   variables.daoService.show_routes(session.user_pyld.user_id);


    }

}