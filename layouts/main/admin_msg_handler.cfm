<div class="navbar-item dropdown">
    <a href="#" data-bs-toggle="dropdown" class="navbar-link dropdown-toggle icon">
        <ion-icon name="notifications"></ion-icon>
        <span class="badge"><cfoutput>#rc.get_site_messages.recordcount#</cfoutput></span>
    </a>
    <div class="dropdown-menu media-list dropdown-menu-end">
        <div class="dropdown-header">NOTIFICATIONS (<cfoutput>#rc.get_site_messages.recordcount#</cfoutput>)</div>
        <cfloop query=#rc.get_site_messages#>
            <cfoutput>
                <a href="javascript:;" class="dropdown-item media">
                
                    <div class="media-body">
                        <h6 class="media-heading">#rc.get_site_messages.user_name#</h6>
                        <p>#rc.get_site_messages.user_msg#</p>
                        <div class="text-muted fs-10px">#DateFormat(rc.get_site_messages.date_Added, 'mm/dd/yyyy')# at #TimeFormat(rc.get_site_messages.date_added, 'HH:MM:SS TT')#</div>
                    </div>
                </a>
            </cfoutput>
        </cfloop>
       
       
      
    </div>
</div>