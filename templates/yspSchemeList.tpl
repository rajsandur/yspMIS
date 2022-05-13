<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <link rel="apple-touch-icon" sizes="76x76" href="">
  <link rel="icon" type="image/png" href="">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>
    Yuvakanaja MIS Home
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
    
    <style>
table, td, th {
  border: 1px solid pink;
  text-align: center;
  color: black;
  font-weight: 1000
 
}

table {
  width: 100%;
  border-collapse: collapse;
}
</style>
    
    
</head>
    

    
    <script type="text/javascript">
        
        $(document).ready(function(){
       //var department = GetUrlParameter('depId');
       //alert(department)
            
            var selectList = document.createElement("select");
            selectList.id = "schemeName";
            selectList.name = "schemeName";
            //myParent.appendChild(selectList);
            tdElement=document.getElementById("schemeColumn");
             var option = document.createElement("option");
             option.value = "";
             option.text = "--Select--";
             selectList.appendChild(option);
             % for z in data['Departments'][0]['department']['Schemes']:
                 option = document.createElement("option");
                 option.value = "{{!z['scheme_id']}}";
                 option.text = "{{!z['scheme_name']}}";
                 selectList.appendChild(option);

                % end

            tdElement.appendChild(selectList)
            
            selectList = document.createElement("select");
            selectList.id = "inactiveschemeName";
            selectList.name = "inactiveschemeName";
            //myParent.appendChild(selectList);
            tdElement=document.getElementById("inactiveschemeColumn");
             var option = document.createElement("option");
             option.value = "";
             option.text = "--Select--";
             selectList.appendChild(option);
             % for z in data['Departments'][0]['department']['inactiveSchemes']:
                 option = document.createElement("option");
                 option.value = "{{!z['scheme_id']}}";
                 option.text = "{{!z['scheme_name']}}";
                 selectList.appendChild(option);

                % end

            tdElement.appendChild(selectList)
            
            
            
      
       
});
        
        function getSchemes(depId){
           
            //document.removeChild("schemeName")
            var element = document.getElementById("schemeName");
            element.parentNode.removeChild(element);    
            var selectList = document.createElement("select");
            selectList.id = "schemeName";
            selectList.name = "schemeName";
            //myParent.appendChild(selectList);
            tdElement=document.getElementById("schemeColumn");
             % for y in data['Departments']:
                 depElement="{{!y['department']['Dep_ID']}}"
                 if(depElement==depId){
                     var option = document.createElement("option");
                     option.value = "";
                     option.text = "--Select--";
                     selectList.appendChild(option);

                   % for z in y['department']['Schemes']:
                     option = document.createElement("option");
                     option.value = "{{!z['scheme_id']}}";
                     option.text = "{{!z['scheme_name']}}";
                     selectList.appendChild(option);

                    % end
                 }
             % end
             tdElement.appendChild(selectList)
            
            
            element = document.getElementById("inactiveschemeName");
            element.parentNode.removeChild(element);    
            var selectList = document.createElement("select");
            selectList.id = "inactiveschemeName";
            selectList.name = "inactiveschemeName";
            //myParent.appendChild(selectList);
            tdElement=document.getElementById("inactiveschemeColumn");
             % for y in data['Departments']:
                 depElement="{{!y['department']['Dep_ID']}}"
                 if(depElement==depId){
                     var option = document.createElement("option");
                     option.value = "";
                     option.text = "--Select--";
                     selectList.appendChild(option);

                   % for z in y['department']['inactiveSchemes']:
                     option = document.createElement("option");
                     option.value = "{{!z['scheme_id']}}";
                     option.text = "{{!z['scheme_name']}}";
                     selectList.appendChild(option);

                    % end
                 }
             % end
             tdElement.appendChild(selectList)
                    
                    
            
            
            
            
        }
        
        function getScheme(){
            
            //alert(document.getElementById("schemeName").value.trim())
            
            if(document.getElementById("schemeName").value.trim() === ""){
                alert("Please select the scheme you want to modify")
            }else{
                schemeObj={"schemeId":document.getElementById("schemeName").value.trim()}
                //Redirect by passing schemeID
                window.location.href = '/yspViewScheme?schemeId=' +document.getElementById("schemeName").value.trim()
            }
            
        }
        
        function goToHome(){
            window.location.href = '/yuvaspandanaHome'
        }
        
        function deactivateScheme(){
            if(document.getElementById("schemeName").value.trim()===""){
                alert("Please select a Scheme you want to deactivate")
            }else{
                
                var today = new Date();
              var savetime=today.getDate()+"/"+(today.getMonth()+1)+"/"+today.getFullYear()+"-"+today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
              scheme = document.getElementById("schemeName").value.trim()
              schemeObj={"schemeId":document.getElementById("schemeName").value.trim(),"updateTime":savetime}
              var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                      //localStorage.removeItem(localStorageKey)
                      window.location.href =  '/yuvaspandanaHome'
                    }
                };
                xhttp.open("POST", "/ysDeactivateScheme", true);
                xhttp.setRequestHeader("Content-type", "application/json");
                xhttp.send('data='+JSON.stringify(schemeObj));
                
               
                
            }
        }
        
        function activateScheme(){
          
         if(document.getElementById("inactiveschemeName").value.trim()===""){
                alert("Please select a Scheme you want to Activate")
            }else{
                
                var today = new Date();
              var savetime=today.getDate()+"/"+(today.getMonth()+1)+"/"+today.getFullYear()+"-"+today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
              scheme = document.getElementById("inactiveschemeName").value.trim()
              schemeObj={"schemeId":document.getElementById("inactiveschemeName").value.trim(),"updateTime":savetime}
              var xhttp = new XMLHttpRequest();
                xhttp.onreadystatechange = function() {
                    if (this.readyState == 4 && this.status == 200) {
                      //localStorage.removeItem(localStorageKey)
                      window.location.href =  '/yuvaspandanaHome'
                    }
                };
                xhttp.open("POST", "/ysActivateScheme", true);
                xhttp.setRequestHeader("Content-type", "application/json");
                xhttp.send('data='+JSON.stringify(schemeObj));
                
               
                
            }
          
      }
        
        

        
     
  </script>
    


