component accessors="true" {

    property beanFactory;
    property formatterService;
    property landingService;
    property utilService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	function default( rc ) {
      
        rc.products     =   variables.landingService.get_products_for_landing();

        if(structkeyexists(url, 'msg')){

            //trap G-Captcha response and validated.  pass to rc.
            cfhttp(method="POST", charset="utf-8", url="https://www.google.com/recaptcha/api/siteverify", result="Response") {
                cfhttpparam(name="secret", type="form", value=application.reseckey);
                cfhttpparam(name="response", type="form", value=FORM['g-recaptcha-response']);
            }

            rc.g_response                       =       deserializeJSON(Response.FileContent);
            if(rc.g_response.success){
                rc.cap      =   true;
            }
            else{
                location(url='index.cfm?action=landing');
            }

            var     msg_struct      =   {};
            msg_struct.user_name    =   form.user_name;
            msg_struct.user_email   =   form.user_email;
            msg_struct.user_msg     =   form.user_message;

            var     do_insert       =   variables.landingService.intake_web_msg(msg_struct);

        }

	}

    function register(struct rc){

        if(structkeyexists(form, 'reg_status')){
            if(reg_status IS 1){
                rc.selected_plan    =   variables.landingService.get_plan(url.buy);

                //check to see if the email exists on the system

                rc.isEmail          =   variables.landingService.check_email(trim(form.user_email));
                
                //trap G-Captcha response and validated.  pass to rc.
                cfhttp(method="POST", charset="utf-8", url="https://www.google.com/recaptcha/api/siteverify", result="Response") {
                    cfhttpparam(name="secret", type="form", value=application.reseckey);
                    cfhttpparam(name="response", type="form", value=FORM['g-recaptcha-response']);
                }

                rc.g_response                       =       deserializeJSON(Response.FileContent);
                if(rc.g_response.success){
                    rc.cap      =   true;
                }
                else{
                    location(url='index.cfm?action=landing');
                }

                if(rc.isEmail){
                    var reg_struct                  =       {};
                    reg_struct.user_email           =       form.user_email;
                    reg_struct.selected_plan        =       rc.selected_plan;
                    reg_struct.user_first_name      =       form.user_first_name;
                    reg_struct.user_last_name       =       form.user_last_name;
                    reg_struct.user_email           =       form.user_email;
                    reg_struct.user_phone           =       form.user_phone;
                    reg_struct.user_password        =       form.user_password;

                

                    //instantiate the registration in session
                    session.reg_struct              =       reg_struct;
                }
                else{
                    //populate a structure of user information
                    var reg_struct                  =       {}; 
                    reg_struct.selected_plan        =       rc.selected_plan;
                    reg_struct.user_first_name      =       form.user_first_name;
                    reg_struct.user_last_name       =       form.user_last_name;
                    reg_struct.user_email           =       form.user_email;
                    reg_struct.user_phone           =       form.user_phone;
                    reg_struct.user_password        =       form.user_password;

                    //handle the gpx file upload.
                    var gpx_ul 						=	    fileUpload(expandpath(application.gpx_dir), "form.gpxfile", " ", "makeunique");

                        if(gpx_ul.serverfile CONTAINS " "){
                            var     s_file          =       Replace(gpx_ul.serverfile, " ", "_", "ALL");
                            var     s_loc_old       =       application.gpx_dir & "/" & gpx_ul.serverfile;
                            var     s_loc_new       =       application.gpx_dir & "/" & s_file;

                                                            fileMove(expandPath(s_loc_old), expandpath(s_loc_new));

                            reg_struct.gpx_file		=       s_file;
                        }
                        else{
                            reg_struct.gpx_file		=       gpx_ul.serverfile;
                        }
                            reg_struct.gpx_file_loc	=       application.gpx_dir & "/" & reg_struct.gpx_file;

                    //instantiate the registration in session
                    session.reg_struct              =       reg_struct;
                    }

                

            }
            
        }
        else{
            if(structkeyexists(url, 'buy')){
                structDelete(session, "reg_struct");
                
                rc.selected_plan    =   variables.landingService.get_plan(url.buy);
            }
           
        }

       

        


    }
	function payment(struct rc){

        if(structkeyexists(form, 'reg_status')){

            if(form.reg_status IS 1){
                session.reg_struct.user_caption     =   form.user_caption;
                rc.selected_plan    =   variables.landingService.get_plan(session.reg_struct.selected_plan.prod_id);
                

                //inbound stripe payment information 
                stripe = new stripecfml.stripe(
                                                    apiKey = application.stripe_sec_key,
                                                    config = {
                                                        defaultCurrency: 'usd',
                                                        convertTimestamps: true,
                                                        convertToCents: false
                                                    }
                                                );
                                           
                                                var conv_cost = session.reg_struct.selected_plan.prod_cost * 100;
                                                var price_obj   =   rc.selected_plan.price_obj;
                                            
                                               
                                                var checkout_session    =   stripe.checkout.sessions.create({
                                                    line_items: [
                                                        {
                                                            price: price_obj,
                                                            quantity: 1,
                                                    },
                                                    ],
                                                    mode: 'payment',
                                                    success_url:    application.host & 'index.cfm?action=landing.success',
                                                    cancel_url:   application.host & 'index.cfm?action=landing',
                                                    automatic_tax: {enabled: true},
                                                    billing_address_collection: 'required',
                                                    shipping_address_collection: {allowed_countries: ['US']},
                                                    
                                                });

                                                session.reg_struct.checkout_session =   checkout_session.content.id;
                                                session.reg_struct.payment_intent   =   checkout_session.content.payment_intent;
                                                

                                                //rc.checkout_session = checkout_session;

                                                location(checkout_session.content.url, 'false');
                                               
            }
            else if(form.reg_status IS 2){

                


            }

        }



    }
    function success (struct rc){

        rc.selected_plan    =   variables.landingService.get_plan(session.reg_struct.selected_plan.prod_id);
        //get the checkout session.

        stripe = new stripecfml.stripe(
                                                    apiKey = application.stripe_sec_key,
                                                    config = {
                                                        defaultCurrency: 'usd',
                                                        convertTimestamps: true,
                                                        convertToCents: false
                                                    }
                                                );

                rc.checkout_session     =   stripe.checkout.sessions.retrieve(session.reg_struct.checkout_session);
                rc.customer_details     =   stripe.customers.retrieve(rc.checkout_session.content.customer);
                //set up the user on the system
                var     user_struct                 =   {};
               user_struct.billing_name             =   rc.customer_details.content.name;
               user_struct.billing_address_line1    =   rc.checkout_session.content.customer_details.address.line1;

               if(structkeyexists(rc.checkout_session.content.customer_details.address, 'line2')){
                user_struct.billing_address_line2    =   rc.checkout_session.content.customer_details.address.line2;
               }
               else{
                user_struct.billing_address_line2    =   '';
               }

               user_struct.billing_city             =   rc.checkout_session.content.customer_details.address.city;
               user_struct.billing_state            =   rc.checkout_session.content.customer_details.address.state;
               user_struct.billing_zip              =   rc.checkout_session.content.customer_details.address.postal_code;
               user_struct.billing_country          =   rc.checkout_session.content.customer_details.address.country;
               
               user_struct.shipping_name             =   rc.checkout_session.content.shipping.name
               user_struct.shipping_address_line1    =   rc.checkout_session.content.shipping.address.line1;

               if(structkeyexists(rc.checkout_session.content.shipping.address, 'line2')){
                    user_struct.shipping_address_line2    =   rc.checkout_session.content.shipping.address.line2;
               }
               else{
                    user_struct.shipping_address_line2    =    '';
               }
              
               user_struct.shipping_name             =   rc.checkout_session.content.shipping.name;
               user_struct.shipping_city             =   rc.checkout_session.content.shipping.address.city;
               user_struct.shipping_state            =   rc.checkout_session.content.shipping.address.state;
               user_struct.shipping_zip             =   rc.checkout_session.content.shipping.address.postal_code;
               user_struct.shipping_country          =   rc.checkout_session.content.shipping.address.country;

               user_struct.stripe_cust_id            =   rc.checkout_session.content.customer;
               user_struct.checkout_id               =   rc.checkout_session.content.id;
               user_struct.payment_intent_id         =   rc.checkout_session.content.payment_intent;
               user_struct.trans_amount              =   rc.checkout_session.content.amount_total;
               user_struct.trans_subtotal            =   rc.checkout_session.content.amount_subtotal;
               
               user_struct.selected_plan             =   rc.selected_plan.prod_id;
               user_struct.user_first_name           =   session.reg_struct.user_first_name;
               user_struct.user_last_name            =   session.reg_struct.user_last_name;
               user_struct.user_email                =   session.reg_struct.user_email;
               user_struct.user_password             =   session.reg_struct.user_password;
               user_struct.user_phone                =   session.reg_struct.user_phone;
              

               user_struct.gpx_file_loc              =   session.reg_struct.gpx_file_loc;
               user_struct.gpx_file                  =   session.reg_struct.gpx_file;
               user_struct.user_caption              =   session.reg_struct.user_caption;

               //do the insert function
               var  do_user_setup                     =   variables.landingService.setup_initial_customer(user_struct);

    }
    function login(struct rc){
        //reject an incomplete form.
        if(structkeyexists(form, 'loginstate')){
            if(NOT structkeyexists(form,'username')){
                location('index.cfm?action=landing.login');
            }
            if(NOT structkeyexists(form, 'password')){
                location('index.cfm?action=landing.login');
            }
        //process the login
        var     login_struct        =       {};
        login_struct.username       =       trim(form.username);
        login_struct.password       =       trim(form.password);
        login_struct.login_state    =       form.loginstate;   
            var     do_login        =       variables.utilService.process_login(login_struct);
                if(NOT IsQuery(do_login)){
                    location('index.cfm?action=landing.login');
                }
                else{
                    session.user_pyld                       =   {};
                    session.user_pyld.username              =   do_login.username;
                    session.user_pyld.password              =   do_login.password;
                    session.user_pyld.user_type             =   do_login.user_type;
                    session.user_pyld.user_first_name       =   do_login.user_first_name;
                    session.user_pyld.user_id               =   do_login.user_id;
                    session.user_pyld.user_last_name        =   do_login.user_last_name;
                    session.user_pyld.user_address_line1    =   do_login.user_address_line1;
                    session.user_pyld.user_address_line2    =   do_login.user_address_line2;
                    session.user_pyld.user_city             =   do_login.user_city;
                    session.user_pyld.user_state            =   do_login.user_state;
                    session.user_pyld.user_zip              =   do_login.user_zip;
                    session.user_pyld.user_country          =   do_login.user_country;
                    session.user_pyld.stripe_cust_id        =   do_login.stripe_cust_id;
                    session.user_pyld.user_type_id          =   do_login.user_type_id;
                        location('index.cfm?action=main');
                }
               
        }



    }
}