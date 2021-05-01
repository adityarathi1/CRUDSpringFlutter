package com.arc.students.service;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.arc.students.entity.Student;
import com.arc.students.repository.StudentRepo;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class StudentService {

	@Autowired
	StudentRepo studentRepo;
	
	public JSONObject addStudent (JSONObject request) {
		boolean status = true;
		String error = "";
		JSONObject resp = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();
		Student student = null;
		try {
			student = mapper.readValue(request.toString(), Student.class);
		} catch (JsonProcessingException e) {
			status = false;
			error = "Invalid input";
		}
		studentRepo.save(student);
		resp.put("status", status);
		resp.put("error", error);
		return resp;
	}
	
	public JSONObject getStudent (JSONObject request) {
		JSONObject resp;
		int id = request.getInt("id");
		resp = new JSONObject(studentRepo.findById(id).orElse(new Student()));
		return resp;
	}
	public JSONObject getAllStudent () {
		return new JSONObject().put("data", new JSONArray(studentRepo.findAll()));
		
	}
	
	public JSONObject updateStudent (JSONObject request) {
		boolean status = true;
		String error = "";
		JSONObject resp = new JSONObject();
		ObjectMapper mapper = new ObjectMapper();
		Student student = null;
		try {
			student = mapper.readValue(request.toString(), Student.class);
		} catch (JsonProcessingException e) {
			status = false;
			error = "Invalid input";
		}
		Student dbStudent = studentRepo.findById(student.getId()).orElse(null);
		if (dbStudent == null) {
			status = false;
			error = "Student doesn't exist.";
		} else {
			studentRepo.save(student);
		}
		resp.put("status", status);
		resp.put("error", error);
		return resp;
	}
	
	public JSONObject deleteStudent (JSONObject request) {
		JSONObject resp = new JSONObject();
		int id = request.getInt("id");
		studentRepo.deleteById(id);
		return resp;
	}
	

	
}
