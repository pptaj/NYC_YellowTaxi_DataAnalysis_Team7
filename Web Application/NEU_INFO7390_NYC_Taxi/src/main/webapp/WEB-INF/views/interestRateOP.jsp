<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interest Rate</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>  
 
 <style>
h3 {
    color: black;
	background-color:yellow;
    margin-left: 300px;
} 


.jumbotron
{
margin-left:20px;
margin-right:20px;
margin-top:50px;
width:1200px;
height:400px;
}

</style>
  
</head> 
<body style="background-image:url('https://s-media-cache-ak0.pinimg.com/originals/c6/b2/fe/c6b2fe9da572c5eb8e51aed0b5baaca9.jpg')">

	<div class="container">
	<div class="jumbotron">
		<%-- 		<br> <br>
		<br> <br>
		<br>${requestScope.decisionLabel } <br>${requestScope.decisionProbability } --%>

        
		<h2>Good news!! We can Provide you loan of ${requestScope.loanAmount } at ${requestScope.highestInterestRate } %</h2>
        		<br/><br/><br/><br/><br/><br/><br/><br/>
        		<p>Interest Rate - No Clustering: ${requestScope.interestRate_NoCluster }</p>
				<p>Interest Rate - K-means Clustering: ${requestScope.interestRate_kmeans }</p>
	</div>
</div>
</body>
</html>