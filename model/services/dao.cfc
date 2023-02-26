component accessors=true{

        property utilService;
        function view_work_queue(){

        var     get_q       =       QueryExecute("
                                                SELECT  
                                                        tbl_transactions.transaction_id,
                                                        tbl_transactions.checkout_id,
                                                        tbl_transactions.trans_amount,
                                                        tbl_transactions.date_added,
                                                        tbl_transactions.payment_intent_id,
                                                        tbl_transactions.trans_subtotal,
                                                        tbl_user.user_first_name,
                                                        tbl_user.user_last_name,
                                                        tbl_user.user_address_line1,
                                                        tbl_user.user_address_line2,
                                                        tbl_user.user_city,
                                                        tbl_user.user_state,
                                                        tbl_user.user_zip,
                                                        tbl_user.user_country,
                                                        tbl_user.stripe_cust_id,
                                                        tbl_gpx_routes.gpx_location,
                                                        tbl_gpx_routes.gpx_file_name,
                                                        tbl_gpx_routes.gpx_caption,
                                                        tbl_auth.username
                                                FROM    tbl_transactions
                                                INNER JOIN  tbl_user ON tbl_transactions.user_id = tbl_user.user_id
                                                INNER JOIN  tbl_auth ON tbl_user.user_id = tbl_auth.user_id
                                                INNER JOIN  tbl_gpx_routes ON tbl_transactions.gpx = tbl_gpx_routes.route_id
                                                WHERE   tbl_transactions.completed = 0
                                                ",
                                                {},
                                                {datasource=application.dsn}
                                                );
                                return  get_q;
        }
        function latest_user_route(string user_id){

        var     get_user_route      =       QueryExecute("
                                                                SELECT  
                                                                        tbl_gpx_routes.gpx_file_name,
                                                                        tbl_gpx_routes.gpx_location,
                                                                        tbl_gpx_routes.gpx_caption,
                                                                        MAX(tbl_gpx_routes.date_added) as date_Added 
                                                                        
                                                                FROM    tbl_gpx_routes
                                                                
                                                                WHERE   tbl_gpx_routes.user_id  =   #arguments.user_id#
                                                                GROUP BY tbl_gpx_routes.gpx_file_name,tbl_gpx_routes.gpx_location,tbl_gpx_routes.gpx_caption
                                                        ",
                                                        {},
                                                        {datasource  =  application.dsn}
                                                        );
                                                        
                                                        return get_user_route;

        }
        function get_transaction(string transaction_id){
                var     get_transaction         =       QueryExecute("
                                                                        SELECT  
                                                                                tbl_transactions.transaction_id,
                                                                                tbl_transactions.checkout_id,
                                                                                tbl_transactions.trans_amount,
                                                                                tbl_transactions.date_added,
                                                                                tbl_transactions.payment_intent_id,
                                                                                tbl_transactions.trans_subtotal,
                                                                                tbl_transactions.plan_id,
                                                                                tbl_user.user_id,
                                                                                tbl_user.user_first_name,
                                                                                tbl_user.user_last_name,
                                                                                tbl_user.user_address_line1,
                                                                                tbl_user.user_address_line2,
                                                                                tbl_user.user_city,
                                                                                tbl_user.user_state,
                                                                                tbl_user.user_zip,
                                                                                tbl_user.user_country,
                                                                                tbl_user.stripe_cust_id,
                                                                                tbl_shipping.ship_address_line1,
                                                                                tbl_shipping.ship_address_line2,
                                                                                tbl_shipping.ship_name,
                                                                                tbl_shipping.ship_city,
                                                                                tbl_shipping.ship_state,
                                                                                tbl_shipping.ship_zip,
                                                                                tbl_gpx_routes.gpx_location,
                                                                                tbl_gpx_routes.gpx_file_name,
                                                                                tbl_gpx_routes.gpx_caption,
                                                                                tbl_auth.username,
                                                                                tbl_products.prod_name,
                                                                                tbl_products.prod_desc,
                                                                                tbl_products.prod_cost,
                                                                                tbl_products.prod_units,
                                                                                tbl_plan_tracker.count
                                                                        FROM    tbl_transactions
                                                                        INNER JOIN  tbl_user ON tbl_transactions.user_id = tbl_user.user_id
                                                                        INNER JOIN  tbl_plan_tracker ON tbl_transactions.transaction_id = tbl_plan_tracker.trans_id
                                                                        INNER JOIN  tbl_auth ON tbl_user.user_id = tbl_auth.user_id
                                                                        INNER JOIN  tbl_gpx_routes ON tbl_transactions.gpx = tbl_gpx_routes.route_id
                                                                        LEFT JOIN  tbl_products ON tbl_transactions.plan_id = tbl_products.prod_id
                                                                        LEFT JOIN   tbl_shipping ON tbl_transactions.transaction_id = tbl_shipping.transaction_id
                                                                        WHERE   tbl_transactions.transaction_id = #arguments.transaction_id#
                                                                        ",
                                                                        {},
                                                                        {datasource=application.dsn}
                                                                        );

                                                                        return get_transaction;

        }
        function get_site_messages(){

                var     get_site_messages       =       QueryExecute("
                                                                        SELECT  tbl_msgs.msg_id,
                                                                                tbl_msgs.user_name,
                                                                                tbl_msgs.user_email,
                                                                                tbl_msgs.user_msg,
                                                                                tbl_msgs.date_added
                                                                        FROM    tbl_msgs
                                                                        ",
                                                                        {},
                                                                        {datasource = application.dsn}
                                                                        );
                                                                        return get_site_messages;

        }

        function register_work_item(struct work_item){

                var     register_package        =       QueryExecute("
                                                                        INSERT INTO tbl_work_product(stl_file,map_file,stl_loc,map_loc,transaction_id,date_added)
                                                                        VALUES('#arguments.work_item.stl_ul_file#','#arguments.work_item.map_ul_file#','#arguments.work_item.stl_ul_file_loc#','#arguments.work_item.map_ul_file_loc#',#arguments.work_item.transaction_id#,#CREATEODBCDATETIME(Now())#)
                                                                        ",
                                                                        {},
                                                                        {datasource = application.dsn}
                                                                        );

                
        }

        function find_work_item(string transaction_id){
                //caution.  This function can produce more than one for extended packages. 
                var     get_item                =        QueryExecute("
                                                                        SELECT  tbl_work_product.wp_id,
                                                                                tbl_work_product.stl_file,
                                                                                tbl_work_product.map_file,
                                                                                tbl_work_product.stl_loc,
                                                                                tbl_work_product.map_loc,
                                                                                tbl_work_product.pic_file,
                                                                                tbl_work_product.pic_loc,
                                                                                tbl_work_product.transaction_id,
                                                                                tbl_work_product.date_added,
                                                                                tbl_work_product.completed
                                                                        FROM    tbl_work_product
                                                                        WHERE   tbl_work_product.transaction_id  = #arguments.transaction_id#
                                                                        ",
                                                                        {},
                                                                        {datasource = application.dsn}
                                                                        );

                                                                        return          get_item;


        }
        function register_output_pic(struct ul_struct){

                var     update_transaction              =               QueryExecute("
                                                                                        UPDATE  tbl_work_product
                                                                                        SET     tbl_work_product.pic_file = '#arguments.ul_struct.img_ul_file#',
                                                                                                tbl_work_product.pic_loc  = '#arguments.ul_struct.img_ul_file_loc#',
                                                                                                tbl_work_product.completed = 1
                                                                                        WHERE   tbl_work_product.transaction_id = #arguments.ul_struct.transaction_id#
                                                                                        ",
                                                                                        {},
                                                                                        {datasource = application.dsn}
                                                                                        );


        }
        function setup_new_internal_order(struct new_o_struct){

               

                //setup the GPX in the library to get a new GPX ID.
                var     setup_gpx                       =       QueryExecute("
                                                                                INSERT INTO tbl_gpx_routes(user_id,gpx_location,gpx_file_name,gpx_caption,date_added)
                                                                                VALUES(#arguments.new_o_struct.user_id#,'#arguments.new_o_struct.gpx_location#','#arguments.new_o_struct.gpx_file#','#arguments.new_o_struct.user_caption#',#CREATEODBCDATETIME(now())#)
                                                                        ",
                                                                        {},
                                                                        {datasource = application.dsn, result='gpx_file'}
                                                                        );
                                                                var     gpx_item            =       gpx_file.generatedkey;

                 //move the gpx from temp to the user's directory and update the struct.
                 var     user_dir                        =       application.user_dir & "/" & arguments.new_o_struct.user_id;
                 var     t_file                          =       expandpath(user_dir) & "/" & arguments.new_o_struct.gpx_file;
                 var     s_file 		                =       expandpath(application.gpx_dir) & "/" & arguments.new_o_struct.gpx_file;
 
                 var     file_struct                     =       {};
                        file_struct.s_file                      =       s_file;
                        file_struct.t_file                      =       t_file;
                        file_struct.t_file_trans                =       user_dir & "/" & arguments.new_o_struct.gpx_file;
                        file_struct.route_id                    =       gpx_item
                                
                        var     move_file                       =       variables.utilService.file_mover(file_struct);

                //setup a work product and reference the governing transaction
                var     setup_work_item                 =       QueryExecute("
                                                                                INSERT INTO tbl_work_product(transaction_id,date_added,gpx)
                                                                                VALUES(#arguments.new_o_struct.transaction_id#,#CREATEODBCDATETIME(Now())#,#gpx_item#)
                                                                                ",
                                                                                {},
                                                                                {datasource = application.dsn}
                                                                                );

                //get the plan count.
                var     get_count                       =       QueryExecute("
                                                                                SELECT  tbl_plan_tracker.count
                                                                                FROM    tbl_plan_tracker
                                                                                WHERE   tbl_plan_tracker.trans_id = #arguments.new_o_struct.transaction_id#
                                                                                ",
                                                                                {},
                                                                                {datasource = application.dsn}
                                                                                );

                var     new_count                       =       get_count.count + 1;                                      
                //increment the plan tracker.
                var     increment_tracker               =       QueryExecute("
                                                                              UPDATE    tbl_plan_tracker
                                                                              SET       tbl_plan_tracker.count          =  #new_count#
                                                                              WHERE     tbl_plan_tracker.trans_id       =  #arguments.new_o_struct.transaction_id#
                                                                                ",
                                                                                {},
                                                                                {datasource = application.dsn}
                                                                                );
              


               
        }
        function show_routes(string user_id){

                var     get_routes      =       QueryExecute("
                                                                SELECT  tbl_gpx_routes.route_id,
                                                                        tbl_gpx_routes.gpx_location,
                                                                        tbl_gpx_routes.gpx_file_name,
                                                                        tbl_gpx_routes.gpx_caption,
                                                                        tbl_gpx_routes.date_added
                                                                FROM    tbl_gpx_routes
                                                                WHERE   tbl_gpx_routes.user_id = #arguments.user_id#
                                                                ",
                                                                {},
                                                                {datasource = application.dsn}
                                                                );
                                                                return get_routes;


        }
       

}