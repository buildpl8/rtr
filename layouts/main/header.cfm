		<!-- BEGIN #header -->
		<div id="header" class="app-header">
			<!-- BEGIN navbar-header -->
			<div class="navbar-header">
				<a href="index.html" class="navbar-brand"><span class="navbar-logo"><i class="ion-ios-cloud"></i></span>Remember The Route</a> 
				<button type="button" class="navbar-mobile-toggler" data-toggle="app-sidebar-mobile">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>
			<!-- END navbar-header -->
			<!-- BEGIN header-nav -->
			<div class="navbar-nav">
				<cfif session.user_pyld.user_type IS "Administrator">
					<cfinclude template="admin_msg_handler.cfm"/>
				</cfif>
				
				<div class="navbar-item">
					<a href="index.cfm?action=main&logout=true" class="navbar-link">
						<button class="btn btn-sm btn-danger">Logout</button>
					</a>
				</div>
			</div>
			<!-- END header-nav -->
		</div>
		<!-- END #header -->