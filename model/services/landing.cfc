component accessors=true{

    function get_products_for_landing(){

        var get_products_for_landing    =   QueryExecute("
                                                SELECT  tbl_products.prod_id,
                                                        tbl_products.prod_name,
                                                        tbl_products.prod_desc,
                                                        tbl_products.prod_cost,
                                                        tbl_products.prod_units
                                                FROM    tbl_products
                                            ",
                                            {},
                                            {datasource = application.dsn}
                                            );

                                            return get_products_for_landing;

    }
    function get_plan(string plan_id){
        var get_plan    =   QueryExecute("
                                        SELECT  tbl_products.prod_id,
                                                tbl_products.prod_name,
                                                tbl_products.price_obj,
                                                tbl_products.prod_desc,
                                                tbl_products.prod_cost,
                                                tbl_products.prod_units
                                        FROM    tbl_products
                                        WHERE   tbl_products.prod_id  = #arguments.plan_id#
                                        ",
                                        {},
                                        {datasource = application.dsn}
                                        );

                                        return get_plan;
    }
    function setup_initial_customer(struct cust_struct){


        //insert a user record
        var     do_user_insert      =       QueryExecute("
                                                        INSERT  INTO  tbl_user(user_first_name,user_last_name,user_address_line1,user_address_line2,user_city,user_state,user_zip,user_country,stripe_cust_id)
                                                        VALUES('#arguments.cust_struct.user_first_name#','#arguments.cust_struct.user_last_name#','#arguments.cust_struct.billing_address_line1#','#arguments.cust_struct.billing_address_line2#','#arguments.cust_struct.billing_city#','#arguments.cust_struct.billing_state#','#arguments.cust_struct.billing_zip#','#arguments.cust_struct.billing_country#','#arguments.cust_struct.stripe_cust_id#')
                                                        ",
                                                        {},
                                                        {datasource = application.dsn, result='new_cust'}
                                                        );
        var     new_user_id         =       new_cust.generatedkey;

        //now that we have a userID, make a user directory for it.
        //set up a user directory and move the gpx file to it.
					var 	mkdir		=	application.user_dir & "/" & new_user_id;
					var 	fulldir 	=   expandpath(application.user_dir) & "/" & new_user_id;
					
					var     s_file 		=   expandpath(application.gpx_dir) & "/" & arguments.cust_struct.gpx_file;
					var 	t_file 		= 	expandpath(mkdir) & "/" & arguments.cust_struct.gpx_file;

        //move the current GPX file from temp to the user's directory
                            if(NOT directoryexists(fulldir)){
                                directorycreate(fulldir);
                                    filemove(s_file, t_file);

                            }
                            else{

                                filemove(s_file, t_file);

                            }
        var     new_gpx_loc                 =   mkdir & "/" & arguments.cust_struct.gpx_file;
        session.reg_struct.gpx_file_loc     =   new_gpx_loc;

        //insert an auth record
        var     do_auth_insert      =       QueryExecute("
                                                            INSERT INTO tbl_auth(user_id,username,password,date_added,user_type)
                                                            VALUES   (#new_user_id#,'#arguments.cust_struct.user_email#','#arguments.cust_struct.user_password#',#CREATEODBCDATETIME(Now())#,2)
                                                            ",
                                                            {},
                                                            {datasource = application.dsn}
                                                            );    
        //register the GPX file to the user's account.
        var     do_gpx_insert       =       QueryExecute("
                                                            INSERT INTO tbl_gpx_routes(user_id,gpx_location,gpx_file_name,gpx_caption,date_added)
                                                            VALUES(#new_user_id#,'#new_gpx_loc#','#arguments.cust_struct.gpx_file#','#arguments.cust_struct.user_caption#',#CREATEODBCDATETIME(now())#)
                                                        ",
                                                        {},
                                                        {datasource = application.dsn, result='gpx_file'}
                                                        );
        var     gpx_item            =       gpx_file.generatedkey;
        //create the transaction that happened.
        var     do_trans_insert     =       QueryExecute("
                                                            INSERT INTO tbl_transactions(user_id,checkout_id,trans_amount,date_added,gpx,payment_intent_id,trans_subtotal,plan_id)
                                                            VALUES(#new_user_id#,'#arguments.cust_struct.checkout_id#','#arguments.cust_struct.trans_amount#',#CREATEODBCDATETIME(Now())#,#gpx_item#,'#arguments.cust_struct.payment_intent_id#','#arguments.cust_struct.trans_subtotal#',#arguments.cust_struct.selected_plan#)
                                                        ",
                                                        {},
                                                        {datasource = application.dsn, result= "trans_res"}
                                                        );
        var     trans_rec           =       trans_res.generatedkey;                                              
        //create the shipping record.
        var     do_trans_insert     =       QueryExecute("
                                                         INSERT  INTO  tbl_shipping(user_id,transaction_id,ship_address_line1,ship_address_line2,ship_name,ship_city,ship_state,ship_zip)
                                                        VALUES(#new_user_id#,#trans_rec#,'#arguments.cust_struct.shipping_address_line1#','#arguments.cust_struct.shipping_address_line2#','#arguments.cust_struct.shipping_name#','#arguments.cust_struct.shipping_city#','#arguments.cust_struct.shipping_state#','#arguments.cust_struct.shipping_zip#')
                                                        ",
                                                    {},
                                                    {datasource = application.dsn, result= "trans_res"}
                                                    );
        //set up the plan tracker
            var     plan_struct     =   {};
            plan_struct.trans_id    =   trans_rec;
            plan_struct.plan_id     =   arguments.cust_struct.selected_plan;
            plan_struct.user_id     =   new_user_id;
            plan_struct.count       =   1;

                var do_plan         =   this.set_plan_index(plan_struct);

        


    }
    function set_plan_index(struct plan_struct){

        var     set_plan_count      =   QueryExecute("
                                                    INSERT INTO tbl_plan_tracker(trans_id,plan_id,user_id,count)
                                                    VALUES(#arguments.plan_struct.trans_id#,#arguments.plan_struct.plan_id#,#arguments.plan_struct.user_id#,#arguments.plan_struct.count#)
                                                    ",
                                                    {},
                                                    {datasource = application.dsn}
                                                    );
       

    }
    function check_email(string email){

    var     check_email         =       QueryExecute("
                                                    SELECT  tbl_auth.user_id,
                                                            tbl_auth.user_type
                                                    FROM    tbl_auth
                                                    WHERE   tbl_auth.username = '#arguments.email#'

                                                    ",
                                                    {},
                                                    {datasource = application.dsn}
                                                    );
                                if(check_email.recordcount GTE 1 ){
                                    return true;
                                }
                                else{
                                    return false;
                                }


    }

    function intake_web_msg(struct msg){

        var     do_intake       =       QueryExecute("
                                                        INSERT INTO     tbl_msgs(user_name,user_email,user_msg,date_added)
                                                        VALUES  ('#arguments.msg.user_name#','#arguments.msg.user_email#','#arguments.msg.user_msg#',#CREATEODBCDATETIME(Now())#)
                                                    ",
                                                    {},
                                                    {datasource = application.dsn}
                                                    );

    }
}