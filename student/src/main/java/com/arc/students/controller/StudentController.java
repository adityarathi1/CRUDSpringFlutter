package com.arc.students.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.arc.students.service.StudentService;

@RestController
@RequestMapping("/student")
public class StudentController {

	@Autowired
	StudentService studentService;
	
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addStudent (@RequestBody String request) {
		return studentService.addStudent(new JSONObject(request)).toString();
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteStudent (@RequestBody String request) {
		return studentService.deleteStudent(new JSONObject(request)).toString();
	}
	@RequestMapping(value = "/get", method = RequestMethod.POST)
	public String getStudent (@RequestBody String request) {
		return studentService.getStudent(new JSONObject(request)).toString();
	}
	@RequestMapping(value = "/getAll", method = RequestMethod.POST)
	public String getAllStudents (@RequestBody String request) {
		return studentService.getAllStudent().toString();
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateStudent (@RequestBody String request) {
		return studentService.updateStudent(new JSONObject(request)).toString();
	}
	
}
