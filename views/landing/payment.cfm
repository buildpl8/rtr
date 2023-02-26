


<div class="content">   
  
    <div class="container">
        <br><br>
    <div class="row">
        <div class="col-md-12">
            <h3>Last Step!  Enter your payment information.</h3>
        </div>
    </div>
    <br><br>
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
            <form id="payment-form">
                <div id="link-authentication-element">
                  <!--Stripe.js injects the Link Authentication Element-->
                </div>
                <div id="payment-element">
                  <!--Stripe.js injects the Payment Element-->
                </div>
                <button id="submit">
                  <div class="spinner hidden" id="spinner"></div>
                  <span id="button-text">Pay now</span>
                </button>
                <div id="payment-message" class="hidden"></div>
            </form>
            <cfdump var="#rc.checkout_session#"/>
           
            <!---
            <form action="index.cfm?action=landing.payment" method="post">
            <div class="card-bounding">
               
                    <aside>Card Number:</aside>
                    <div class="card-container">
                    <!--- ".card-type" is a sprite used as a background image with associated classes for the major card types, providing x-y coordinates for the sprite --->
                    <div class="card-type"></div>
                    <input name="card_num" placeholder="0000 0000 0000 0000" onkeyup="$cc.validate(event)" />
                    <!-- The checkmark ".card-valid" used is a custom font from icomoon.io -->
                    <div class="card-valid">&#xea10;</div>
                    </div>
                
                    <div class="card-details clearfix">
                
                    <div class="expiration">
                        <aside>Expiration Date</aside>
                        <input name="exp_date" onkeyup="$cc.expiry.call(this,event)" maxlength="7" placeholder="mm/yyyy" />
                    </div>
                
                    <div class="cvv">
                        <aside>CVV</aside>
                        <input name="cvv" placeholder="XXX"/>
                    </div>
                
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <small>Remember the Route uses <a href="https://stripe.com/">Stripe</a> to process all payments.  None of your payment information will remain on our servers and everything will be stored according to PCI compliance.</small>
                        </div>
                    </div>
                
            </div>
            <div class="row">
                <div class="col-md-12">
                    <input type="hidden" name="reg_status" value="2"/> 
                    <input type="submit" value="Next:  Confirmation" class="form-control btn btn-sm btn-primary"/>
                </div>
            </div>
        </form>
        
        </div>
        --->
    </div>
</div>
    
</div>