<div class="row">
    <div class="col-md-6">
        <div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Order A New Trophy</h4>
				
			</div>
			<div class="panel-body">
				<cfif session.has_open_plans>
                    <div class="alert alert-success alert-dismissible fade show">
                        <strong>You Have Open Credits!</strong>
                        <br>
                        Select a plan to use for your order below:
                        <br>
                        <table class="table">
                            <cfloop query=#rc.open_plans#>
                                <tr>
                                    <td>Plan</td>
                                    <td>Trophies Left</td>
                                    <td>Use Plan</td>
                                </tr>
                                <cfoutput>
                                    <tr>
                                        <td>#rc.open_plans.prod_name#</td>
                                        <td>#evaluate(rc.open_plans.prod_units - rc.open_plans.count)#</td>
                                        <td><a href="index.cfm?action=usr.new_order&use_trans=#rc.open_plans.transaction_id#"><button class="btn btn-sm btn-primary">Apply</button></a></td>
                                    </tr>
                                </cfoutput>
                            </cfloop>
                        </table>
                        
                       
                    </div>
                <cfelse>
                    <cfif NOT structkeyexists(session.new_o_struct, 'gpx_file_loc')>

                    
                        <cfif structkeyexists(rc,'transaction')>
                            <div class="alert alert-success alert-dismissible fade show">
                                <cfoutput>
                                    <strong>Using Plan:  #rc.transaction.prod_name#</strong>
                                    <br>
                                    Purchased On:       #DateFormat(rc.transaction.date_added, 'mm/dd/yyyy')#
                                    <br>
                                    Purchases Left:     #Evaluate(rc.transaction.prod_units - rc.transaction.count)#
                                </cfoutput>
                            
                            </div>
                        </cfif>
                        <div class="row">
                            <div class="col-md-12">
                                <ul class="nav nav-tabs"  style="background:silver">
                                    <li class="nav-item">
                                        <a href="#ul" data-bs-toggle="tab" class="nav-link active">Upload New</a>
                                       
                                    </li>
                                    <li class="nav-item">
                                        <a href="#lib" data-bs-toggle="tab" class="nav-link ">Route Library</a>
                                       
                                    </li>
                                  </ul>
                                  <div class="tab-content panel p-3 rounded-0 rounded-bottom">
                                    <div class="tab-pane fade active show" id="ul">
                                        <form action="index.cfm?action=usr.new_order&new=true" class="form" method="post" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <h4>Upload and Caption Your New Achievement!</h4>
                                                </div>
                                            </div>
                                            <hr>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    GPX File
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="file" id="gpxfile" name="gpxfile" class="form-control">
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    Caption
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="text" id="caption" name="caption" class="form-control">
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    
                                                </div>
                                                <div class="col-md-8">
                                                    <input type="submit" value='Preview' class="form-control btn btn-sm btn-primary">
                                                </div>
                                            </div>
                                            </form>
                                    </div>
                                  </div>
                                  <div class="tab-content panel p-3 rounded-0 rounded-bottom">
                                    <div class="tab-pane fade show" id="lib">
                                        <form action="index.cfm?action=usr.new_order" method="post">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <p>Select a pre-existing route from your route library and click continue to preview your achievment.</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <select  name="route_id" class="form-select">
                                                        <cfloop query="#rc.routes#">
                                                            <cfoutput>
                                                                <option value="#rc.routes.route_id#">#rc.routes.gpx_file_name# - " #rc.routes.gpx_caption# "</option>
                                                            </cfoutput>
                                                        </cfloop>
                                                    </select>
                                                    <br>
                                                    <input type="submit" value="Preview" class="form-control btn btn-sm btn-primary">
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                  </div>
        
                            </div>
                        </div>
                       

                        

                    <cfelse>
                        <!---Output the uploaded GPX File--->

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
                                        
                                fetch('<cfoutput>#session.new_o_struct.gpx_file_loc#</cfoutput>')
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
                        <cfif structkeyexists(form, 'confirm')>
                            <div class="row">
                                <div class="col-md-12" align="center">
                                    <h5>We Have Recieved Your Order!</h5>
                                    Thanks for your new trophy order.  We will get right to work on it.  To view it's status, select it under this transaction.
                                </div>
                            </div>
                            <hr>
                        <cfelse>
                        
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <h5>Awesome!</h5>
                                        Thanks for your new trophy order.  Below is the route we will process with the caption you selected.  If everything looks correct, click "Confirm" to begin processing!  If you would like to start over, click "Cancel Order".
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <div id="map"></div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <h4><cfoutput>#session.new_o_struct.caption#</cfoutput></h4>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <form class="form" action="index.cfm?action=usr.new_order" method="post">
                                            <input type="hidden" value="true" name="confirm">
                                            <input type="submit" class="form-control btn btn-sm btn-primary" value="Confirm"> 
                                        </form>
                                    </div>
                                </div>
                                <br><br>
                                <div class="row">
                                    <div class="col-md-12" align="center">
                                        <form class="form" action="index.cfm?action=usr.new_order" method="post">
                                            <input type="hidden" value="true" name="cancel">
                                            <input type="submit" class="form-control btn btn-sm btn-danger" value="Cancel Order"> 
                                        </form>
                                    </div>
                                </div>
                        </cfif>
                    </cfif>
                </cfif>
			</div>
		</div>
    </div>
</div>
<!---
        <cfdump var="#session#"/>
        <cfdump var="#rc.open_plans#"/>
--->

