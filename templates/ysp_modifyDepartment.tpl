<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="">
  <link rel="icon" type="image/png" href="">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <!-- Linked json file should be question_feasibility.json -->
  <title>
      YUVAKANAJA SCHEME
  </title>
  <meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no' name='viewport' />
  <!--     Fonts and icons     -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
  <!-- CSS Files -->
  <link href="../assets/css/material-kit.css?v=2.0.7" rel="stylesheet" />
  <!-- CSS Just for demo purpose, don't include it in your project -->
  <link href="../assets/demo/demo.css" rel="stylesheet" />

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  
      
      
      
      
  <script>
var depObj = {"department":{"Dep_ID":null,"Dep_Short_Name_Kannada":null,"Dep_Short_Name_English":null,"Dep_Name_Kannada":null,"Dep_Name_English":null,"Active":true,"Created_Time":null,"Created_By":null,"Modified_Time":null,"Modified_By":null,"Dep_Logo":null,"Dep_BG_image":null}}

function validate(){
    var msg=""
    var errorExists=false
    if(document.getElementById("sysName_eng").value.trim() === ""){
        msg= "Please enter a valid System Name ID\n"
        errorExists=true
    }
    
    if(document.getElementById("shortDisplayname_eng").value.trim() === ""){
        msg= msg+ "Please enter a valid short Display Name for Department in English \n"
        errorExists=true
    }
    
    if(document.getElementById("shortDisplayname_kan").value.trim() === ""){
        msg= msg+ "Please enter a valid short Display Name for Department in Kannada\n"
        errorExists=true
    }
    
    
    if(document.getElementById("fullName_eng").value.trim() === ""){
        msg= msg+ "Please enter a valid Name for Department in English\n"
        errorExists=true
    }
    
    if(document.getElementById("fullName_kan").value.trim() === ""){
        msg= msg+ "Please enter a valid Name for Department in Kannada\n"
        errorExists=true
    }
    
    if(errorExists == false){
        depObj.department.Dep_ID=document.getElementById("sysName_eng").value.trim()
        depObj.department.Dep_Short_Name_English = document.getElementById("shortDisplayname_eng").value.trim()
        depObj.department.Dep_Short_Name_Kannada = document.getElementById("shortDisplayname_eng").value.trim()
        depObj.department.Dep_Name_English=document.getElementById("fullName_eng").value.trim()
        depObj.department.Dep_Name_Kannada=document.getElementById("fullName_kan").value.trim()
        depObj.department.Active=true
        depObj.department.Created_By="Admin"
        depObj.department.Modified_By="Admin"
        document.getElementById("errorMessage").value=""
        document.getElementById("jsontext").value = JSON.stringify(depObj)
    }else{
        document.getElementById("jsontext").value = ""
        document.getElementById("errorMessage").value = msg
    }
    
    
}
      
function loadDepDetails(){
    alert("Here")
}
  </script>

    <style>
    table, td, th, tr {
  border: 1px solid pink;
  text-align: center;
  color: black;
  font-weight: 1000
    
}
        
        label {
  cursor: default;
  color:black;
  font-weight:800;
}
        
        select {
  cursor: default;
  color:black;
  font-weight:800;
}


table {
  width: 100%;
  border-collapse: collapse;
}
    </style>
    </head>
    <!--<form>-->
    
    <body class="login-page sidebar-collapse">  
        <div class="container">
           
            
        
            <div class="card card-login">
              <div class="card-header card-header-rose text-center">
                <h4 class="card-title" style="padding-left: 3%; padding-right: 3%;">Department/Corporation/Board</h4>
              </div>
            </div>
            
            <div id="schemeHeading" style="display: block;">
             <table>
                 
                 <tr>
                        <td>
                            System Name <b>(Mandatory)</b>
                        </td>
                        <td colspan="2">
                            {{!data['department']['Dep_ID']}}
                            
                            
                        
                        </td>
                      
                        
                    </tr>
                 
                    <tr>
                        <th>
                             
                        </th>
                        <th>
                            English
                        </th>
                        <th>
                            Kannada
                        </th>
                        
                    </tr>
                 
                 <tr>
                        <td>
                            Short Display name (Eg. K.S.R.T.C/ಕ.ರಾ.ರ.ಸಾ.ಸಂ)<b>(Mandatory)</b>
                        </td>
                        <td>
                            <input name="shortDisplayname_eng" type="text" class="form-control-1 " id="shortDisplayname_eng" required maxlength="50">
                        </td>
                        <td>
                            <input name="shortDisplayname_kan" type="text" class="form-contro1-1 " id="shortDisplayname_kan" required maxlength="50">
                        </td>
                        
                    </tr>
                 
                 
                 
                 <tr>
                        <td>
                            Full Name/ಪೂರ್ಣ ಹೆಸರು (Eg.Karnataka State Road Transport Corporation / ಕರ್ನಾಟಕ ರಾಜ್ಯ ರಸ್ತೆ ಸಾರಿಗೆ ನಿಗಮ) <b>(Mandatory)</b>
                        </td>
                        <td>
                            <input name="fullName_eng" type="text" class="form-control-1 " id="fullName_eng" required maxlength = "100">
                        </td>
                        <td>
                            <input name="fullName_kan" type="text" class="form-contro1-1 " id="fullName_kan" required maxlength = "100">
                        </td>
                        
                    </tr>
                 
                  
                    
                    
                </table>
           
            </div>
            

            
            <center> <button class="btn btn-rose btn-raised validate" style="" id="validate" onclick="validate()">VALIDATE</button> <br><textarea name="errorMessage" type="textarea" rows="6" cols="100"  id="errorMessage" maxlength="100000" readonly> Error is any will be displayed here!! </textarea><br>
            <textarea name="jsontext" type="textarea" rows="6" cols="100"  id="jsontext" maxlength="100000"> </textarea></center>
            
            
             
            
        
    </body>
    <!--</form>-->
</html>
