component extends="framework.one" {
	 
	 this.name					=		'Remember the Route';
	 this.applicationTimeout 	=		CreateTimeSpan(0,0,5,0);
	 this.sessiontimeout		=		CreateTimeSpan(0,0,30,0);
	 this.sessionmanagement		=		true;
	 this.setclientcookies		=		true;

	
	 this.datasources["rtr"] = {
		// required
	   type: 'mysql'
	   , host: 'host.docker.internal'
	   , database: 'rtr'
	   , port: 3306
	   , username: 'gjl'
	   , password: "mn4545"
	 }


	function onApplicationStart() {
        application.name				=  this.name;
		application.dsn					=	'rtr';
		application.gpx_dir     		=  '/gpx_temp';
        application.user_dir    		=  '/usr';
		application.stripe_pub_key		=	'pk_test_51KstytEgovXn31mavD0WcWYaaf1Z56pA8EGGT51EKWlEf1Zx7PIsIrlPK2gqg6O4qW6sCLoShBX4IrzpHfa8vZay00u0z0Sh11';
		application.stripe_sec_key 		=	'sk_test_51KstytEgovXn31mav3zHV5zJ66wjPZOmJiJi08cKDKKQd33bB6zyzJ2T69x2fHlwlhErSrFwPZ4nH6rZt49Zk1UN00ucckNGV8';
		application.host 				=	'http://localhost:8080/';
		application.reseckey			=	'6LdjfF0kAAAAAMq039vmF108o_sOfGlUt5svSGKZ';
		application.repubkey			=	'6LdjfF0kAAAAAHxRl2FEe6MOIpY7yPcGdzeN9oNF';
    }

	function before(){
		
		
		if(structkeyexists(rc, 'action')){

			if((action CONTAINS 'main') OR (action CONTAINS 'usr') OR (action CONTAINS 'admin') OR (action CONTAINS 'gpxtruder')){
				if(NOT structkeyexists(session, 'user_pyld')){
					location('index.cfm?action=landing.login');
				}
			}
		}
		else{
				location('index.cfm?action=landing');
		}
		

	}
	function after(){


	}

}
