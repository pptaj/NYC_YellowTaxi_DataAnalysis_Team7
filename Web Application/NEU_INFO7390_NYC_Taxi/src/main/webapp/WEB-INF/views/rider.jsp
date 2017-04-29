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
	<form method="post" action="getFareAmountAndETA">
	<br/><br/><label>pickup_latitude</label><input type="text" name="pickup_latitude"/>
<br/><br/><label>pickup_longitude</label><input type="text" name="pickup_longitude"/>
<br/><br/><label>dropoff_latitude</label><input type="text" name="dropoff_latitude"/>
<br/><br/><label>dropoff_longitude</label><input type="text" name="dropoff_longitude"/>
<br/><br/><label>Pickup_Date</label><input type="date" name="Pickup_Date"/>
<br/><br/><label>Temperature F</label><input type="text" name="tempF" />
<br/><br/><label>Dew Point F</label><input type="text" name="dewPF" />
<br/><br/><label>WorkDay?</label><select name="wkdayflag"
									class="form-control">
									<option value="1">YES</option>
									<option value="0">NO</option>
								</select>
<br/><br/><label>Pickup_Time(HH:MM:SS)</label><input type="text" name="Pickup_Time"/>
<br/><br/><label>Wind Speed MPH</label><input type="text" name="windSpeedMPH" />
<br/><br/><label>Precipitation?</label><select name="precipflag"
									class="form-control">
									<option value="1">YES</option>
									<option value="0">NO</option>
								</select>


	
		<br/><br/><input type="submit" name="submit"
			value="Estimate Fare Amount and ETA" />
	</form>
	<br />
</body>
</html>
