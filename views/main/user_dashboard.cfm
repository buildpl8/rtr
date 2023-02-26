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
				
		fetch('<cfoutput>#rc.latest_route.gpx_location#</cfoutput>')
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

<div class="row">
	<div class="col-md-6">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">My Latest Route</h4>
				
			</div>
			<div class="panel-body">
					<div id="map"></div>
					<br>
					<div class="row">
						<div class="col-md-6">
							Caption
						</div>
						<div class="col-md-6">
							<cfoutput>
								#rc.latest_route.gpx_caption#
							</cfoutput>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							Date Received
						</div>
						<div class="col-md-6">
							<cfoutput>
								#DateFormat(rc.latest_route.date_added, 'mm/dd/yyyy')#
							</cfoutput>
						</div>
					</div>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Open Order Status</h4>
				
			</div>
			<div class="panel-body">
				<p>Below are your current open orders.</p>
				<cfif rc.current_orders.recordcount GTE 1>
					<table id="ostatus" class="table table-striped table-bordered align-middle">
						<thead>
						  <tr>
							<th>Plan</th>
							<th>Date Recieved</th>
							
							<th>Plan Amount</th>
							<th>Amount Used</th>
							<th>View</th>
						  </tr>	
						</thead>
						<tbody>
							<cfloop query="#rc.current_orders#">
								<cfoutput>
									<tr>
										<td>#rc.current_orders.prod_name#</td>
										<td>#DateFormat(rc.current_orders.date_added, 'mm/dd/yyyy')# </td>
										
										<td>#rc.current_orders.prod_units#</td>
										<td>#rc.current_orders.count#</td>
										<td><a href="index.cfm?action=usr.order_viewer&trans_id=#rc.current_orders.transaction_id#"><button class="btn btn-sm btn-primary">View</button></a></td>
									</tr>
								</cfoutput>
							</cfloop>
						</tbody>
					  </table>
				</cfif>
			</div>
		</div>
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Quick Links</h4>
				
			</div>
			<table class="table table-panel mb-0">
				<tbody>
					<tr>
						<td align="center">
							<a href="index.cfm?action=usr.new_order"><button class="btn btn-sm btn-primary pull-right">New Trophy</button></a>
						</td>
						<td align="center">
							<button class="btn btn-sm btn-primary pull-right">View Account</button>
						</td>
						<td align="center">
							<a href="index.cfm?action=usr.route_library"><button class="btn btn-sm btn-primary pull-right">Route Library</button></a>
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
	</div>
</div>
