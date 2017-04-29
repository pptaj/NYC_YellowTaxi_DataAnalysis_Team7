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
	<br />Locations of High Density Pickups are
	<br />
	
	<c:choose>
		<c:when test="${requestScope.sizeofArray } == 0">
    	Sorry, we have no predictions for you!
  </c:when>
		<c:otherwise>
	
	<table border = "1">
	
	<tr>
	<th>S.No.</th>
	<th>Latitude</th>
	<th>Longitude</th>
	<th>Probability</th>
	</tr>
	
	 <c:forEach begin="0" end="${requestScope.sizeofArray -1 }" step="1" varStatus="loop">

		<tr>
			<td>${loop.index}</td>
			<td>${requestScope.suggestedLatitudes[loop.index]}</td>
			<td>${requestScope.suggestedLongitudes[loop.index]}</td>
			<td>${requestScope.decisionProbabilities3[loop.index]}</td>
		</tr>
		
	</c:forEach>  
  	</table>
  </c:otherwise>
	</c:choose>
	
	
	

</body>
</html>
