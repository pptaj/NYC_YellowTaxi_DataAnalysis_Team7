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
	<br/>
	<h2>TRIP FROM ${requestScope.pickup_latitude }, ${requestScope.pickup_longitude }
	<br/>${requestScope.dropoff_latitude }, ${requestScope.dropoff_longitude } :
	<br/>Estimated Fare Amount = $ ${requestScope.fareAmount }
	<br/>
	ETA = ${requestScope.ETA } minutes</h2>
</body>
</html>
