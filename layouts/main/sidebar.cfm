<!-- BEGIN #sidebar -->
<div id="sidebar" class="app-sidebar">
  <!-- BEGIN scrollbar -->
  <div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
    <!-- BEGIN menu -->
    <cfoutput>
    <div class="menu">
      <div class="menu-profile">
        <a href="javascript:;" class="menu-profile-link" data-toggle="app-sidebar-profile" data-target="##appSidebarProfileMenu">
          <div class="menu-profile-cover with-shadow"></div>
         
          <div class="menu-profile-info">
            <div class="d-flex align-items-center">
              <div class="flex-grow-1">
                #session.user_pyld.user_first_name# #session.user_pyld.user_last_name#
              </div>
              <div class="menu-caret ms-auto"></div>
            </div>
            <small>#session.user_pyld.user_type#</small>
          </div>
        </a>
      </div>
      <div id="appSidebarProfileMenu" class="collapse">
        <div class="menu-item pt-5px">
          <a href="javascript:;" class="menu-link">
            <div class="menu-icon"><i class="fa fa-cog"></i></div>
            <div class="menu-text">Profile</div>
          </a>
        </div>
        <div class="menu-item">
          <a href="javascript:;" class="menu-link">
            <div class="menu-icon"><i class="fa fa-pencil-alt"></i></div>
            <div class="menu-text"> Billing</div>
          </a>
        </div>
        <div class="menu-item pb-5px">
          <a href="javascript:;" class="menu-link">
            <div class="menu-icon"><i class="fa fa-question-circle"></i></div>
            <div class="menu-text"> Help</div>
          </a>
        </div>
        <div class="menu-divider m-0"></div>
      </div>
      <div class="menu-header">Navigation</div>
      <div class="menu-item active">
        <a href="index.cfm?action=main" class="menu-link">
          <div class="menu-icon">
            <i class="ion-ios-pulse"></i>
          </div>
          <div class="menu-text">Home</div>
        </a>
      </div>
      <cfif session.user_pyld.user_type  IS "Administrator">
          <div class="menu-item has-sub">
            <a href="javascript:;" class="menu-link">
              <div class="menu-icon">
                <ion-icon name="cog-outline"></ion-icon>
              </div>
              <div class="menu-text">Production</div>
              <div class="menu-caret"></div>
            </a>
            <div class="menu-submenu">
              
              <div class="menu-item"><a href="index.cfm?action=admin.workq" class="menu-link"><div class="menu-text">Work Queue</div></a></div>
              <div class="menu-item"><a href="javascript:;" class="menu-link"><div class="menu-text">Shipping Queue</div></a></div>
            </div>
          </div>
          <div class="menu-item has-sub">
            <a href="javascript:;" class="menu-link">
              <div class="menu-icon">
                <ion-icon name="person-outline"></ion-icon>
              </div>
              <div class="menu-text">Customers</div>
              <div class="menu-caret"></div>
            </a>
            <div class="menu-submenu">
              
              <div class="menu-item"><a href="index.cfm?action=admin.customers" class="menu-link"><div class="menu-text">Customers</div></a></div>
              <div class="menu-item"><a href="javascript:;" class="menu-link"><div class="menu-text">Reporting</div></a></div>
            </div>
          </div>
        <cfelseif session.user_pyld.user_type IS "User">
          <div class="menu-item has-sub">
            <a href="javascript:;" class="menu-link">
              <div class="menu-icon">
                <ion-icon name="cog-outline"></ion-icon>
              </div>
              <div class="menu-text">Routes</div>
              <div class="menu-caret"></div>
            </a>
            <div class="menu-submenu">
              
              <div class="menu-item"><a href="index.cfm?action=usr.route_library" class="menu-link"><div class="menu-text">Route Library</div></a></div>
              <div class="menu-item"><a href="index.cfm?action=usr.new_order"  class="menu-link"><div class="menu-text">New Route</div></a></div>
            </div>
          </div>
          <div class="menu-item has-sub">
            <a href="javascript:;" class="menu-link">
              <div class="menu-icon">
                <ion-icon name="person-outline"></ion-icon>
              </div>
              <div class="menu-text">Orders</div>
              <div class="menu-caret"></div>
            </a>
            <div class="menu-submenu">
              
              <div class="menu-item"><a href="javascript:;" class="menu-link"><div class="menu-text">Completed Orders</div></a></div>
              <div class="menu-item"><a href="javascript:;" class="menu-link"><div class="menu-text">Upcoming Orders</div></a></div>
            </div>
          </div>
      </cfif>
    </cfoutput>
      <!-- BEGIN minify-button -->
      <div class="menu-item d-flex">
        <a href="javascript:;" class="app-sidebar-minify-btn ms-auto" data-toggle="app-sidebar-minify"><i class="ion-ios-arrow-back"></i> <div class="menu-text">Collapse</div></a>
      </div>
      <!-- END minify-button -->
     
    </div>
    <!-- END menu -->
  </div>
  <!-- END scrollbar -->
</div>
<div class="app-sidebar-bg"></div>
<div class="app-sidebar-mobile-backdrop"><a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a></div>
<!-- END #sidebar -->