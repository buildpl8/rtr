<h4>Route Library</h4>


<div class="row">
    <div class="col-md-12">
        <div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Open Order Status</h4>
				
			</div>
			<div class="panel-body">
                <table id="routes" class="table table-striped table-bordered align-middle">
                    <thead>
                      <tr>
                        <th>GPS Route</th>
                        <th>Date Recieved</th>
                        
                       
                        <th>View</th>
                      </tr>	
                    </thead>
                    <tbody>
                        <cfloop query="#rc.routes#">
                            <cfoutput>
                                <tr>
                                    <td>#rc.routes.gpx_file_name# - <em>#rc.routes.gpx_caption#</em></td>
                                    <td>#DateFormat(rc.routes.date_added, 'mm/dd/yyyy')# </td>
                                   
                                    <td><a href="index.cfm?action=usr.route_library&route_id=#rc.routes.route_id#"><button class="btn btn-sm btn-primary">View Route</button></a></td>
                                </tr>
                            </cfoutput>
                        </cfloop>
                    </tbody>
                  </table>

            </div>
        </div>
    </div>
    
</div>
