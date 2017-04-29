<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Home Page</title>
</head>


<body>
	<H1>NEU INFO7390 Final Project: NEW YORK TAXI TRIP</H1>
	<form method="post" action="getMaxPickup">
		<br />
		<label>Hour of Day</label><input type="text" name="hod" /> 
		<br /> <br /><label>WorkDay?</label><select name="wkdayflag"
									class="form-control">
									<option value="1">YES</option>
									<option value="0">NO</option>
								</select>
		<br /><br />
		<label>Humidity</label><input type="text" name="humid" /> <br /><br />
		<label>Wind Direction Degree</label><input type="text"
			name="windDirDeg" /> <br /><br />
		<label>Precipitation?</label><select name="precipflag"
									class="form-control">
									<option value="1">YES</option>
									<option value="0">NO</option>
								</select>
		<br /><br />
		<label>Current Latitude</label><input type="text" name="currlat" /> <br /><br />
		<label>Current Longitude</label><input type="text" name="currlong" />
		<br /><br />
		<label>Temperature F</label><input type="text" name="tempF" /> <br /><br />
		<label>Dew Point F</label><input type="text" name="dewPF" /> <br /><br />
		<label>Sea Level Pressure Inch</label><input type="text"
			name="seaLevPresIn" /> <br /><br />
		<label>Visibility</label><input type="text" name="visibMPH" /> <br /><br />
		<label>Wind Speed MPH</label><input type="text" name="windSpeedMPH" /><br /><br />
		<input type="submit" name="submit"
			value="Recommend Pickup Locations" />
	</form>
	<br />
</body>
</html>
