

<h4>Order Viewer</h4>

<div class="row">
    <div class="col-md-6">
        <div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Order Information</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
            <table class="table table-panel mb-0">
                <cfoutput>
                <thead>
                    <tr>
                        <th colspan="2">Your Order On #DateFormat(rc.transaction.date_added, 'mm/dd/yyyy')#</th>
                    </tr>
                </thead>
                <tbody>
                
                    <tr>
                        <td>User</td>
                        <td>#rc.transaction.user_first_name# #rc.transaction.user_last_name#</td>
                    </tr>
                    <tr>
                        <td>Email/Username</td>
                        <td>#rc.transaction.username# </td>
                    </tr>
                    <tr>
                        <td>Billing Address</td>
                        <td>#rc.transaction.user_address_line1# <br> #rc.transaction.user_address_line2# <br> #rc.transaction.user_city#, #rc.transaction.user_state# <br> #rc.transaction.user_zip# #rc.transaction.user_country#</td>
                    </tr>
                    <tr>
                        <td>Shipping Address</td>
                        <td>#rc.transaction.ship_address_line1# <br> #rc.transaction.ship_address_line2# <br> #rc.transaction.ship_city#, #rc.transaction.ship_state# <br> #rc.transaction.ship_zip# </td>
                    </tr>
                    <tr>
                        <td><strong>Plan Selected</strong></td>
                        <td><strong>#rc.transaction.prod_name# </strong></td>
                    </tr>
                    <tr>
                        <td>Amount Charged</td>
                        <td>$ #Evaluate(rc.transaction.trans_amount / 100)# </td>
                    </tr>
                </tbody>
                </cfoutput>
            </table>
        </div>

    </div>
    <div class="col-md-6">
        <div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Route Processing</h4>
				<div class="panel-heading-btn">
					<a href="javascript:;" class="btn btn-xs btn-icon btn-default" data-toggle="panel-expand"><i class="fa fa-expand"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-success" data-toggle="panel-reload"><i class="fa fa-redo"></i></a>
					<a href="javascript:;" class="btn btn-xs btn-icon btn-warning" data-toggle="panel-collapse"><i class="fa fa-minus"></i></a>
					
				</div>
			</div>
			<table class="table table-panel mb-0">
                <thead>
                    <tr>
                        <th colspan="2">Orders</th>
                    </tr>
                </thead>
                <tbody>
                    <cfif rc.routes.recordcount IS 0>
                        <tr>
                            <td class="align-middle"> <font color="red">No Routes Processing Yet</font></td>
                            <td width="1%"></td>
                        </tr>
                       
                    <cfelse>
                        <cfloop query=#rc.routes#>
                            <cfoutput>
                                <tr>
                                    <td class="align-middle">Order ID: #rc.routes.wp_id# / <cfif rc.routes.completed IS 0>Processing<cfelse>Completed</cfif> </td>
                                    <td width="1%"><button class="btn btn-sm btn-primary">View</button></td>
                                </tr>
                            </cfoutput>
                        </cfloop>
                    </cfif>
                    
                </tbody>
            </table>
        </div>

    </div>

</div>
