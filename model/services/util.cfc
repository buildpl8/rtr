component accessors=true{

    function process_login(struct login){

        var     do_login        =       QueryExecute("
                                                        SELECT  tbl_auth.username,
                                                                tbl_auth.password,
                                                                tbl_auth.user_type AS user_type_id,
                                                                tbl_auth.user_id,
                                                                tbl_user.user_first_name,
                                                                tbl_user.user_last_name,
                                                                tbl_user.user_address_line1,
                                                                tbl_user.user_address_line2,
                                                                tbl_user.user_city,
                                                                tbl_user.user_state,
                                                                tbl_user.user_zip,
                                                                tbl_user.user_country,
                                                                tbl_user.stripe_cust_id,
                                                                ref_user_types.user_type
                                                        FROM    tbl_auth
                                                        INNER JOIN tbl_user ON tbl_auth.user_id = tbl_user.user_id
                                                        INNER JOIN ref_user_types ON tbl_auth.user_type = ref_user_types.user_type_id
                                                        WHERE   tbl_auth.username = :username
                                                        AND     tbl_auth.password = :password
                                                    ",
                                                    {username={value=arguments.login.username, cfsqltype='cf_sql_varchar'}, password={value=arguments.login.password, cfsqltype='cf_sql_varchar'}},
                                                    {datasource=application.dsn}
                                                    );
                if(do_login.recordcount IS 1){
                    if(structkeyexists(session, 'new_o_struct')){
                        structdelete(session,'new_o_struct');
                    }
                    
                    return do_login
                }
                else{
                    return 0;
                }


    }
    function order_status_checker_summary(string user_id){

        var     user_orders     =   QueryExecute("
                                                  SELECT 	tbl_plan_tracker.count,
                                                            tbl_transactions.transaction_id,
                                                            tbl_transactions.completed,
                                                            tbl_transactions.gpx,
                                                            tbl_transactions.date_added,
                                                            tbl_products.prod_name,
                                                            tbl_products.prod_units
                                                    FROM 	tbl_transactions

                                                    INNER JOIN  tbl_plan_tracker ON tbl_transactions.transaction_id = tbl_plan_tracker.trans_id
                                                    INNER JOIN  tbl_products ON tbl_plan_tracker.plan_id = tbl_products.prod_id
                                                    WHERE       tbl_transactions.user_id = #arguments.user_id#  
                                                
                                                    AND         tbl_transactions.completed = 0
                                                ",
                                                {},
                                                {datasource = application.dsn}
                                                );

                                                return user_orders;


    }
    function order_status_checker(string user_id){

        var     user_orders     =   QueryExecute("
                                                  SELECT 	tbl_plan_tracker.count,
                                                            tbl_transactions.transaction_id,
                                                            tbl_transactions.completed,
                                                            tbl_transactions.gpx,
                                                            tbl_transactions.date_added,
                                                            tbl_gpx_routes.gpx_location,
                                                            tbl_gpx_routes.gpx_file_name,
                                                            tbl_products.prod_name,
                                                            tbl_products.prod_units
                                                    FROM 	tbl_plan_tracker

                                                    INNER JOIN  tbl_transactions ON tbl_plan_tracker.trans_id = tbl_transactions.transaction_id
                                                    LEFT JOIN   tbl_gpx_routes ON tbl_transactions.gpx = tbl_gpx_routes.route_id
                                                    LEFT JOIN   tbl_work_product ON tbl_transactions.transaction_id = tbl_work_product.transaction_id
                                                    INNER JOIN  tbl_products ON tbl_plan_tracker.plan_id = tbl_products.prod_id
                                                    WHERE       tbl_plan_tracker.user_id = #arguments.user_id#  
                                                    AND         tbl_transactions.completed = 0
                                                ",
                                                {},
                                                {datasource = application.dsn}
                                                );

                                                return user_orders;


    }
    function credit_checker(string user_id){
        //get uncompleted transactions that are not single use plans.

        var     check_credits   =   QueryExecute("
                                                SELECT  tbl_transactions.transaction_id,
                                                        tbl_transactions.plan_id,
                                                        tbl_plan_tracker.count,
                                                        tbl_products.prod_units,
                                                        tbl_products.prod_name

                                                FROM    tbl_transactions
                                                INNER JOIN tbl_plan_tracker ON tbl_transactions.transaction_id = tbl_plan_tracker.trans_id
                                                INNER JOIN tbl_products ON tbl_transactions.plan_id = tbl_products.prod_id
                                                WHERE   tbl_transactions.completed = 0
                                                AND     tbl_transactions.plan_id <> 1
                                                AND     tbl_transactions.user_id = #arguments.user_id#
                                                ",
                                                {},
                                                {datasource = application.dsn}
                                                );

                        return check_credits;

    }
    function file_mover(struct file_struct){

        //move file
        filemove(arguments.file_struct.s_file, arguments.file_struct.t_file);
        //update new path on gpx record.
        var     update_path         =   QueryExecute("
                                                    UPDATE  tbl_gpx_routes
                                                    SET     tbl_gpx_routes.gpx_location = '#arguments.file_struct.t_file_trans#'
                                                    WHERE   tbl_gpx_routes.route_id     =  #arguments.file_struct.route_id#
                                                        ",
                                                    {},
                                                    {datasource = application.dsn}
                                                    );
    }


}