<html>
<head>
<title>Leaflet Address Lookup and Coordinates</title>
<meta charset="utf-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.3.1/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.3.1/dist/leaflet.js"></script>

<style type="text/css">
* {
	box-sizing: border-box;
}

.column1 {
	float: left;
	width: 44%;
	margin-top:2px;
	padding: 80px;
}

.column2 {
	float: right;
	width: 68%;
	padding: 5px;
	border:2px;
	border-bottom-color:red;
}

/* Clearfix (clear floats) */
#row::after {
	content: "";
	clear: both;
	display: table;
	width: 95%;
	max-width: 980px;
	padding: 1% 2%;
	margin-top:5px;
	background-image: url('Images/img_lights.jpg');
}

body {
	width: 100%;
	padding: 0;
	margin: 0;
}

#lat, #lon {
	text-align: right
}

#map {
	width: 50%;
	height: 100%;
	padding: 0;
	margin: 0;
	
}

.address {
	cursor: pointer
}

.address:hover {
	color: #AA0000;
	text-decoration: underline
}

label {
	width: 4em;
	float: left;
	text-align: right;
	margin-right: 0.5em;
	display: block
}

.submit input {
	margin-left: 4.5em;
}

input[type=text], select {
	width: 100%;
	padding: 12px 20px;
	margin: 8px 0;
	display: inline-block;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type=submit] {
	width: 100%;
	background-color: #4CAF50;
	color: black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

button {
	width: 100%;
	background-color:yellow;
	color:black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type=submit]:hover {
	background-color:green;
}

#satellite {
	width:300px;
	float:left;
	background-color: cyan;
	color: black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

#norm {
	width:300px;
	float:right;
	background-color:crimson;
	color: black;
	padding: 14px 20px;
	margin: 8px 0;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

div {
	border-radius: 2px;
}
</style>
</head>
<body bgcolor="indigo">
	<div id="row">
		<div class="column1">
		<b><h2 style="color:blue;">Address Info</h2></b>
			<form action="/update">
			<input type="hidden" name="id" id="id" value=${data.id}>
				<input type="hidden" name="lattitude"
					id="lat" size=12 onkeypress="check()" value="${data.lattitude}"> <input type="hidden"
					name="longitude" id="lon" size=12 value="${data.longitude}"><br>
				<lebel><b style="color:red;">Place:</b></lebel><br>
				<br> <input type="search" name="addr" id="addr" size="50"
					width="100" style="font-size: 18px; padding-left: 10px;"
					placeholder="Name of Place" value="${data.addr}" onchange="search();"><br>
				<br>
				<lebel><b style="color:red;">District:</b></lebel>
				<br> <input type="text" name="dis" id="dis" size="50"
					width="100" style="font-size: 18px; padding-left: 10px;"
					placeholder="District Name" value="${data.dis}"><br>
				<br>
				<lebel><b style="color:red;">State:</b></lebel>
				<br> <input type="text" name="state" id="state" size="50"
					width="100" style="font-size: 18px; padding-left: 10px;"
					placeholder="State Name" value="${data.state}"><br>
				<br>
				<lebel><b style="color:red;">Country:</b></lebel>
				<br> <input type="text" name="cont" id="cont" size="50"
					width="100" style="font-size: 18px; padding-left: 10px;"
					placeholder="Country name" value="${data.cont}"><br>
				<br>
				<button type="button" onclick="addr_search();" value="Search">Search</button>
				<br>
				<div id="results"></div>
				<br>
				<button type="button" onclick="viewNew();" value="Satellite view" id="satellite">Satellite</button>
				<button type="button" onclick="viewPrev();" value="normal view" id="norm">Map</button>
				<br>
				<br> <input type="submit" id="register" value="Submit">
			</form>
		</div>
		<div class="column2" id="map"></div>
	</div>

	<script type="text/javascript">
		var startlat = document.getElementById('lat').value;
		var startlon = document.getElementById('lon').value;

		var options = {
			center : [ startlat, startlon ],
			zoom : 17
		}

		//document.getElementById('lat').value = startlat;
		//document.getElementById('lon').value = startlon;

		var map = L.map('map', options);
		var nzoom = 15;
		
		var OpenStreetMap_Mapnik = L.tileLayer(
						'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
						{
							maxZoom : 17,
							attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
						}).addTo(map);

		var myMarker = L.marker([ startlat, startlon ], {
			title : "Coordinates",
			alt : "Coordinates",
			draggable : true
		}).addTo(map).on('dragend', function() {
			var lat = myMarker.getLatLng().lat.toFixed(8);
			var lon = myMarker.getLatLng().lng.toFixed(8);
			var czoom = map.getZoom();
			// if(czoom < 18) { nzoom = czoom + 2; }
			// if(nzoom > 18) { nzoom = 18; }
			// if(czoom != 18) { map.setView([lat,lon], nzoom); } else { map.setView([lat,lon]); }
			document.getElementById('lat').value = lat;
			document.getElementById('lon').value = lon;
			myMarker.bindPopup("Lat " + lat + "<br />Lon " + lon).openPopup();
		});
		
		function search()
        {
            document.getElementById("addr").value =  new L.Control.GeoSearch({
             provider: new L.GeoSearch.Provider.OpenStreetMap()
             });
        }


		function viewNew() {
			var Esri_WorldImagery = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',{
								maxZoom : 17,
								attribution : 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
							});
			Esri_WorldImagery.addTo(map);
		}
 
		function viewPrev() {
			var OpenStreetMap_Mapnik = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
								maxZoom : 17,
								attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
							}).addTo(map);

		}
		function chooseAddr(lat1, lng1) {
			myMarker.closePopup();
			map.setView([ lat1, lng1 ], 17);
			myMarker.setLatLng([ lat1, lng1 ]);
			lat = lat1.toFixed(8);
			lon = lng1.toFixed(8);
			document.getElementById('lat').value = lat;
			document.getElementById('lon').value = lon;
			myMarker.bindPopup("Lat " + lat + "<br />Lon " + lon).openPopup();
		}

		function myFunction(arr) {
			var out = " ";
			var i;

			if (arr.length > 0) {
				for (i = 0; i < arr.length; i++) {
					out += "<div class='address' style= title='Show Location and Coordinates' onclick='chooseAddr("
							+ arr[i].lat
							+ ", "
							+ arr[i].lon
							+ ");return false;'>"
							+ arr[i].display_name
							+ "</div>";
				}
				document.getElementById('results').innerHTML = out;
			} else {
				document.getElementById('results').innerHTML = "Sorry, no results...";
			}

		}

		function addr_search() {
			var inp = document.getElementById("addr");
			var dis = document.getElementById("dis");
			var stat = document.getElementById("state");
			var cont = document.getElementById("cont");
			var xmlhttp = new XMLHttpRequest();

			if (inp.value == "" || dis.value == "" || stat.value == ""
					|| cont.value == "") {
				alert("please fill all the fields properly ...!!!!!!");
				return false;
			} else {
				var url = "https://nominatim.openstreetmap.org/search?format=json&limit=2&q="
						+ inp.value;
				xmlhttp.onreadystatechange = function() {
					if (this.readyState == 4 && this.status == 200) {
						var myArr = JSON.parse(this.responseText);
						myFunction(myArr);
					}
				};
				xmlhttp.open("GET", url, true);
				xmlhttp.send();
			}
			return true;
		}
	</script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/places.js@1.18.1"></script>
<script>

(function() {
	  var placesAutocomplete = places({
	    appId: 'pl7GZ4682FT2&%&%^$#%@##!@@~',
	    apiKey: '4a55cff1deaa791f82323804576b3107%#%$%$^#%@$@#!#!%#^#^',
	    container: document.querySelector('#addr')
	  });

	  var $address = document.querySelector('#address-value')
	  placesAutocomplete.on('change', function(e) {
	    $address.textContent = e.suggestion.value
	  });

	  placesAutocomplete.on('clear', function() {
	    $address.textContent = 'none';
	  });
})();
		$(document).ready(function() {
			$("#register").click(function() {
				var plc = $("#addr").val();
				var dist = $("#dis").val();
				var stat = $("#state").val();
				var con = $("#cont").val();
				$(function() {
					var availableTags = myArr;
					("#tags").autocomplete({
						source : availableTags
					});
				});
				if (plc == '' || dist == '' || stat == '' || con == '') {
					alert("Please fill all fields...!!!!!!");
					return false;
				} else {
					alert("Your fields are ready...!!!!!!");
					return true;
				}
			});
		});
	</script>
</body>
</html>
