<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <title><cfoutput>#application.name#</cfoutput></title>
  <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
  <meta content="" name="description" />
  <meta content="" name="author" />
  
  <!-- ================== BEGIN core-css ================== -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <link href="/landing/assets/css/one-page-parallax/vendor.min.css" rel="stylesheet" />
  <link href="/landing/assets/css/one-page-parallax/app.min.css" rel="stylesheet" />
  <!-- ================== END core-css ================== -->
  
  <!-- OR without vendor.min.css -->
  
  <!-- ================== BEGIN core-css ================== -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
  <link href="/landing/assets/plugins/animate.css/animate.min.css" rel="stylesheet" />
  <link href="/landing/assets/plugins/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" />
  <link href="/landing/assets/plugins/jquery-ui-dist/jquery-ui.min.css" rel="stylesheet" />
  <link href="/landing/assets/plugins/pace-js/themes/black/pace-theme-flash.css" rel="stylesheet" />
  <link href="/landing/assets/plugins/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="/landing/assets/css/one-page-parallax/app.min.css" rel="stylesheet" />
  <!-- ================== END core-css ================== -->

  <link rel="stylesheet" href="/js/stripe/checkout.css" />
  <script src="https://js.stripe.com/v3/"></script>



  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBUjncN8kmonIBkO2bh3b8iT5YDUZ7Be7c&callback=initMap&libraries=drawing&v=weekly" defer></script>
</head>

<body>

<!-- begin #header -->
<div id="header" class="header navbar navbar-fixed-top navbar-expand-lg">
  <!-- begin container -->
  <div class="container">
    <!-- begin navbar-brand -->
    <a href="index.cfm?action=landing" class="navbar-brand">
       <img src="/images/logo_rtr.png" alt="" />
      <span class="brand-text">
        <span class="text-theme"> Remember </span> The Route
      </span>
    </a>
    <!-- end navbar-brand -->
    <!-- begin navbar-toggle -->
    <button type="button" class="navbar-toggle collapsed" data-bs-toggle="collapse" data-bs-target="#header-navbar">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <!-- end navbar-header -->
    <!-- begin navbar-collapse -->
    <div class="collapse navbar-collapse" id="header-navbar">
      <ul class="nav navbar-nav navbar-end">
       
        <li class="nav-item">
          <a class="nav-link" href="index.cfm?action=landing#about" >What is it?</a>
        </li>
     
        <li class="nav-item">
          <a class="nav-link" href="index.cfm?action=landing#work" >Examples</a>
        </li>
       
        <li class="nav-item">
          <a class="nav-link" href="index.cfm?action=landing#pricing" >Pricing</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="index.cfm?action=landing#contact" >Contact</a>
        </li>
        <li class="nav-item">
           
          <a class="nav-link" href="index.cfm?action=landing#pricing" ><button class="btn btn-sm btn-success">Lets Get Started!</button></a>
        </li>
        <li class="nav-item">
           
          <a class="nav-link" href="index.cfm?action=landing.login"><button class="btn btn-sm btn-success">Login</button></a>
        </li>
      </ul>
    </div>
    <!-- end navbar-collapse -->
  </div>
  <!-- end container -->
</div>
<!-- end #header -->


<cfoutput>#body#</cfoutput>
   
<!-- begin #footer -->
<div id="footer" class="footer">
  <div class="container">
    <div class="footer-brand">
      <img src="/images/logo_rtr.png" alt="" />
      Remember the Route
    </div>
    <p>
      © Copyright Remember the Route <cfoutput>#Year(Now())#</cfoutput> <br />
      
    </p>
    <p class="social-list">
      <a href="#"><i class="fab fa-facebook-f fa-fw"></i></a>
      <a href="#"><i class="fab fa-instagram fa-fw"></i></a>
      <a href="#"><i class="fab fa-twitter fa-fw"></i></a>
      <a href="#"><i class="fab fa-google-plus fa-fw"></i></a>
      <a href="#"><i class="fab fa-dribbble fa-fw"></i></a>
    </p>
  </div>
</div>
<!-- end #footer -->
<!-- ================== BEGIN core-js ================== -->
  <script src="/landing/assets/js/one-page-parallax/vendor.min.js"></script>
  <script src="/landing/assets/js/one-page-parallax/app.min.js"></script>
  <!-- ================== END core-js ================== -->
  
  <!-- OR without vendor.min.js  -->
  
  <!-- ================== BEGIN core-js ================== -->
  <script src="/landing/assets/plugins/pace-js/pace.min.js"></script>
  <script src="/landing/assets/plugins/jquery/dist/jquery.min.js"></script>
  <script src="/landing/assets/plugins/jquery-ui-dist/jquery-ui.min.js"></script>
  <script src="/landing/assets/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <script src="/landing/assets/plugins/paroller.js/dist/jquery.paroller.min.js"></script>
  <script src="/landing/assets/plugins/js-cookie/dist/js.cookie.js"></script>
  <script src="/landing/assets/plugins/scrollmonitor/scrollMonitor.js"></script>
  <script src="/landing/assets/js/one-page-parallax/app.min.js"></script>
  <!-- ================== END core-js ================== -->

 
</body>
</html>