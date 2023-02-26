<div class="content">

    <div class="container">
        <br><br>
        <div class="row">
            <div class="col-md-12">
                <h2><font color="green">We have received your payment <cfoutput>#session.reg_struct.user_first_name#</cfoutput>!  Order details are below.</font></h2>
                <p>Please check your email for a confirmation message from us.  This will validate your email address and enable you to login to the Remember the Route web site!</p>
            </div>
        </div>
        <br>
        <br>
        <div class="row">
            <div class="col-md-4">
                <ul class="pricing-table pricing-col-6">
                    <li class="highlight" data-animation="true" data-animation-type="animate__fadeInUp">
                        <div class="pricing-container">
                            <cfoutput>
                            <h3>#rc.selected_plan.prod_name#</h3>
                                <div class="price">
                                    <div class="price-figure">
                                        <span class="price-number">$#rc.selected_plan.prod_cost#</span>
                                                    
                                    </div>
                                </div>
                                            #rc.selected_plan.prod_desc#
                                            <div class="footer">
                                                <img src="/images/sdrace.jpg" height="75" align="center"/>
                                            </div>
                            </cfoutput>
                        </div>
                    </li>

                </ul>

            </div>
            <div class="col-md-8">
                <style type="text/css">
                    #map {
                    height: 300px;
                    width: 600px;
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
                                
                        fetch('<cfoutput>#session.reg_struct.gpx_file_loc#</cfoutput>')
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
                <h4>We will create one Remember the Route trophy using the route below.</h4>
                <P>We will use the caption.<br>
                    <strong><cfoutput>#session.reg_struct.user_caption#</cfoutput></strong>
                </P>
                <div class="row">
                    <div class="col-md-12">
                        <div id="map"></div>
                    </div>
                </div>
                <hr>
                <div class="row">
                    <div class="col-md-12">
                        <h4>Order Information</h4>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <strong>Billing Information</strong>
                    </div>
                    <div class="col-md-6">
                       <strong> Shipping Information</strong>
                    </div>

                </div>
                <div class="row">
                    <div class="col-md-6">
                        <cfoutput>
                            #rc.checkout_session.content.customer_details.name#<br>
                            #rc.checkout_session.content.customer_details.address.line1#<br>
                            <cfif structkeyexists(rc.checkout_session.content.customer_details.address, 'line2')>
                                #rc.checkout_session.content.customer_details.address.line2#<br>
                            </cfif>
                            
                            #rc.checkout_session.content.customer_details.address.city#, #rc.checkout_session.content.customer_details.address.state#<br>
                            #rc.checkout_session.content.customer_details.address.postal_code#<br>
                        </cfoutput>
                    </div>
                    <div class="col-md-6">
                      
                        <cfoutput>
                            #rc.checkout_session.content.shipping.name#<br>
                            #rc.checkout_session.content.shipping.address.line1#<br>
                            <cfif structkeyexists(rc.checkout_session.content.shipping.address, 'line2')>
                                #rc.checkout_session.content.shipping.address.line2#<br>
                            </cfif>
                            #rc.checkout_session.content.shipping.address.city#, #rc.checkout_session.content.shipping.address.state#<br>
                            #rc.checkout_session.content.shipping.address.postal_code#<br>
                        </cfoutput>
                  
                    </div>
                </div>
               
                <div class="row">
                    <div class="col-md-6">
                        <strong>Remember the Route Login Username:</strong><br>  <cfoutput>#session.reg_struct.user_email#</cfoutput>
                    </div>
                </div>
               
            </div>
     
    </div>

<br><br>
</div>
<!---
<cfdump var="#rc.checkout_session#"/>
<cfdump var="#rc.customer_details#"/>
--->