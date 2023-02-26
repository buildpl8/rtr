<ol class="breadcrumb float-xl-end">

	<li class="breadcrumb-item active">Home</li>
</ol>
<!-- END breadcrumb -->
<!-- BEGIN page-header -->
<h1 class="page-header">Welcome To Remember The Route <cfoutput>#session.user_pyld.user_first_name#</cfoutput></h1>

<!-- END page-header -->

<!-- BEGIN panel -->
<cfif session.user_pyld.user_type IS "Administrator">
	<cfinclude template="admin_dashboard.cfm"/>
<cfelse>
	<cfinclude template="user_dashboard.cfm"/>
</cfif>
<!-- END panel -->