<body class="landing-page sidebar-collapse">
  
  <div class="main main-raised" style="margin-top: 50px; margin-bottom: 50px;">
    <div class="container">
      <div class="section text-center">
        <div class="row">
          <div class="col-md-8 ml-auto mr-auto">            
            
            <!--<img src="img/gok.png" style="width: 100px;">
            <br>-->
        
                  <img src="img/nimhans.png" style="width: 75px;">
                  <img src="img/cph.png" style="width: 75px;">
              <!--PREVENTION OF NON COMMUNICABLE DISEASES IN WORK PLACES-->

            <h2 class="title"><span id="title">Management of Departments and Schemes for YuvaKanaja</span></h2>

          </div>
        </div>
          
        
          <table id="selectScheme" name="selectScheme">
            
              <tr id="headerRow" name="headerRow">
                  <th>
                      Department
                  </th>
                  <th>
                      Active Schemes
                  </th>
                  <th>
                      Inactive Schemes
                  </th>
              </tr>
              <tr id="dataRow" name="dataRow">
                  
                  <td id="depColumn" name="depColumn">
                      
                                
                               
                            
                        
                       <select name="depName" id="depName" required onchange="getSchemes(this.value)">
                                
                                % for y in data['Departments']:
                                    <option value="{{!y['department']['Dep_ID']}}" style="text-align-last: center" >{{!y['department']['Dep_Short_Name_English']}}</option>
                                % end
                                
                                
                            
                            </select>
                            
                                
                                
                  </td>
                  
                  <td id="schemeColumn" name="schemeColumn">
                      
                                
                               
                            
                
                            
                                
                                
                  </td>
                  
                  <td id="inactiveschemeColumn" name="inactiveschemeColumn">
                      
                                
                               
                            
                
                            
                                
                                
                  </td>
                  
              </tr>
              <tr>
                  <td colspan="2">
                      <center>
                  <button class="btn btn-rose btn-raised" onclick="getScheme()">
                                  MODIFY
                                </button>
                    <button class="btn btn-rose btn-raised" onclick="deactivateScheme()">
                                  DEACTIVATE
                                </button>
                          
              </center>
                  </td>
                  <td>
                   <center>
                  <button class="btn btn-rose btn-raised" onclick="activateScheme()">
                                  ACTIVATE
                                </button>
                      </center>
                  </td>
              </tr>
              
              <tr>
                  <td colspan="3">
                      <center>
                  <button class="btn btn-rose btn-raised" onclick="goToHome()">
                                  GO TO HOME
                                </button>
              </center>
                  </td>
              </tr>
              
              
              
              
              
              
              
              
              
              
              
              
              
              
          
          </table>
        
        
      </div>
      
      
    </div>
    <div class="row" style="">
      <div class="col-md-6 ml-auto mr-auto text-center" style="padding: 25px;">
        <!--<a href="/logout">Logout</a>
        <br>-->
        <p style="font-size: 0.7em;">POWERED BY AKA LABS</p>
      </div>
    </div>
  </div>
  
  <!--   Core JS Files   -->
  <script src="../assets/js/core/jquery.min.js" type="text/javascript"></script>
  <script src="../assets/js/core/popper.min.js" type="text/javascript"></script>
  <script src="../assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
  <script src="../assets/js/plugins/moment.min.js"></script>
  <!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
  <script src="../assets/js/plugins/bootstrap-datetimepicker.js" type="text/javascript"></script>
  <!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
  <script src="../assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
  <!--  Google Maps Plugin    -->
  <!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
  <script src="../assets/js/material-kit.js?v=2.0.7" type="text/javascript"></script>
  <script type="text/javascript">
  
</script>
</body>

</html>
