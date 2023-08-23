<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.util.*,java.sql.*,java.io.*,javax.servlet.*,javax.servlet.http.*,crud.Employee"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
}

center {
	margin-top: 50px;
}

button {
	padding: 5px 10px;
	margin: 10px;
}

input[type="text"], select {
	padding: 5px;
	margin: 5px;
}
</style>
</head>
<body>
	<center>
		<form onsubmit='self.jsp'>

			<h1>CRUD</h1>
			<label>Name :<input type="text" name="nam" id="name"></label><select
				id="select" name="select">
				<option>select</option>
				<option>Add</option>
				<option>Edit</option>
				<option>Delete</option>
			</select><br></br> 
			<label>Age :<input type="text" name="age" id="age"></label><br></br>
			<label>Salary:<input type="text" name="salary" id="salary"></label><br></br>
			<label>Job :<input type="text" name="job" id="job"></label><br></br> 
			<label>Dept:<input type="text" name="dept" id="dept"></label><br></br> 
			<input type="submit" name="name" value='first'> 
			<input type="submit" name="name" value='prev'> 
			<input type="submit" name="name" value='next'> 
			<input type="submit" name="name" value='last'><br></br>
			<input type="submit" name="name" value='add'> 
			<input type="submit" name="name" value='delete'> 
			<input type="submit" name="name" value='edit'> 
			<input type="submit" name="name" value='save'> <br></br>
			<input type="submit" name="name" value='search'>
			<input type="submit" name="name" value='exit'> 
			<input type="submit" name="name" value='clear'>
		</form>
	</center>
	<%
	int cur=0;
	HttpSession ses = request.getSession();
	if(ses.getAttribute("count")==null){
		cur=1;
	}
	else{
		cur=(int)session.getAttribute("count");
	}
	String name = request.getParameter("name");
	Connection con;
	Statement statement;
	PreparedStatement ps;
	ResultSet rs;
	String query = null;
	String naam = "";
	String age = "";
	String sal = "";
	String job = "";
	String dept = "";
	try {
		ArrayList<Employee> ae = new ArrayList<>();
		Class.forName("org.postgresql.Driver");
		con = DriverManager.getConnection("jdbc:postgresql://localhost:5434/postgres","postgres","1234");
		statement = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		query = "select * from employee";
		rs = statement.executeQuery(query);
		while (rs.next()) {
			ae.add(new Employee(rs.getString(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5)));
		}
		if (name.equals("first")) {
			cur=1;
			naam = ae.get(0).getName();
			age = ae.get(0).getAge();
			sal = ae.get(0).getSal();
			job = ae.get(0).getJob();
			dept = ae.get(0).getDept();
		}
		if (name.equals("next") && cur<ae.size()) {
			cur=cur+1;
			ses.setAttribute("count",cur);
			naam = ae.get(cur).getName();
			age = ae.get(cur).getAge();
			sal = ae.get(cur).getSal();
			job = ae.get(cur).getJob();
			dept = ae.get(cur).getDept();
		}
		if (name.equals("prev") && cur>0) {
			cur=cur-1;
			ses.setAttribute("count",cur);
			naam = ae.get(cur).getName();
			age = ae.get(cur).getAge();
			sal = ae.get(cur).getSal();
			job = ae.get(cur).getJob();
			dept = ae.get(cur).getDept();
		}
		if (name.equals("last")) {
			cur=ae.size()-1;
			ses.setAttribute("count",cur);
			naam = ae.get(cur).getName();
			age = ae.get(cur).getAge();
			sal = ae.get(cur).getSal();
			job = ae.get(cur).getJob();
			dept = ae.get(cur).getDept();
		}
		if (name.equals("add")) {
			naam = request.getParameter("nam");
			age = request.getParameter("age");
			sal = request.getParameter("salary");
			job = request.getParameter("job");
			dept = request.getParameter("dept");
			ps = con.prepareStatement("insert into employee values(?,?,?,?,?)");
			ps.setString(1, naam);
			ps.setString(2, age);
			ps.setString(3, sal);
			ps.setString(4, job);
			ps.setString(5, dept);
			ps.executeUpdate();
		}
		if (name.equals("delete")) {
			naam = request.getParameter("nam");
			ps = con.prepareStatement("delete from employee where name=?");
			ps.setString(1, naam);
			ps.executeUpdate();
			cur=cur-1;
			ses.setAttribute("count",cur);
			naam = ae.get(cur).getName();
			age = ae.get(cur).getAge();
			sal = ae.get(cur).getSal();
			job = ae.get(cur).getJob();
			dept = ae.get(cur).getDept();
		}
		if(name.equals("edit")){
			naam = request.getParameter("nam");
			age = request.getParameter("age");
			sal = request.getParameter("salary");
			job = request.getParameter("job");
			dept = request.getParameter("dept");
			int poss=(int)ses.getAttribute("count");
			ps=con.prepareStatement("update employee set name=?,age=?,salary=?,job=?,department=? where eid=?");
			ps.setString(1, naam);
			ps.setString(2, age);
			ps.setString(3, sal);
			ps.setString(4, job);
			ps.setString(5, dept);
			ps.setInt(6, poss);
			ps.executeUpdate();
		}
		if(name.equals("search")){
			naam = request.getParameter("nam");
			ps=con.prepareStatement("select * from employee where name=?");
			ps.setString(1,naam);
			rs=ps.executeQuery();
			if(rs.next()){
				naam = rs.getString(1);
				age = rs.getString(2);
				sal = rs.getString(3);
				job = rs.getString(4);
				dept = rs.getString(5);
			}
		}
		if(name.equals("clear")){
			naam = "";
			age = "";
			sal = "";
			job = "";
			dept = "";
		}
		if(name.equals("exit")){
			
		}
	} catch (Exception e) {
		System.out.println("jdbc" + e);
	}
	%>
	<script>
		var namee= document.getElementById("name");
		var age= document.getElementById("age");
		var sal= document.getElementById("salary");
		var job= document.getElementById("job");
		var dept= document.getElementById("dept");
		namee.value="<%=naam%>";
		age.value="<%=age%>";
		sal.value="<%=sal%>";
		job.value="<%=job%>";
		dept.value="<%=dept%>";
	</script>
</body>
</html>