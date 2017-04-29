package com.NEU.INFO7390;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	/**
	 * Simply selects the home view to render by returning its name.
	 */

	@RequestMapping(value={"/", "home.html", "home.jsp"}, method = RequestMethod.GET)
	public String home(HttpServletRequest request, HttpServletRequest response) {
		
		response.setAttribute("Welcome", "NEU INFO 7390 NYC TAXI TRIP");	
		
		return "home";
	}
	
	@RequestMapping(value={"rider"}, method = RequestMethod.POST)
	public String rider(HttpServletRequest request, HttpServletRequest response) {
		
		response.setAttribute("Welcome", "NEU INFO 7390 NYC TAXI TRIP");	
		
		return "rider";
	}
	
	@RequestMapping(value={"driver"}, method = RequestMethod.POST)
	public String driver(HttpServletRequest request, HttpServletRequest response) {
		
		response.setAttribute("Welcome", "NEU INFO 7390 NYC TAXI TRIP");	
		
		return "driver";
	}


	
}
