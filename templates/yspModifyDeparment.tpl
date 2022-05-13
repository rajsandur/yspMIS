<!DOCTYPE html>
<html lang="kn">

<head>
  <meta charset="UTF-8" />
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
      
$(document).ready(function(){
       var department = GetUrlParameter('depId');
       //alert(department)
      var request = {"depId":department}
       $.ajax({
            type: "POST",
            url: '/ysgetDepartment',
            data: JSON.stringify(request),
            contentType: "application/json",
            success: function (data) {
              $("#spinner").fadeOut("slow");
              console.log(data);
              var json = $.parseJSON(data);
              if (json.msg == "Success"){  
               console.log(json.data);
                  document.getElementById("shortDisplayname_eng").value=json.data.department.shortName.eng;
                  document.getElementById("shortDisplayname_kan").value=json.data.department.shortName.kan;
                  document.getElementById("sysName_eng").value=json.data.department.dep_id;
                  document.getElementById("fullName_kan").value=json.data.department.name.kan;
                  document.getElementById("fullName_eng").value=json.data.department.name.eng;
              }
            },
            error: function(data){
                $("#spinner").fadeOut("slow");
                alert("Technical Error!");
            }

        });
       
});


function goToHome(){
            window.location.href = '/yuvaspandanaHome'
        }
      
      
function GetUrlParameter(sParam)

{
    var sPageURL = window.location.search.substring(1);

    var sURLVariables = sPageURL.split('&');

    for (var i = 0; i < sURLVariables.length; i++)
    {
        var sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] == sParam)

        {
            return sParameterName[1];
        }
    }
}      
var depObj = {"department":{"dep_id":null,"shortName":{
          "kan":null,
          "eng":null
      },
      "name":{
           "kan":null,
          "eng":null
      },
      "active":null,
      "created_time": null,
      "created_by":null,
      "modified_time":null,
      "modified_by":null,
       "logo":"logo.jpeg","bg_image":"bg.jpeg","lastSchemeID":0}
    }

var isvalid = false
function validate(){
    var msg=""
    var errorExists=false
    var today = new Date();
    var savetime=today.getDate()+"/"+(today.getMonth()+1)+"/"+today.getFullYear()+"-"+today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    
    
    if(document.getElementById("sysName_eng").value.trim() === ""){
        msg= "Please enter a valid System Name ID<br>"
        errorExists=true
    }
    
    if(document.getElementById("shortDisplayname_eng").value.trim() === ""){
        msg= msg+ "Please enter a valid short Display Name for Department in English <br>"
        errorExists=true
    }
    
    if(document.getElementById("shortDisplayname_kan").value.trim() === ""){
        msg= msg+ "Please enter a valid short Display Name for Department in Kannada<br>"
        errorExists=true
    }
    
    
    if(document.getElementById("fullName_eng").value.trim() === ""){
        msg= msg+ "Please enter a valid Name for Department in English<br>"
        errorExists=true
    }
    
    if(document.getElementById("fullName_kan").value.trim() === ""){
        msg= msg+ "Please enter a valid Name for Department in Kannada<br>"
        errorExists=true
    }
    
    if(errorExists == false){
        depObj.department.dep_id=document.getElementById("sysName_eng").value.trim()
        depObj.department.shortName.eng = document.getElementById("shortDisplayname_eng").value.trim()
        depObj.department.shortName.kan = document.getElementById("shortDisplayname_kan").value.trim()
        depObj.department.name.eng=document.getElementById("fullName_eng").value.trim()
        depObj.department.name.kan=document.getElementById("fullName_kan").value.trim()
        depObj.department.active=true
        depObj.department.created_by="Admin"
        depObj.department.modified_by="Admin"
        depObj.department.modified_time=savetime
        depObj.department.created_time=savetime
        document.getElementById("errorMessage").innerHTML=""
        //document.getElementById("jsontext").value = JSON.stringify(depObj)
        
         var parts = [
          new Blob([JSON.stringify(depObj)], {type: 'application/json'}),
          //JSON.stringify(schemeData),
          new Uint16Array([33])
        ];

        // Construct a file
        var file = new File(parts, document.getElementById("sysName_eng").value.trim()+'.json', {
            lastModified: new Date(0), // optional - default = now
            type: "overide/mimetype" // optional - default = ''
        });

        var fr = new FileReader();

        
             document.getElementById('link').innerHTML = "<br><a href="+URL.createObjectURL(file)+" download=" + file.name + ">Download " + file.name + "</a>"
        
          
        

        fr.readAsText(file);
        console.log(JSON.stringify(depObj))
        isvalid=true
        
        
        
    }else{
        //document.getElementById("jsontext").value = ""
         document.getElementById("errorMessage").innerHTML = msg
         isvalid = false
    }
    
    
}
      
      function modifyDep(){
          
          if(isvalid){
              document.getElementById("errorMessage").innerHTML = ""
              var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                      //localStorage.removeItem(localStorageKey)
                      window.location.href =  '/yuvaspandanaHome'
                    }
                };
                xhttp.open("POST", "/ysCreateDep", true);
                xhttp.setRequestHeader("Content-type", "application/json");
                xhttp.send('data='+JSON.stringify(depObj));
          }else{
              alert('Ensure all required fields are filled before submitting')
          }
          
      }
      
      function goToHome(){
            window.location.href = '/yuvaspandanaHome'
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
                 
                  <tr>
                        <td>
                            System Name ID (For Eg. KSRTC - 5-6 letters in english) <b>(Mandatory)</b>
                        </td>
                        <td colspan="2">
                            <input name="sysName_eng" type="text" class="form-control-1 " id="sysName_eng" required maxlength = "6" readonly>
                        </td>
                      
                        
                    </tr>
                    
                    
                </table>
           
            </div>
            
             <center><p style="padding-left: 15px; font-size: 1.2em;"><span id="link"></span></p></center>
            
            
            <center> 
                <button class="btn btn-rose btn-raised validate" style="" id="validate" onclick="validate()">VALIDATE</button>
                
                <!--<button class="btn btn-rose btn-raised validate" style="" id="validate" onclick="modifyDep()">SUBMIT</button>-->
                
                <button class="btn btn-rose btn-raised" onclick="goToHome()">GO TO HOME</button>
                
                
            <br>
                <center><p style="padding-left: 15px; font-size: 1.2em;"><span id="errorMessage"></span></p></center>
                
            </center>
        
                
            
            
            
             
            
        
    </body>
    <!--</form>-->
</html>
