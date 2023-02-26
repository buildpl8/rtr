<style type="text/css">
	#map {
	height: 300px;
	width: 475px;
	}
</style>

<script>
	function initMap() {    
		const map = new google.maps.Map(document.getElementById("map"), {
			zoom: 3,
			center: { lat: 0, lng: -180 },
			mapTypeId: "hybrid",
			disableDefaultUI: true,
			
		});
				
		fetch('<cfoutput>#rc.transaction.gpx_location#</cfoutput>')
			.then(response => response.text())
			.then(str => (new window.DOMParser()).parseFromString(str, "text/xml"))
			//.then(data => console.log(data))
			.then(doc =>
			{
				var points = [];
				var bounds = new google.maps.LatLngBounds();
			
				const nodes = [...doc.getElementsByTagName('trkpt')];
				nodes.forEach(node =>
				{
					var lat = node.getAttribute("lat");
					var lon = node.getAttribute("lon");
					//console.log(lat);
					
					var p = new google.maps.LatLng(lat, lon);
					points.push(p);
					bounds.extend(p);
				})
				
				var poly = new google.maps.Polyline({
						path: points,
						strokeColor: "#0000FF",
						strokeOpacity: 1,
						strokeWeight: 4
					});
					poly.setMap(map);
					// fit bounds to track
					map.fitBounds(bounds);
			})
	}
</script>

<h1 class="page-header">Process Client Order</h1>

<a href="index.cfm?action=admin.workq"><button class="btn btn-primary pull-right">Work Queue</button></a>
<hr>
<!-- BEGIN panel -->
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Uploaded Route GPX</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-12">
						<Div id="map"></Div>
					</div>
				</div>
				<cfoutput>
				<div class="row">
					<div class="col-md-12">
						<h4>Caption:  #rc.transaction.gpx_caption#</h4>
					</div>
				</div>
			</cfoutput>
			</div>
		</div>
	</div>
	<div class='col-md-6'>
		<h3>Processing Flow</h3>  Complete each step below, in order to complete client work output
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Create Work Files</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<cfoutput>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-12">
						Download the file below and use GPXTruder to create appropriate STL and PNG support files for this client.
						<hr>
					</div>
				
				</div>
				<div class="row">
					<div class="col-md-6">
						File to Process:  <a href='#rc.transaction.gpx_location#'>#rc.transaction.gpx_file_name#</a>
						
					</div>
					<div class="col-md-6" align="center">
						<a href="index.cfm?action=gpxtruder" target="_gpxtruder"><button class="btn btn-lg btn-primary">Launch GPXTruder</button></a>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12">
						
					</div>
				</div>
			
			</div>
			
			</cfoutput>
		</div>
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Upload Work Files</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<cfoutput>
			<div class="panel-body">
				<cfif rc.is_Configured>
					<div class="row">
						<div class="col-md-12">
							Uploaded Work Files
							
							<hr>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="col-md-6">
								<strong>STL File Upload</strong>
							</div>
							
							<div class="col-md-6">
								
								<a href="#rc.work_item.stl_loc#">#rc.work_item.stl_file#</a>
							</div>
					
						</div>
						<div class="col-md-6">
							<div class="col-md-6">
								<strong>Map File Upload</strong>
							</div>
							
							<div class="col-md-6">
								
								<a href="#rc.work_item.map_loc#">#rc.work_item.map_file#</a>
							</div>
					
						</div>
					</div>
				<cfelse>
				<div class="row">
					<div class="row">
						<div class="col-md-12">
							Upload the resulting work files created above.
							<hr>
						</div>
					</div>
					<div class="col-md-6">
						<form action="index.cfm?action=admin.process_file&trans_id=#url.trans_id#" method="post" enctype="multipart/form-data">
							<div class="row">
								<div class="col-md-12">
									<strong>STL File Upload</strong>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									
									<input type="file" name="stl_upload" class="form-control"/>
								</div>
							</div>
						
						
					</div>
					<div class="col-md-6">
					
						<div class="row">
							<div class="col-md-12">
								<strong>Map File Upload</strong>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<input type="hidden" name="ul_type" value="ul"/>
								<input type="file" name="map_upload" class="form-control"/>
							</div>
						</div>
						
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-12">
						<input type="submit" value="Upload" class="form-control btn btn-primary"/>
					</div>
				</div>
			</form>
			</cfif>
			</div>
			
			</cfoutput>
		</div>
	</div>

</div>
<div class="row">
	<div class="col-md-6">
		<div class="panel panel-inverse">
				<div class="panel-heading">
					<h4 class="panel-title">Order Details</h4>
					<div class="panel-heading-btn">
						<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
						<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
						<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
						
					</div>
				</div>
				<div class="panel-body">
					<cfoutput>
						<div class="row">
							<div class="col-md-6">
								Customer
							</div>
							<div class="col-md-6">
								#rc.transaction.user_first_name# #rc.transaction.user_last_name#
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								Email/Username
							</div>
							<div class="col-md-6">
								#rc.transaction.username#
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								Date of Order
							</div>
							<div class="col-md-6">
								#DateFormat(rc.transaction.date_added, 'mm/dd/yyyy')# at #TimeFormat(rc.transaction.date_added, 'hh:mm:ss tt')#
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								Transaction Amount
							</div>
							<div class="col-md-6">
								$#Evaluate(rc.transaction.trans_amount / 100)# 
							</div>
						</div>
						
					</cfoutput>
				</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Upload Work Product</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<cfif (rc.is_Configured) AND (NOT rc.work_item.pic_file IS "")>
				<cfoutput>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							Completed Product Photo
							<hr>
						</div>
					
					</div>
					<div class="row">
						<div class="col-md-6">
							<img src="#rc.work_item.pic_loc#" class="img-fluid">
						</div>
						
					</div>
					
					<div class="row">
						<div class="col-md-12">
							
						</div>
					</div>
				
				</div>
			</cfoutput>
			<cfelse>
			<cfoutput>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-12">
						Upload a picture of the finished product.
						<hr>
					</div>
				
				</div>
				<div class="row">
					<div class="col-md-6">
						<form action="index.cfm?action=admin.process_file&trans_id=#rc.transaction.transaction_id#" method="post" enctype="multipart/form-data">
							<input type="file" name="output_pic" class="form-control" />
						
					</div>
					<div class="col-md-6" align="center">
						<input type="hidden" name="ul_pic" value="true"/>
							<input type="submit" value="Upload" class="btn btn-sm btn-primary form-control"/>
					</div>
					</form>
				</div>
				
				<div class="row">
					<div class="col-md-12">
						
					</div>
				</div>
			
			</div>
			
			</cfoutput>
			</cfif>
		</div>
	</div>
	
</div>

