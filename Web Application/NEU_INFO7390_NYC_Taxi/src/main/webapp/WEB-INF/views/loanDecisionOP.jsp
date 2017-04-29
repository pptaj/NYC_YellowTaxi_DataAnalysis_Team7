<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Loan Decision</title> <script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	<script
		src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" />
	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css" />
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

	<style>
h1 {
	color: white;
	margin-left: 300px;
}
</style>
</head>
<body
	style="background-image: url('https://s-media-cache-ak0.pinimg.com/originals/c6/b2/fe/c6b2fe9da572c5eb8e51aed0b5baaca9.jpg')">

	<div class="container">
		<div class="jumbotron">
			<%-- <br>${requestScope.decisionLabel } <br>${requestScope.decisionProbability } --%>

			<c:choose>
				<c:when test="${requestScope.decisionLabel== 0}">
					<p>Sorry! We cannot provide you the loan at this time.</p>
					<br />
				</c:when>
				<c:otherwise>

					<p>Good news!! We can Provide you loan of
						${requestScope.loanAmount }! Now let's see if we can find the
						interest rate!</p>


					<br>
						<form class="form-group" name='prediction' method="post"
							action="getFareAmountAndETA">
							<br />
							<div class="form-group">
								<label for="loan_amount">Loan Amount:</label> <input readonly
									class="form-control" id="number" type="number"
									value="${requestScope.loanAmount }" name="loan_amount">
							</div>

							<div class="form-group">
								<label for="loan_amount">DTI:</label> <input readonly
									class="form-control" id="number" type="number"
									value="${requestScope.dti}" name="dti">
							</div>

							<div class="form-group">
								<label for="loan_amount">FICO Score:</label> <input readonly
									class="form-control" id="number" type="number"
									name="riskScore" value="${requestScope.riskScore}">
							</div>
							
							<div class="form-group">
								<label for="employment_length">Employement Length:</label> <input readonly
									class="form-control" id="number" type="number"
									name="employmentLength" value="${requestScope.employmentLength}">
							</div>

							<div class="form-group">
								<label for="loan_term">Loan Term:</label> <select name="loan_term"
									class="form-control">
									<option value="36">36 Months</option>
									<option value="60">60 Months</option>
								</select>
							</div>

							<div class="form-group">
								<label for="loan_amount">Inquiries in last 6 months:</label> <input
									class="form-control" type="number" name="inq_last_6mths"
									value="">
							</div>

							<div class="form-group">
								<label for="loan_amount">Total number of credit lines:</label> <input
									class="form-control" type="number" name="total_acc" value="">
							</div>

							<div class="form-group">
								<label for="loan_amount">Total Current Balance of All
									Accounts: </label> <input class="form-control" type="number"
									name="tot_cur_bal" value="">
							</div>

							<div class="form-group">
								<label for="verification_status">Verification Status Number:</label> <select name = "verification_status"
								class="form-control" id="verification_status">
								<option value="1">Not Verified</option>
								<option value="2">Source Verified</option>
								<option value="3">Verified</option>
								</select>
							</div>

							<div class="form-group">
								<label for="loan_amount">Average FICO Range:</label> <input
									class="form-control" id="number" type="number"
									name="avg_fico_range" value="">
							</div>

							<div class="form-group">
								<label for="purpose_nmbr">Purpose Number:</label> <select name = "purpose_nmbr"
								class="form-control" id="purpose_nmbr">
								<option value="1">Car</option>
								<option value="2">Credit Card</option>
								<option value="3">Debt Consolidation</option>
								<option value="4">Educatonal</option>
								<option value="5">Home Improvement</option>
								<option value="6">House</option>
								<option value="7">Major Purchase</option>
								<option value="8">Medical</option>
								<option value="9">Moving</option>
								<option value="10">Other</option>
								<option value="11">Renenwal Energy</option>
								<option value="12">Small Business</option>
								<option value="13">Vacation</option>
								<option value="14">Wedding</option>
								</select>
							</div>

							<label for="state">Select Your State:</label> <select name = "state"
								class="form-control" id="addr_state_factor">
								<option value="0">AK</option>
								<option value="1">AL</option>
								<option value="2">AR</option>
								<option value="3">AZ</option>
								<option value="4">CA</option>
								<option value="5">CO</option>
								<option value="6">CT</option>
								<option value="7">DC</option>
								<option value="8">DE</option>
								<option value="9">FL</option>
								<option value="10">GA</option>
								<option value="11">HI</option>
								<option value="12">IA</option>
								<option value="13">ID</option>
								<option value="14">IL</option>
								<option value="15">IN</option>
								<option value="16">KS</option>
								<option value="17">KY</option>
								<option value="18">LA</option>
								<option value="19">MA</option>
								<option value="20">MD</option>
								<option value="21">ME</option>
								<option value="22">MI</option>
								<option value="23">MN</option>
								<option value="24">MO</option>
								<option value="25">MS</option>
								<option value="26">MT</option>
								<option value="27">NC</option>
								<option value="28">ND</option>
								<option value="29">NE</option>
								<option value="30">NH</option>
								<option value="31">NJ</option>
								<option value="32">NM</option>
								<option value="33">NV</option>
								<option value="34">NY</option>
								<option value="35">OH</option>
								<option value="36">OK</option>
								<option value="37">OR</option>
								<option value="38">PA</option>
								<option value="39">RI</option>
								<option value="40">SC</option>
								<option value="41">SD</option>
								<option value="42">TN</option>
								<option value="43">TX</option>
								<option value="44">UT</option>
								<option value="45">VA</option>
								<option value="46">VT</option>
								<option value="47">WA</option>
								<option value="48">WI</option>
								<option value="49">WV</option>
								<option value="50">WY</option>
							</select> <br /> <br /> <input type="submit"
								class="btn btn-primary btn-lg" value="Submit">
						</form> <br />
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>