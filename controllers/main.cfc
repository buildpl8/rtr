component accessors="true" {

    property beanFactory;
    property formatterService;
	property daoService;
	property utilService;
	
	public any function init( fw ) {
		variables.fw = fw;
		return this;
	}
	
	public void function default( rc ) {
        var instant = variables.beanFactory.getBean( "instant" );
		rc.today = variables.formatterService.longdate( instant.created() );

		if(structkeyexists(url, 'logout')){
			structdelete(session, 'user_pyld');
				location('index.cfm?action=landing.login');

		}
		if(session.user_pyld.user_type IS "User"){
			rc.latest_route 	=	variables.daoService.latest_user_route(session.user_pyld.user_id);
			rc.current_orders	=	variables.utilService.order_status_checker_summary(session.user_pyld.user_id);


		}
		else if(session.user_pyld.user_type IS "Administrator"){
			rc.workq    			=   variables.daoService.view_work_queue();
			rc.get_site_messages 	=   variables.daoService.get_site_messages();
		}
		
		
	}
	
}
