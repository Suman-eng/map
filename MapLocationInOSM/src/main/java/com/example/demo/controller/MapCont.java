package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.entity.MapEntity;
import com.example.demo.reposetory.MApCrud;

@Controller
public class MapCont 
{
	
	@Autowired
	MApCrud mcdo;
	
	@RequestMapping("/")
	public String page()
	{
		return "Home.jsp";
	}

	@RequestMapping("/addData")
//	@ResponseBody
	public String addData(MapEntity map)
	{
		mcdo.save(map);
		return "Home.jsp";
	}
	
	@RequestMapping("/showData")
	public ModelAndView showData()
	{
		ModelAndView mv = new ModelAndView("view.jsp");
		mv.addObject("data",mcdo.findAll());
		return mv;
	}
	
	@RequestMapping("/edit")
	public ModelAndView editData(@RequestParam int id) 
	{
		ModelAndView mv = new ModelAndView("Edit.jsp");
		mv.addObject("data",mcdo.findById(id).orElse(new MapEntity()));
		return mv;

	}
	
	@RequestMapping("/update")
	public ModelAndView updateAddress(@RequestParam int id,
			@RequestParam String addr,
			@RequestParam String dis,
			@RequestParam String state,
			@RequestParam String cont,
			@RequestParam String lattitude,
			@RequestParam String longitude
			)
	{
		MapEntity map;
		ModelAndView mv = new ModelAndView("redirect:/showData");
		map = mcdo.findById(id).orElse(new MapEntity());
		map.setAddr(addr);
		map.setDis(dis);
		map.setState(state);
		map.setCont(cont);
		map.setLattitude(lattitude);
		map.setLongitude(longitude);
		mcdo.save(map);
		return mv;
		
	}

}
