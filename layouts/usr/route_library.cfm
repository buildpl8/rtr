<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title><Cfoutput>#application.name#</Cfoutput></title>
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />
	
	<!-- ================== BEGIN core-css ================== -->
	<link href="/assets/css/vendor.min.css" rel="stylesheet" />
	<link href="/assets/css/apple/app.min.css" rel="stylesheet" />
	<script src="/assets/plugins/ionicons/dist/ionicons/ionicons.js"></script>
	<!-- ================== END core-css ================== -->
	<link href="/assets/plugins/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" />
	<link href="/assets/plugins/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" />

	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBUjncN8kmonIBkO2bh3b8iT5YDUZ7Be7c&callback=initMap&libraries=drawing&v=weekly" defer></script>

</head>
<body>
	<!-- BEGIN #loader -->
	<div id="loader" class="app-loader">
		<span class="spinner"></span>
	</div>
	<!-- END #loader -->

	<!-- BEGIN #app -->
	<div id="app" class="app app-header-fixed app-sidebar-fixed">


  <cfinclude template="../main/header.cfm"/>

	<cfinclude template="../main/sidebar.cfm"/>
		
		<!-- BEGIN #content -->
		<div id="content" class="app-content">
			<!-- BEGIN breadcrumb -->
      <cfoutput>
        #body#
      </cfoutput>
     
		</div>
		<!-- END #content -->
		
		<!-- BEGIN scroll to top btn -->
		<a href="javascript:;" class="btn btn-icon btn-circle btn-primary btn-scroll-to-top" data-toggle="scroll-to-top"><i class="fa fa-angle-up"></i></a>
		<!-- END scroll to top btn -->
	</div>
	<!-- END #app -->
	
	<!-- ================== BEGIN core-js ================== -->
	<script src="/assets/js/vendor.min.js"></script>
	<script src="/assets/js/app.min.js"></script>
	<!-- ================== END core-js ================== -->
	<script src="/assets/plugins/datatables.net/js/jquery.dataTables.min.js"></script>
	<script src="/assets/plugins/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
	<script src="/assets/plugins/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>

	<!-- script -->
<script>
	$('#routes').DataTable({
	  responsive: true
	});
  </script>
</body>
</html>