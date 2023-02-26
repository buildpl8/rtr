<div class="row">
	<div class="col-md-6">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Logs</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<div class="panel-body">
				
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Service Statistics</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<div class="panel-body">
				
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Inbound Work Queue</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<div class="panel-body">
				<table id="workq" class="table table-striped table-bordered align-middle">
					<thead>
					  <tr>
						<th>GPX File</th>
						<th>Date Recieved</th>
						<th>Transaction Amount</th>
						<th>User</th>
						<th>Process</th>
					  </tr>	
					</thead>
					<tbody>
						<cfloop query="#rc.workq#">
							<cfoutput>
								<tr>
									<td>#rc.workq.gpx_file_name#</td>
									<td>#DateFormat(rc.workq.date_added, 'mm/dd/yyyy')# at #TimeFormat(rc.workq.date_added, 'hh:mm:ss tt')#</td>
									<td>$#Evaluate(rc.workq.trans_amount / 100)#</td>
									<td>#rc.workq.username#</td>
									<td><a href="index.cfm?action=admin.process_file&trans_id=#rc.workq.transaction_id#"><button class="btn btn-sm btn-primary">Process</button></a></td>
								</tr>
							</cfoutput>
						</cfloop>
					</tbody>
				  </table>
			</div>
		</div>
	</div>
</div>