package com.arc.students.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonProperty;

@Entity
@Table(name = "student")
public class Student implements Serializable {

	private static final long serialVersionUID = -5196505317962280698L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@JsonProperty("id")
	@Column(name = "id")
	private int id;

	@Column(name = "student_name")
	@JsonProperty("studentName")
	private String studentName;

	@Column(name = "age")
	@JsonProperty("age")
	private Integer age;

	@Column(name = "class_std")
	@JsonProperty("class_std")
	private Integer class_std;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public Integer getClass_std() {
		return class_std;
	}

	public void setClass_std(Integer class_std) {
		this.class_std = class_std;
	}

}
