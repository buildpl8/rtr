<!-- BEGIN #loader -->

<!-- BEGIN #app -->
<div id="app" class="app">
    <!-- BEGIN login -->
    <div class="login login-with-news-feed">
        <!-- BEGIN news-feed -->
        <div class="news-feed">
            <div class="news-image" style="background-image: url('images/show2.jpeg')"></div>
            <div class="news-caption">
                <h4 class="caption-title"><b>Login to</b> Remember the Route</h4>
               
            </div>
        </div>
        <!-- END news-feed -->
        
        <!-- BEGIN login-container -->
        <div class="login-container">
            <!-- BEGIN login-header -->
            <div class="login-header mb-30px">
                <div class="brand">
                    <div class="d-flex align-items-center">
                        <a href="index.cfm?action=landing"><img src="/images/logo_rtr.png" alt="" /></a>
                        
                        
                        <b>Remember</b><br> the Route
                    </div>
                    <small>Login</small>
                </div>
               
            </div>
            <!-- END login-header -->
            
            <!-- BEGIN login-content -->
            <div class="login-content">
                <form action="index.cfm?action=landing.login" method="POST" class="fs-13px">
                    <div class="form-floating mb-15px">
                        <input type="text" class="form-control h-45px fs-13px" placeholder="Email Address" id="username" name="username" />
                        <label for="emailAddress" class="d-flex align-items-center fs-13px text-gray-600">Email Address</label>
                    </div>
                    <div class="form-floating mb-15px">
                        <input type="password" class="form-control h-45px fs-13px" placeholder="Password" id="password" name="password"/>
                        <label for="password" class="d-flex align-items-center fs-13px text-gray-600">Password</label>
                    </div>
                    
                    <div class="mb-15px">
                        <input type="hidden" name="loginState" value="0"/>
                        <button type="submit" class="btn btn-success d-block h-45px w-100 btn-lg fs-14px">Sign me in</button>
                    </div>
                    <div class="mb-40px pb-40px text-dark">
                        Not a member yet? Click <a href="index.cfm?action=landing#pricing" class="text-primary">here</a> to register.
                    </div>
                    <hr class="bg-gray-600 opacity-2" />
                    <div class="text-gray-600 text-center  mb-0">
                        © Copyright Remember the Route <cfoutput>#Year(Now())#</cfoutput> <br />
                    </div>
                </form>
            </div>
            <!-- END login-content -->
        </div>
        <!-- END login-container -->
    </div>
    <!-- END login -->