component accessors="true" {

    property beanFactory;
    property formatterService;
    property daoService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
       
	}
	
	public void function default( rc ) {
       
        var instant = variables.beanFactory.getBean( "instant" );
		rc.today = variables.formatterService.longdate( instant.created() );
	

		
	}
    public void function workq( struct rc){

        rc.get_site_messages 	=   variables.daoService.get_site_messages();
        rc.workq    =   variables.daoService.view_work_queue();



    }
    public void function process_file(struct rc){

        rc.get_site_messages 	=   variables.daoService.get_site_messages();
        

        if(structkeyexists(url, 'trans_id')){
            rc.transaction      =   variables.daoService.get_transaction(url.trans_id);
            rc.work_item            =   variables.daoService.find_work_item(rc.transaction.transaction_id);
            if(rc.work_item.recordcount IS 1){
                rc.is_Configured   =   true;

            }
            else{
                rc.is_Configured   =   false;
            }
            
            var     user_dir    =   application.user_dir & "/" & rc.transaction.user_id & "/";
        }
        if(structkeyexists(form, 'ul_pic')){

            var pic_ul 						=	    fileUpload(expandpath(user_dir), "form.output_pic", " ", "makeunique");

            var     ul_struct               =       {};
            ul_struct.img_ul_file           =       pic_ul.serverfile;
            ul_struct.img_ul_file_loc       =       user_dir & pic_ul.serverfile;
            ul_struct.transaction_id        =       url.trans_id;

                var     do_img_capture      =       variables.daoService.register_output_pic(ul_struct);



        }
        if(structkeyexists(form, 'ul_type')){
           
                var stl_ul 						=	    fileUpload(expandpath(user_dir), "form.stl_upload", " ", "makeunique");
                var map_ul 						=	    fileUpload(expandpath(user_dir), "form.map_upload", " ", "makeunique");

                var     ul_struct               =       {};
               
                ul_struct.stl_ul_file           =       stl_ul.serverfile;
                ul_struct.stl_ul_file_loc       =       user_dir & stl_ul.serverfile;
                ul_struct.map_ul_file           =       map_ul.serverfile;
                ul_struct.map_ul_file_loc       =       user_dir & map_ul.serverfile;
                ul_struct.transaction_id        =       rc.transaction.transaction_id;

                   var      do_package_insert            =       variables.daoService.register_work_item(ul_struct);
                
            
        }
        rc.transaction      =   variables.daoService.get_transaction(url.trans_id);
        rc.work_item            =   variables.daoService.find_work_item(rc.transaction.transaction_id);
    }
    function customers(struct rc){

        rc.get_site_messages 	=   variables.daoService.get_site_messages();




    }
	
}