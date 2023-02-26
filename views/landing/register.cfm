

<div class="content">
<br>
<br>
<br>
    <div class="container">
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
                <cfif NOT structkeyexists(session, 'reg_struct')>
                    <script>
                        function onSubmit(token) {
                          document.getElementById("regForm").submit();
                        }
                      </script>
                    <form id="regForm" action="index.cfm?action=landing.register&buy=<cfoutput>#url.buy#</cfoutput>" method="post" class="form" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-12">
                                <font><h3>Enter Your Account Details, and Upload Your GPX File</h3></font>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                First Name
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="user_first_name" class="form-control"/>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-6">
                                Last Name
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="user_last_name" class="form-control"/>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-6">
                            Email (also your username)
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="user_email" class="form-control"/>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-6">
                                Phone
                            </div>
                            <div class="col-md-6">
                                <input type="text" name="user_phone" class="form-control"/>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                RtR Password
                            </div>
                            <div class="col-md-6">
                                <input type="password" name="user_password" id="user_password" class="form-control" onkeyup="checkPass()"/>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-6">
                                Repeat Password
                            </div>
                            <div class="col-md-6">
                                <input type="password" name="user_password_2" id="user_password_2" class="form-control" onkeyup="checkPass()"/>
                                <span id="confirm-message2" class="confirm-message"></span>
                            </div>
                            
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-6">
                                GPX File
                            </div>
                            <div class="col-md-6">
                                <input type="file" id="gpxfile" name="gpxfile">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-6">
                                <input type="hidden" name="reg_status" value="1"/>
                            </div>
                            <div class="col-md-6">
                                <input type="submit" id="next_btn" value="Next: Caption" class="form-control btn btn-sm btn-primary g-recaptcha" 
                                data-sitekey="<cfoutput>#application.repubkey#</cfoutput>" 
                                data-callback='onSubmit' 
                                data-action='submit'/>
                            </div>
                        </div>
                        <div id="message"></div>
                    </form>
                    <script>
                        document.getElementById("next_btn").disabled = true;
                        function checkPass()
{                           
                            //Store the password field objects into variables ...
                            var password = document.getElementById('user_password');
                            var confirm  = document.getElementById('user_password_2');
                            //Store the Confirmation Message Object ...
                            var message = document.getElementById('confirm-message2');
                            //Set the colors we will be using ...
                            var good_color = "#66cc66";
                            var bad_color  = "#ff6666";
                            //Compare the values in the password field 
                            //and the confirmation field
                            if(password.value == confirm.value){
                                //The passwords match. 
                                //Set the color to the good color and inform
                                //the user that they have entered the correct password 
                                confirm.style.backgroundColor = good_color;
                                message.style.color           = good_color;
                                message.innerHTML             = 'Passwords Match!';
                                document.getElementById("next_btn").disabled = false;
                            }else{
                                //The passwords do not match.
                                //Set the color to the bad color and
                                //notify the user.
                                confirm.style.backgroundColor = bad_color;
                                message.style.color           = bad_color;
                                message.innerHTML             = 'Passwords Do Not Match!';
                            }
                        }  
                    </script>
                <cfelse>
                  
                    <cfif rc.isEmail>

                        <h4>Registered Email Detected</h4>
                        <p>We detected that the email address you entered is already on our system.</p>
                        <p>Welcome Back!  Great news.  You can log into your Remember the Route account and see your previous orders, order reprints, or intiate a new Remember the Route trophy!  </p>  To log in to Remember the Rotue, <a href="index.cfm?action=landing.login">click here</a>.</p>

                    <cfelse>
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
                        <h4>We have validated your GPS route, and will use the following for your trophy.</h4>
                        <P>Enter a caption below to include on your achievement.</P>
                        <div class="row">
                            <div class="col-md-12">
                                <div id="map"></div>
                            </div>
                        </div>
                        <hr>
                        <div class="row">
                            <div class="col-md-2">
                                Caption
                            </div>
                            <div class="col-md-10">
                                <form action="index.cfm?action=landing.payment" method="post">
                                    <input type="text" name="user_caption" class="form-control"/>
                                
                                
                            </div>
                        </div>
                        
                        <br>
                        <div class="row">
                            <div class="col-md-9">
                                <input type="hidden" name="reg_status" value="1"/>
                               
                            </div>
                            <div class="col-md-3">
                                <input type="submit" class="form-control btn btn-sm btn-primary" value="Next: Payment"/>
                            </form>
                            </div>
                        </div>
                    </cfif>
                   
                </cfif>
            </div>
        </div>
    </div>
</div>