<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
  <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>


<script>
$(document).ready(function(){
    $("#a").click(function(){
        $("#hide").hide();
		var iframe = $("#forPostyouradd");
    iframe.attr("src", iframe.data("src")); 
	iframe.style.visibility="visible";
    });
});

$(document).ready(function(){
    $("#b").click(function(){
        $("#hide").hide();
		var iframe = $("#forPostyouradd");
    iframe.attr("src", iframe.data("src")); 
	iframe.style.visibility="visible";
    });
});
</script>
 <style>
h1 {
    color: white;
    margin-left: 300px;
} 

.jumbotron{
margin-left:20px;
width:900px;
height:650px;
}
</style>
  
</head>  


<body style="background-image:url('https://s-media-cache-ak0.pinimg.com/originals/c6/b2/fe/c6b2fe9da572c5eb8e51aed0b5baaca9.jpg')">

	<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">NEU INFO7390 LENDING CLUB TEAM 7</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="home.html">Home</a></li>
      <li><a href="">Report</a></li>
      <li><a href="http://rpubs.com/Palecanda" target="iframe_a" id="a">R Plots</a></li>
	  <li><a href="https://nbviewer.jupyter.org/github/pptaj/ADS_Assignment2/blob/master/ExploratoryDataAnalysisPython.ipynb" id="b" target="iframe_a">Python Notebooks</a></li>
    </ul>
  </div>
</nav>

	<P>${requestScope.Welcome}</P>

	<div class="container">
	<div class="jumbotron" id="hide">
<form class="form-group" name="classification" method="get" action="getLoanDecision">
  <div class="form-group">
    <label for="loan_amount">Loan Amount:</label>
    <input class="form-control" id="number" type="number" name="loan_amount"><label>${requestScope.error}</label>
  </div>
  <div class="form-group">
    <label for="riskScore">Fico Score:</label>
    <input type="number" name="riskScore" class="form-control" id="riskScore"><label>${requestScope.error}</label>
  </div>
  <div class="form-group">
    <label for="dti">DTI:</label>
    <input type="text" name="dti" class="form-control" id="dti"><label>${requestScope.error}</label>
  </div>
  <div class="form-group">
    <label for="employmentLength">Employment Length:</label>
    <input type="number" name="employmentLength" class="form-control" id="pwd"><label>${requestScope.error}</label>
  </div><br/><br/>
  
 <input type="submit" class="btn btn-primary btn-lg" value="Submit Button">
</form>
</div>
<iframe height="700px" width="100%" id="forPostyouradd" data-src="http://rpubs.com/Palecanda" src="about:blank" visibility="hidden" name="iframe_a"></iframe>
</div>
</body>
</html>
