package com.NEU.INFO7390;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MaxPickupClassification {

	@RequestMapping(value={"getMaxPickup"}, method = RequestMethod.POST)
	public String loanDecision(HttpServletRequest request, HttpServletRequest response) {
		System.out.println("HERE");
		String decisionLabel= "", decisionProbability1= "", decisionProbability2= "", decisionProbability3= "" ;
		HttpSession session = request.getSession();
		String hod = "", wkdayflag= "", humid= "", windDirDeg= "", precipflag= "",currlat= "";
		String currlong= "", tempF= "", dewPF= "", seaLevPresIn= "", visibMPH= "", windSpeedMPH= "";
		hod = request.getParameter("hod");
//		wkdayflag = request.getParameter("wkdayflag");
		humid = request.getParameter("humid");
//		windDirDeg = request.getParameter("windDirDeg");
		precipflag = request.getParameter("precipflag");
		currlat = request.getParameter("currlat");
		currlong = request.getParameter("currlong");
//		tempF = request.getParameter("tempF");
//		dewPF = request.getParameter("dewPF");
		seaLevPresIn = request.getParameter("seaLevPresIn");
		visibMPH = request.getParameter("visibMPH");
		windSpeedMPH = request.getParameter("windSpeedMPH");
		
		


		int Hour_of_day = 0, Workday_flag = 0, Humidity = 0, WindDirDegrees =0;
		int Precipitation_flag = 0, pickup_count_category = 3, nyc_zone = 0;
		double TemperatureF = 0.0,  Dew_PointF= 0.0,  Sea_Level_PressureIn= 0.0;
		double VisibilityMPH= 0.0, Wind_SpeedMPH= 0.0;
		double currlatitude = 0.0, currlongitude = 0.0;

		try{
			Hour_of_day = Integer.parseInt(hod);
//			Workday_flag = Integer.parseInt(wkdayflag);
			Humidity = Integer.parseInt(humid);
			Precipitation_flag = Integer.parseInt(precipflag);
//			WindDirDegrees = Integer.parseInt(windDirDeg);
			currlatitude = Double.parseDouble(currlat);
			currlongitude = Double.parseDouble(currlong);
//			TemperatureF = Double.parseDouble(tempF);
//			Dew_PointF = Double.parseDouble(dewPF);
			Sea_Level_PressureIn = Double.parseDouble(seaLevPresIn);
			VisibilityMPH = Double.parseDouble(visibMPH);
			Wind_SpeedMPH = Double.parseDouble(windSpeedMPH);
		}catch(Exception e){
			System.out.println("HERE2");
			response.setAttribute("error", "Please enter valid values");
			return "driver";
		}

		/**
		 * Download full code from github - [https://github.com/nk773/AzureML_RRSApp](https://github.com/nk773/AzureML_RRSApp)
		 */
		/**
		 * Call REST API for retrieving prediction from Azure ML 
		 * @return response from the REST API
		 */    

		ArrayList decisionLabels = new ArrayList();
		ArrayList decisionProbabilities1 = new ArrayList();
		ArrayList decisionProbabilities2 = new ArrayList();
		ArrayList decisionProbabilities3 = new ArrayList();
		ArrayList suggestedLatitudes = new ArrayList();
		ArrayList suggestedLongitudes = new ArrayList();

		int zone = 1;
		double min_long = -74.00;
		double max_long = -73.97;

		for (int i = 1; i<5; i++){ //5
			double max_lat = 40.88;
			double min_lat = 40.85;

			for (int j = 1; j<8; j++){ //8
				nyc_zone = zone;

				System.out.println("nyc_zone = " + nyc_zone);



				//		BELOW THIS IN FOR LOOP FOR NYC_ZONE		
				//		______________________________________
				HttpPost post;
				HttpClient client;
				StringEntity entity;


				String apiurl = "";
				String apikey = "";


				JSONObject obj = new JSONObject();
				JSONObject inputs = new JSONObject();
				JSONObject input = new JSONObject();

				JSONArray columnName = new JSONArray();
				columnName.add("pickup_count_category");
				columnName.add("nyc_zone");
				columnName.add("Hour_of_day");
				columnName.add("VisibilityMPH");
				columnName.add("Precipitation_flag");
				columnName.add("Humidity");
				columnName.add("Sea_Level_PressureIn");
				columnName.add("Wind_SpeedMPH");
//				columnName.add("Workday_flag");
//				columnName.add("Dew_PointF");
//				columnName.add("WindDirDegrees");
//				columnName.add("TemperatureF");


				JSONArray allValues = new JSONArray();
				JSONArray value = new JSONArray();
				value.add(pickup_count_category);
				value.add(nyc_zone);
				value.add(Hour_of_day);
				value.add(VisibilityMPH);
				value.add(Precipitation_flag);
				value.add(Humidity);
				value.add(Sea_Level_PressureIn);
				value.add(Wind_SpeedMPH);
//				value.add(Workday_flag);
//				value.add(Dew_PointF);
//				value.add(WindDirDegrees);
//				value.add(TemperatureF);


				allValues.add(value);
				//		allValues.add(value2);

				input.put("ColumnNames", columnName);
				input.put("Values", allValues);
				inputs.put("input1", input);
				obj.put("Inputs", inputs);


				//converting json to string
				String jsonBody = obj.toString(); 


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
					JSONParser parser = new JSONParser();
					Object obj3 = parser.parse(result);
					JSONObject obj4 = (JSONObject) obj3;

					JSONObject results = (JSONObject)obj4.get("Results");
					JSONObject output1 = (JSONObject)results.get("output1");
					JSONObject values = (JSONObject)output1.get("value");

					JSONArray valuesArray = (JSONArray)values.get("Values");
					JSONArray firstValuesArray = (JSONArray) valuesArray.get(0);


					decisionLabel = (String)firstValuesArray.get(11);
					decisionProbability1 = (String)firstValuesArray.get(8);
					decisionProbability2 = (String)firstValuesArray.get(9);
					decisionProbability3 = (String)firstValuesArray.get(10);

					//					HERE STORE RESULTS IN A LIST/DICTIONARY/CLASS/WHATEVER!!
					System.out.println("decision label = " + decisionLabel);
					System.out.println("decision Probability 1 = " + decisionProbability1);
					System.out.println("decision Probability 2 = " + decisionProbability2);
					System.out.println("decision Probability 3 = " + decisionProbability3);

					if(decisionLabel.equals("3")){
						decisionLabels.add(decisionLabel);
						decisionProbabilities1.add(decisionProbability1);
						decisionProbabilities2.add(decisionProbability2);
						decisionProbabilities3.add(decisionProbability3);
						suggestedLatitudes.add(max_lat);
						suggestedLongitudes.add(min_long);

					}


				}
				catch (Exception e) {
					System.out.println("in catch");
					System.out.println(e.toString()); 
					response.setAttribute("error", "Error with API. Please try again" );
					return "home";
				}


				zone = zone+1;
				max_lat = max_lat - 0.03;
				min_lat = min_lat - 0.03;
				try {
					Thread.sleep(100);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			min_long = min_long + 0.03;
			max_long = max_long + 0.03;
		}
		//		___________________________________________
		//		ABOVE THIS IN FOR LOOP FOR NYC_ZONE


		response.setAttribute("sizeofArray", decisionLabels.size());
		System.out.println("size = " + decisionLabels.size());
		response.setAttribute("decisionLabels", decisionLabels);
		response.setAttribute("decisionProbabilities1", decisionProbabilities1);
		response.setAttribute("decisionProbabilities2", decisionProbabilities2);
		response.setAttribute("decisionProbabilities3", decisionProbabilities3);
		response.setAttribute("suggestedLatitudes", suggestedLatitudes);
		response.setAttribute("suggestedLongitudes", suggestedLongitudes);

		return "driverop";
	}
}
