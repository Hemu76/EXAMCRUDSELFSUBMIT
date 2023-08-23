package crud;

public class Employee {
	String name;
	String age;
	String sal;
	String job;
	String dept;
	public Employee(String name, String age, String sal, String job, String dept) {
		super();
		this.name = name;
		this.age = age;
		this.sal = sal;
		this.job = job;
		this.dept = dept;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSal() {
		return sal;
	}
	public void setSal(String sal) {
		this.sal = sal;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	@Override
	public String toString() {
		return "Employee [name=" + name + ", age=" + age + ", sal=" + sal + ", job=" + job + ", dept=" + dept + "]";
	}	
}
