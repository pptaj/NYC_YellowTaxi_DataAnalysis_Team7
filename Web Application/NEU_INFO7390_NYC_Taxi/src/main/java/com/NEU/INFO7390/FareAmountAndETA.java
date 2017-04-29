package com.NEU.INFO7390;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Scanner;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FareAmountAndETA {
	HttpPost post;
	HttpClient client;
	StringEntity entity;
	@RequestMapping(value={"getFareAmountAndETA"}, method = RequestMethod.POST)
	public String loanDecision(HttpServletRequest request, HttpServletRequest response) {
		String decisionLabel= "", decisionProbability1= "", decisionProbability2= "", decisionProbability3= "" ;
		HttpSession session = request.getSession();
		String hod = "", wkdayflag= "", humid= "", windDirDeg= "", precipflag= "",currlat= "", pu_Date = "";
		String currlong= "", tempF= "", dewPF= "", seaLevPresIn= "", visibMPH= "", windSpeedMPH= "", pu_Time = "";
		String pu_latitude= "", pu_longitude = "", drop_latitude = "", drop_longitude = "";
		
		wkdayflag = request.getParameter("wkdayflag");
		precipflag = request.getParameter("precipflag");
		tempF = request.getParameter("tempF");
		dewPF = request.getParameter("dewPF");
		windSpeedMPH = request.getParameter("windSpeedMPH");
		
		pu_latitude = request.getParameter("pickup_latitude");
		pu_longitude = request.getParameter("pickup_longitude");
		drop_latitude = request.getParameter("dropoff_latitude");
		drop_longitude = request.getParameter("dropoff_longitude");
		pu_Date = request.getParameter("Pickup_Date");
		pu_Time = request.getParameter("Pickup_Time");
		System.out.println(pu_Date);
		int Hour_of_day = 0, Workday_flag = 0, Humidity = 0, WindDirDegrees =0;
		int Precipitation_flag = 0, pickup_count_category = 3, nyc_zone = 0;
		double TemperatureF = 0.0,  Dew_PointF= 0.0,  Sea_Level_PressureIn= 0.0;
		double VisibilityMPH= 0.0, Wind_SpeedMPH= 0.0;
		double pickup_latitude = 0.0, pickup_longitude = 0.0;
		double dropoff_latitude = 0.0, dropoff_longitude = 0.0;
		
//		DateTimeFormatter f = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		String Pickup_Date = "", Pickup_Time="";
		try{
			Date pDate = df.parse(pu_Date);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); //Or whatever format fits best your needs.
			Pickup_Date = sdf.format(pDate) + "T00:00:00Z"; 
		}catch(Exception e){
			response.setAttribute("error", "Please enter valid values");
		}
		
		try{
			Pickup_Time = "2016-01-01T" + pu_Time;
		}catch(Exception e){
			System.out.println("ERROR HERE");
			response.setAttribute("error", "Please enter valid values");
		}
		
		
		try{
			
			Workday_flag = Integer.parseInt(wkdayflag);
			
			Precipitation_flag = Integer.parseInt(precipflag);
			
			TemperatureF = Double.parseDouble(tempF);
			Dew_PointF = Double.parseDouble(dewPF);
			Wind_SpeedMPH = Double.parseDouble(windSpeedMPH);
			
			pickup_latitude = Double.parseDouble(pu_latitude);
			pickup_longitude = Double.parseDouble(pu_longitude);
			dropoff_latitude = Double.parseDouble(drop_latitude);
			dropoff_longitude = Double.parseDouble(drop_longitude);
//			Pickup_Date = 
//			Pickup_Time = 
		}catch(Exception e){
			System.out.println("ERROR IS HERE");
			response.setAttribute("error", "Please enter valid values");
			//			return "home";
		}







		/**	
		 * Download full code from github - [https://github.com/nk773/AzureML_RRSApp](https://github.com/nk773/AzureML_RRSApp)
		 */
		/**
		 * Call REST API for retrieving prediction from Azure ML 
		 * @return response from the REST API
		 */    








		JSONObject obj = new JSONObject();
		JSONObject inputs = new JSONObject();
		JSONObject input = new JSONObject();
		JSONArray columnName = new JSONArray();
		columnName.add("fare_amount");
		columnName.add("dropoff_longitude");
		columnName.add("pickup_longitude");
		columnName.add("dropoff_latitude");
		columnName.add("pickup_latitude");
		columnName.add("Pickup_Date");
		columnName.add("TemperatureF");
		columnName.add("Dew_PointF");
		columnName.add("Workday_flag");
		columnName.add("Pickup_Time");
		columnName.add("Wind_SpeedMPH");
		columnName.add("Precipitation_flag");
		
		JSONArray allValues = new JSONArray();
		JSONArray value = new JSONArray();
		value.add(0);
		value.add(dropoff_longitude);
		value.add(pickup_longitude);
		value.add(dropoff_latitude);
		value.add(pickup_latitude);
		value.add(Pickup_Date);
		value.add(TemperatureF);
		value.add(Dew_PointF);
		value.add(Workday_flag);
		value.add(Pickup_Time);
		value.add(Wind_SpeedMPH);
		value.add(Precipitation_flag);



		allValues.add(value);

		input.put("ColumnNames", columnName);
		input.put("Values", allValues);
		inputs.put("input1", input);
		obj.put("Inputs", inputs);

		//converting json to string
		String jsonBody = obj.toString(); 
		String fareAmount = "5.0";
		String ETA = "5.0";

		//		________________
		//		Get Fare Amount from prediction API 
		String apiurl = "";
		String apikey = "";

		ArrayList list = prediction(apiurl, apikey, jsonBody);
		fareAmount = (String)list.get(0);
		String deviationValue1 = (String)list.get(1);

		System.out.println("Fare Amount = " + fareAmount);
		System.out.println("Deviation Value = " + deviationValue1);
		response.setAttribute("fareAmount", fareAmount);
		response.setAttribute("deviationValue1", deviationValue1);


		//		________________

		
		obj = new JSONObject();
		inputs = new JSONObject();
		input = new JSONObject();
		columnName = new JSONArray();
		columnName.add("Triptime");
		columnName.add("dropoff_longitude");
		columnName.add("dropoff_latitude");
		columnName.add("Workday_flag");
		columnName.add("TemperatureF");
		columnName.add("pickup_latitude");
		columnName.add("pickup_longitude");
		columnName.add("Time");
		columnName.add("Dropoff_Date");
		columnName.add("Pickup_Date");
		columnName.add("Dew_PointF");
		columnName.add("Pickup_Time");
		columnName.add("Day_of_week");
		columnName.add("Humidity");
		columnName.add("Sea_Level_PressureIn");
		columnName.add("Precipitation_flag");


		
		
		allValues = new JSONArray();
		value = new JSONArray();
		value.add(0);
		value.add(dropoff_longitude);
		value.add(dropoff_latitude);
		value.add(Workday_flag);
		value.add(TemperatureF);
		value.add(pickup_latitude);
		value.add(pickup_longitude);
		value.add(Pickup_Time);
		value.add(Pickup_Date);
		value.add(Pickup_Date);
		value.add(Dew_PointF);
		value.add(Pickup_Time);
		value.add(2);
		value.add(Humidity);
		value.add(Sea_Level_PressureIn);
		value.add(Precipitation_flag);

		

		allValues.add(value);

		input.put("ColumnNames", columnName);
		input.put("Values", allValues);
		inputs.put("input1", input);
		obj.put("Inputs", inputs);

		//converting json to string
		jsonBody = obj.toString();
		
		
		
		
		
		
		//		________________
		//		Get ETA from prediction API 
		apiurl = "";
		apikey = "";

		list = prediction2(apiurl, apikey, jsonBody);
		ETA = (String)list.get(0);
		String deviationValue2 = (String)list.get(1);
		
		Double eta = Double.parseDouble(ETA)/60;
		
		System.out.println("ETA = " + eta);
		System.out.println("Deviation Value = " + deviationValue2);

		response.setAttribute("ETA", eta);
		response.setAttribute("deviationValue2", deviationValue2);

		response.setAttribute("pickup_latitude", pickup_latitude);
		response.setAttribute("pickup_longitude", pickup_longitude);
		response.setAttribute("dropoff_latitude", dropoff_latitude);
		response.setAttribute("dropoff_longitude", dropoff_longitude);

		//		________________



		return "riderop";
	}





	private ArrayList<Object> prediction(String apiurl, String apikey, String jsonBody){
		ArrayList<Object> list = new ArrayList<Object>();
		String decisionValue= "", decisionDeviation= "";
		try {
			// create HttpPost and HttpClient object

			post = new HttpPost(apiurl);
			client = HttpClientBuilder.create().build();
			// setup output message by copying JSON body into 
			// apache StringEntity object along with content type
			entity = new StringEntity(jsonBody, HTTP.UTF_8);
			entity.setContentEncoding(HTTP.UTF_8);
			entity.setContentType("text/json");

			// add HTTP headers
			post.setHeader("Accept", "text/json");
			post.setHeader("Accept-Charset", "UTF-8");

			// set Authorization header based on the API key
			post.setHeader("Authorization", ("Bearer "+apikey));
			post.setEntity(entity);


			// Call REST API and retrieve response content
			HttpResponse authResponse = client.execute(post);
			String result= EntityUtils.toString(authResponse.getEntity());
			//			System.out.println(result);
			JSONParser parser = new JSONParser();
			Object obj3 = parser.parse(result);
			JSONObject obj4 = (JSONObject) obj3;
			JSONObject results = (JSONObject)obj4.get("Results");
			//			System.out.println(results);
			JSONObject output1 = (JSONObject)results.get("output1");
			JSONObject values = (JSONObject)output1.get("value");
			JSONArray valuesArray = (JSONArray)values.get("Values");
			JSONArray firstValuesArray = (JSONArray) valuesArray.get(0);
			decisionValue = (String)firstValuesArray.get(12);
			try{
				decisionDeviation = (String)firstValuesArray.get(13);
			}catch(Exception e){
				decisionDeviation = "0.0";
			}


			list.add(decisionValue);
			list.add(decisionDeviation);

		}
		catch (Exception e) {
			System.out.println(e.toString()); 

			return null;
		}

		return list;
	}
	
	private ArrayList<Object> prediction2(String apiurl, String apikey, String jsonBody){
		ArrayList<Object> list = new ArrayList<Object>();
		String decisionValue= "", decisionDeviation= "";
		try {
			// create HttpPost and HttpClient object

			post = new HttpPost(apiurl);
			client = HttpClientBuilder.create().build();
			// setup output message by copying JSON body into 
			// apache StringEntity object along with content type
			entity = new StringEntity(jsonBody, HTTP.UTF_8);
			entity.setContentEncoding(HTTP.UTF_8);
			entity.setContentType("text/json");

			// add HTTP headers
			post.setHeader("Accept", "text/json");
			post.setHeader("Accept-Charset", "UTF-8");

			// set Authorization header based on the API key
			post.setHeader("Authorization", ("Bearer "+apikey));
			post.setEntity(entity);


			// Call REST API and retrieve response content
			HttpResponse authResponse = client.execute(post);
			String result= EntityUtils.toString(authResponse.getEntity());
			//			System.out.println(result);
			JSONParser parser = new JSONParser();
			Object obj3 = parser.parse(result);
			JSONObject obj4 = (JSONObject) obj3;
			JSONObject results = (JSONObject)obj4.get("Results");
			//			System.out.println(results);
			JSONObject output1 = (JSONObject)results.get("output1");
			JSONObject values = (JSONObject)output1.get("value");
			JSONArray valuesArray = (JSONArray)values.get("Values");
			JSONArray firstValuesArray = (JSONArray) valuesArray.get(0);
			decisionValue = (String)firstValuesArray.get(16);
			try{
				decisionDeviation = (String)firstValuesArray.get(17);
			}catch(Exception e){
				decisionDeviation = "0.0";
			}


			list.add(decisionValue);
			list.add(decisionDeviation);

		}
		catch (Exception e) {
			System.out.println(e.toString()); 

			return null;
		}

		return list;
	}

}
