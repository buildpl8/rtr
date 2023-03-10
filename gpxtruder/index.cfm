<!DOCTYPE html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<title>GPXtruder: Make 3D-printable elevation models of GPX tracks</title>
				
		<script async src="js/gpxtruder.js" type="text/javascript"></script>
		<script async src="js/openjscad.js" type="text/javascript"></script>
		<script async src="js/lightgl.js" type="text/javascript"></script>
		<script async src="js/csg.js" type="text/javascript"></script>
		
		<script async src="js/proj4.js" type="text/javascript"></script>
		<script async src="js/vincenty.js" type="text/javascript"></script>
		<script async src="js/jspdf.min.js" type="text/javascript"></script>
				
		<link rel="apple-touch-icon" sizes="152x152" href="img/apple-touch-icon-152-152.png">
		<link rel="shortcut icon" href="img/favicon.ico" />
		
		<script type="text/javascript">
			var toggle = function(event, onvalue, toggleid) {
				if (event.target.value == onvalue) {
					document.getElementById(toggleid).disabled = false;
				} else {
					document.getElementById(toggleid).disabled = true;
				}
				return true;
			};
			
			// Convenience function for setting region bounds directly from a
			// QGIS layer extent string
			var setRegion = function(regionString) {
				var corners = regionString.split(' : ');
				var minima = corners[0].split(',');
				var maxima = corners[1].split(',');
				var	minx = parseFloat(minima[0]),
					miny = parseFloat(minima[1]),
					maxx = parseFloat(maxima[0]),
					maxy = parseFloat(maxima[1]);
				document.forms[0].east_min.value = minx;
				document.forms[0].east_max.value = maxx;
				document.forms[0].north_min.value = miny;
				document.forms[0].north_max.value = maxy;
				document.forms[0].regionfit.checked = true;
			};
		</script>
		
		<script type="text/javascript">
			function details_shim(a){if(!(a&&"nodeType"in a&&"tagName"in a))return details_shim.init();var b;if("details"==a.tagName.toLowerCase())b=a.getElementsByTagName("summary")[0];else if(a.parentNode&&"summary"==a.tagName.toLowerCase())b=a,a=b.parentNode;else return!1;if("boolean"==typeof a.open)return a.getAttribute("data-open")||(a.className=a.className.replace(/\bdetails_shim_open\b|\bdetails_shim_closed\b/g," ")),!1;var c=a.outerHTML||(new XMLSerializer).serializeToString(a),c=c.substring(0,c.indexOf(">")), c=-1!=c.indexOf("open")&&-1==c.indexOf('open=""')?"open":"closed";a.setAttribute("data-open",c);a.className+=" details_shim_"+c;b.addEventListener("click",function(){details_shim.toggle(a)});Object.defineProperty(a,"open",{get:function(){return"open"==this.getAttribute("data-open")},set:function(a){details_shim.toggle(this,a)}});for(b=0;b<a.childNodes.length;b++)if(3==a.childNodes[b].nodeType&&/[^\s]/.test(a.childNodes[b].data)){var c=document.createElement("span"),d=a.childNodes[b];a.insertBefore(c, d);a.removeChild(d);c.appendChild(d)}return!0}details_shim.toggle=function(a,b){b="undefined"===typeof b?"open"==a.getAttribute("data-open")?"closed":"open":b?"open":"closed";a.setAttribute("data-open",b);a.className=a.className.replace(/\bdetails_shim_open\b|\bdetails_shim_closed\b/g," ")+" details_shim_"+b};details_shim.init=function(){for(var a=document.getElementsByTagName("summary"),b=0;b<a.length;b++)details_shim(a[b])}; window.addEventListener?window.addEventListener("load",details_shim.init,!1):window.attachEvent&&window.attachEvent("onload",details_shim.init);
		</script>
		<style type="text/css">
			details, summary {display: block;}
			details.details_shim_closed > * {display: none;}
			details.details_shim_closed > summary {display: block;}
			details.details_shim_open   > summary {display: block;}
			details.details_shim_closed > summary:before {display: inline-block; content: "\25b6"; padding: 0 0.1em; margin-right: 0.4em; font-size: 0.9em;}
			details.details_shim_open   > summary:before {display: inline-block; content: "\25bc"; padding: 0; margin-right: 0.35em;}
		</style>
		<style type="text/css">
			body {
				font-family: sans-serif;
				background-image: url(img/contourtile.jpg);
				background-repeat: repeat;
				background-color: #D7E8A7;
			}

			/* Text styles */

			.info {
				font-size: x-small;
				color: gray;
			}

			.info a {
				color: gray;
			}

			/* Config option groups */

			details {
				margin-top:10px;
				margin-bottom: 10px;
			}

			details summary {
				font-weight: bold;
				cursor: pointer;
			}

			details div.group {
				padding-left: 10px;
				border-left: 5px solid #D7E8A7;
				margin: 10px;
			}

			div#output details div.group {
				/*padding: 5px;
				margin: 0;*/
				border: none;
			}

			/* General sections */

			div#intro {
			}

			div#input {
			}

			div#output {
			}

			div#promo {
			}

			div#footer {
				text-align: center;
			}

			/* Section panels */

			div.panel {
				
				margin-left: auto;
				margin-right: auto;
				margin-top: 10px;
				margin-bottom: 10px;
				
				width: 800px;

				padding: 10px;

				border-radius: 10px;
				border-width: 4px;
				border-style: solid;
				border-color: #c4d994;
				
				background: white;
			}

			div.panel :first-child {
				margin-top: 0;
			}

			div.panel :last-child {
				margin-bottom: 0;
			}

			p.iolabel {
				float: right;
			}

			/* Step 1-2-3 Overview */

			table#howto {
				width: 100%;
			}

			table#howto td {
				width: 33%;
				vertical-align: top;
			}

			/* Code output */

			table#outputcode {
				width: 100%;
			}

			table#outputcode td {
				width: 50%;
				vertical-align: top;
				padding-right: 5px;
			}

			textarea.codebox {
				width: 100%;
				border: 1px solid #c4d994;
			}

			/* Status message popups */

			#messages {
				position: fixed;
				top: 0;
				right: 0;
			}

			#messages div.msg {
				float: right;
				clear: right;
				
				box-shadow: 2px 2px 6px;
				padding: 10px;
				margin: 10px;
				cursor: pointer;
			}

			#messages div.errormsg {
				background: #FFCCCC;
				border: 1px dashed red;
			}

			#messages div.statusmsg {
				background: #CCCCFF;
				border: 1px dotted blue;
			}

			/* OpenJSCAD display */

			div#display div.error {
				border: 5px dashed #DDD;
				background-color: #EEE;
				/* text */ color: #888;
				padding: 10px;
				clear: both;
			}

			canvas {
				cursor: move;
			}

			/* Display view buttons */

			.viewbuttonsdiv {
				margin-bottom: 10px;
			}

			img.viewbutton {
				cursor: pointer;
				border: none;
				margin-left: 5px;
				margin-right: 5px;
			}

			/* Display status line */

			.statusdiv {
				margin-top: 10px;
			}

			#statusspan {
			}
		</style>
	</head>
	<body onLoad="setup();">
		
		<div id="messages"></div>
		
		<div id="intro" class="panel">
			<p><img src="img/title.png" alt="GPXtruder: Make 3D-printable models of GPX tracks" /></p>
			<table id="howto">
				<tr>
					<td>
						<p><img src="img/step1.png" alt="Step 1" /></p>
						<p>Go for a run or a ride. Record your route with a GPS watch.</p>
						<p class="info">Alternatively, export a route from a site like <a href="https://strava.zendesk.com/entries/22555481-Exporting-your-Data-and-Bulk-Export">Strava</a> or <a href="https://support.mapmyfitness.com/hc/en-us/articles/200118304-Exporting-Routes">MapMyRun</a>. Add elevations with <a href="http://www.gpsvisualizer.com/elevation">GPS Visualizer</a>.</p>
					</td>
					<td>
						<p><img src="img/step2.png" alt="Step 2" /></p>
						<p>Use GPXtruder to convert your route to a 3D elevation map.</p>
						<p class="info">Upload a GPX file. Download an STL file or copy the output code to make a remix of your model.</p>
					</td>
					<td>
						<p><img src="img/step3.png" alt="Step 3" /></p>
						<p>Print your route model on a 3D printer. Show off those hills!</p>
						<p class="info">Don't have a printer? Check out <a href="http://www.3dhubs.com/">3D Hubs</a> to find one near you, or try a service like <a href="http://www.shapeways.com/">Shapeways</a>.</p>
					</td>
				</tr>
			</table>
			<p>GPXtruder is an open source project. Visit <a href="https://github.com/anoved/gpxtruder#gpxtruder">the project page</a> for <a href="https://github.com/anoved/gpxtruder#quick-reference">help</a>, <a href="https://github.com/anoved/gpxtruder/blob/master/images/vxx-course.jpg">examples</a>, and <a href="https://github.com/anoved/gpxtruder#feedback-and-development">feedback</a>.</p>
		</div>
		
		<div id="input" class="panel">
			<p class="iolabel"><img src="img/input.png" width="129" height="31" alt="Input" /></p>
			<form enctype="multipart/form-data" method="get" name="gpxform">
				<p><input type="radio" name="gpxsource" value="0" id="gpxsource_upload" onchange="return toggle(event, 0, 'gpxfile') && toggle(event, 1, 'gpxsample');" checked /> <label for="gpxsource_upload">Upload GPX:</label>
					<input type="file" id="gpxfile" /><br />
				   <input type="radio" name="gpxsource" value="1" id="gpxsource_sample" onchange="return toggle(event, 0, 'gpxfile') && toggle(event, 1, 'gpxsample');" /> <label for="gpxsource_sample">Sample GPX:</label>
					<select id="gpxsample" disabled>
						<option value="0" selected>South Mountain</option>
						<option value="1">Vestal XX (20k road race)</option>
					</select><br />
					<span class="info">GPXtruder only processes the first <a href="https://en.wikipedia.org/wiki/GPS_Exchange_Format#Data_types">track</a> in the GPX file.</span></p>
				<details>
					<summary>Route</summary>
					<div class="group">
						<p>Vertical exaggeration: <input type="number" id="vertical" required min="1" step="1" value="5" /><br />
						   <span class="info">Multiply elevation values by this factor to enhance terrain.</span></p>
						<p><label for="zconstant">Default elevation:</label> <input type="number" id="zconstant" required value="10" step="1" min="1" /> (meters) Force default: <input type="checkbox" id="zoverride" value="1" /><br />
						<span class="info">The default is used for all points of undefined elevation. Check <em>Force default</em> to disregard GPX elevation values.</span></p>
						<p><input type="checkbox" id="zcut" value="1" checked /> <label for="zcut">Clip to minimum elevation</label><br />
						<span class="info">Uncheck to show full elevation above sea level. No effect if <em>Force default</em> is checked.</span></p>
						<p>Smoothing: <input type="radio" name="smooth" value="0" id="smooth_auto" onchange="return toggle(event, 1, 'mindist');" checked /> <label for="smooth_auto">Automatic</label> <input type="radio" name="smooth" value="1" id="smooth_manual" onchange="return toggle(event, 1, 'mindist');" /> <label for="smooth_manual">Manual minimum interval:</label> <input type="number" id="mindist" required min="0" step="1" value="0" disabled /> (meters)<br />
						   <span class="info">Simplify the route by discarding points that are close together. Automatic smoothing computes interval based on model shape, size, and scale.</span></p>
					</div>
				</details>
				<details>
					<summary>Model</summary>
					<div class="group">
						<p>Style: <input type="radio" name="shape" value="0" id="shape_track" checked /> <label for="shape_track">Map</label>
								  <input type="radio" name="shape" value="1" id="shape_linear" /> <label for="shape_linear">Linear</label>
								  <input type="radio" name="shape" value="2" id="shape_ring" /> <label for="shape_ring">Ring</label><br />
						   <span class="info">Select <em>map</em> for a model of the actual route. Select <em>linear</em> for a straight elevation profile. Select <em>ring</em> for an elevation profile wrapped in a circle.</span></p>
						<p>Map projection: <input type="radio" name="proj_type" value="0" id="proj_default" onchange="return toggle(event, 1, 'projection');" checked /> <label for="proj_default">Google Maps</label>
										   <input type="radio" name="proj_type" value="2" id="proj_utm" onchange="return toggle(event, 1, 'projection');" /> <label for="proj_utm">UTM</label>
										   <input type="radio" name="proj_type" value="1" id="proj_custom" onchange="return toggle(event, 1, 'projection');" /> <label for="proj_custom">Custom:</label>
											<input type="text" id="projection" disabled /><br />
							<span class="info">Basemap displayed only with Google Maps projection. Custom projections supported by <a href="http://proj4js.org/">Proj4js</a> may be specified in <a href="http://trac.osgeo.org/proj/wiki/WikiStart#Documentation"><code>PROJ</code></a> or <a href="http://www.geoapi.org/2.0/javadoc/org/opengis/referencing/doc-files/WKT.html"><code>WKT</code></a> format.</p>
						<p><input type="checkbox" id="regionfit" value="1" onchange="return toggle(event, event.target.checked ? 1 : 0, 'north_min') && toggle(event, event.target.checked ? 1 : 0, 'east_min') && toggle(event, event.target.checked ? 1 : 0, 'north_max') && toggle(event, event.target.checked ? 1 : 0, 'east_max');" /> <label for="regionfit">Fit to region:</label>
							South: <input type="text" id="north_min" size="5" disabled />
							West: <input type="text" id="east_min" size="5" disabled />
							North: <input type="text" id="north_max" size="5" disabled />
							East: <input type="text" id="east_max" size="5" disabled /> (meters)<br />
						<span class="info">If enabled, output is scaled to fit region to bed. Coordinate system depends on map projection. (Google Maps uses <a href="http://docs.openlayers.org/library/spherical_mercator.html">Spherical Mercator</a> meters.)</span></p>
						<p>Markers: <input type="radio" name="marker" value="0" id="marker_none" onchange="return toggle(event, 3, 'marker_interval');" checked /> <label for="marker_none">None</label>
									<input type="radio" name="marker" value="1" id="marker_km" onchange="return toggle(event, 3, 'marker_interval');" /> <label for="marker_km">Kilometers</label>
									<input type="radio" name="marker" value="2" id="marker_mi" onchange="return toggle(event, 3, 'marker_interval');" /> <label for="marker_mi">Miles</label>
									<input type="radio" name="marker" value="3" id="marker_other" onchange="return toggle(event, 3, 'marker_interval');" /> <label for="marker_other">Other interval:</label> <input type="number" id="marker_interval" min="1" value="8047" disabled /> (meters)<br />
						   <span class="info">If enabled, a secondary model is generated representing the position of each mile or kilometer marker.</span></p>
					</div>
				</details>
				<details>
					<summary>Size</summary>
					<div class="group">
						<p>Maximum width (x): <input type="number" id="width" required min="20" step="1" value="180" /> (mm)<br />
						   Maximum depth (y): <input type="number" id="depth" required min="20" step="1" value="90" /> (mm)<br />
						   <span class="info">Output is scaled to fit these dimensions. Area outline appears as a black border on basemap.</span></p>
						<p>Path width: <input type="number" id="path_width" required min="1" step="1" value="2" /> (mm)<br />
						   <span class="info">Thickness of the output path.</span></p>
						<p>Base height: <input type="number" id="base" required min="0" step="1" value="1" /> (mm)<br />
						   <span class="info">Extra height added to the bottom of the route model.</span></p>
					</div>
				</details>
				<p><input type="button" onclick="submitInput();" value="Extrude Route" /> <span class="info">Then click <em>Generate STL</em> in the <em>Output</em> panel below to download the 3D model.</span></p>
			</form>
		</div>
		
		<div id="output" class="panel">
			<p class="iolabel"><img src="img/output.png" width="166" height="31" alt="Output" /></p>
			<div id="display"></div>
			<details>
				<summary>Parametric CAD Scripts</summary>
				<div class="group">
					<p>Remix the extruded route model by tinkering with this code. Batteries not included.</p>
					<table id="outputcode">
						<tr>
							<td>
								<textarea id="code_jscad" class="codebox" cols="40" rows="6"></textarea>
								<p class="info"><a href="javascript:void(0)" onclick="document.getElementById('code_jscad').select();">Select all</a>, copy, and paste in <a href="http://openjscad.org/">OpenJSCAD.org</a>.</p>
							</td>
							<td>
								<textarea id="code_openscad" class="codebox" cols="40" rows="6"></textarea>
								<p class="info"><a href="javascript:void(0)" onclick="document.getElementById('code_openscad').select();">Select all</a>, copy, and paste in <a href="http://www.openscad.org/">OpenSCAD</a>.</p>
							</td>
						</tr>
					</table>
				</div>
			</details>
		</div>
		
	
		
		<div id="footer" class="panel">
			<p class="info">GPXtruder is not affiliated with Strava, MapMyRun, GPS Visualizer, 3D Hubs, Shapeways, Garmin, Printrbot, or any other sites, products, or services. All trademarks and registered trademarks are the property of their respective owners. This is the fine print your mother warned you about.</p>
		</div>
		
	</body>
</html>