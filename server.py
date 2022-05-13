#from __future__ import unicode_literals
import bottle
from bottle import *
import pymongo
#from bson.json_util import dumps
from datetime import datetime
import time
import json
import os
from bson import json_util, ObjectId
import urllib.parse
from json.encoder import JSONEncoder

from config_vars import *
#from all_functions import *
#from offline_functions import *
from ncd_data_json import *

app = Bottle(__name__)

#client = MongoClient(MONGODB_URI)
#db = client.cas
mongo_uri = "mongodb+srv://akalabsadmin:" + urllib.parse.quote("akalabs123") + "@cluster0.vucpx.mongodb.net/yhbs?retryWrites=true&w=majority"
myclient = pymongo.MongoClient(mongo_uri)
mydb = myclient["yhbs"]


##################### Stress App #####################

@app.route('/')
def root():
	# return template('templates/login.tpl', msg='')
	return static_file('ncdlanding.html', root='templates/')
###Yuvaspandana MIS###

@app.post('/ysgetScheme')
def goToSchemeView():
	# return template('templates/login.tpl', msg='')
    # Scheme ID is input
    # Get the scheme details for the scheme
    # Get the department name for the department ID
    # Contruct the final json
    # go to view page
    print("HERE IN GET SCHEME")
    #reqObj=request.forms.get('data')
    #reqJson= json.loads(reqObj)
    
    requestData = request.json
    schemeId = requestData.get('schemeId')
    print(schemeId)
    
    #print(reqJson)
    #{"schemeId":123456}
    #schemeId= reqJson["schemeId"]
    #print(schemeId)
    schemeFromDB=mydb.yknSchemeDescMaster.find_one({"scheme.schemeID":schemeId},{"_id":0})
    schemeMasterFromDB=mydb.yknSchemeMaster.find_one({"scheme.scheme_ID":schemeId},{"_id":0})
    schemeFromDB["scheme"]["keywords"]=schemeMasterFromDB["scheme"]["keywords"]
    schemeObj=schemeFromDB["scheme"]
    #print(schemeFromDB)
    schemeObj=schemeFromDB["scheme"]
    response = {}
    response["msg"] = "Success"
    response["scheme"] = schemeObj
                    
    #print(response)
                    
    return json.dumps(response)
@app.post('/ysActivateScheme')
def activateScheme():
    print("HERE IN activateScheme")
    scheme=request.forms.get('data')
    #print(department)
    scheme = json.loads(scheme)
    print(scheme["schemeId"])
    print(scheme["updateTime"])
    #print(department["depId"])
    mydb.yknSchemeMaster.find_one_and_update({"scheme.scheme_ID" : scheme["schemeId"]},{"$set":{"scheme.active": True,"scheme.modified_time":scheme["updateTime"]}})
    response = {}
    response["msg"] = "Success"
    #response["scheme"] = schemeObj
                    
    print(response)
                    
    return json.dumps(response)

@app.post('/ysDeactivateScheme')
def deactivateScheme():
    print("HERE IN ysDeactivateScheme")
    scheme=request.forms.get('data')
    #print(department)
    scheme = json.loads(scheme)
    print(scheme["schemeId"])
    print(scheme["updateTime"])
    #print(department["depId"])
    mydb.yknSchemeMaster.find_one_and_update({"scheme.scheme_ID" : scheme["schemeId"]},{"$set":{"scheme.active": False,"scheme.modified_time":scheme["updateTime"]}})
    response = {}
    response["msg"] = "Success"
    #response["scheme"] = schemeObj
                    
    print(response)
                    
    return json.dumps(response)


@app.post('/ysActivateDepartment')
def activateDepartment():
    print("HERE IN activateDepartment")
    department=request.forms.get('data')
    #print(department)
    department = json.loads(department)
    print(department["depId"])
    print(department["updateTime"])
    #print(department["depId"])
    mydb.yknDepartmentMaster.find_one_and_update({"department.dep_id" : department["depId"]},{"$set":{"department.active": True,"department.modified_time":department["updateTime"]}})
    response = {}
    response["msg"] = "Success"
    #response["scheme"] = schemeObj
                    
    print(response)
                    
    return json.dumps(response)

@app.post('/ysDeactivateDepartment')
def deactivateDepartment():
    print("HERE IN deactivateDepartment")
    department=request.forms.get('data')
    #print(department)
    department = json.loads(department)
    print(department["depId"])
    print(department["updateTime"])
    #print(department["depId"])
    mydb.yknDepartmentMaster.find_one_and_update({"department.dep_id" : department["depId"]},{"$set":{"department.active": False,"department.modified_time":department["updateTime"]}})
    response = {}
    response["msg"] = "Success"
    #response["scheme"] = schemeObj
                    
    print(response)
                    
    return json.dumps(response)
    
@app.route('/yuvaspandanaHome')
def gotToYSPHome():
	# return template('templates/login.tpl', msg='')
    departmentsObj = mydb.yknDepartmentMaster.find({"department.active":True})
    departmentArr = []
    for y in  departmentsObj:
        #print(y)
        scheme = mydb.yknSchemeMaster.find({"scheme.dep_id":y['department']['dep_id'],"scheme.active":True})
        schemeArr = []
        for z in  scheme:
            #print(z)
            scheme_id=z['scheme']['scheme_ID']
            scheme_name=z['scheme']['schemeName']['kan']
            scheme_obj={'scheme_id':scheme_id, 'scheme_name':scheme_name}
            schemeArr.append(scheme_obj)
        department={"department":{"Dep_ID":y['department']['dep_id'],"Dep_Short_Name_English":y['department']['shortName']['eng'],"schemes":schemeArr}}
        print(department)
        #print('/////')
        departmentArr.append(department)
    ## Get inactive departments
    inactivedepartmentsObj = mydb.yknDepartmentMaster.find({"department.active":False})
    inactivedepartmentArr = []
    for y in  inactivedepartmentsObj:
        #print(y)
        
        department={"department":{"Dep_ID":y['department']['dep_id'],"Dep_Short_Name_English":y['department']['shortName']['eng']}}
        print(department)
        #print('/////')
        inactivedepartmentArr.append(department)
        
    departments={"Departments":departmentArr,"InactiveDepartments":inactivedepartmentArr}
    #print(departments)
    
    #scheme = mydb.yknSchemeMaster.find({"department.Active":True})
    
    return template('templates/yspSchemeHome.tpl', data=departments)
@app.route('/ysDepartment')
def goToDepartment():
	# return template('templates/login.tpl', msg='')
	return static_file('yspCreateDepartment.html', root='templates/')

@app.route('/yspViewDepartment')
def viewDepartment():
	# return template('templates/login.tpl', msg='')
    departmentsObj = mydb.yknDepartmentMaster.find({"department.active":True})
    departmentArr = []
    for y in  departmentsObj:
        departmentArr.append(y)
    departments={"Departments":departmentArr}
    print(departments)
    
    return template('templates/yspModifyDeparment.tpl', data=departments)

@app.route('/yspViewSchemes')
def goToSchemeList():
	# return template('templates/login.tpl', msg='')
    print("goToSchemeList")
    depId=request.args.get('depId')
    print(depId)
    
    return template('templates/yspSchemeList.tpl')

@app.post('/ysgetDepartment')
def getDepartment():
    
    # return template('templates/login.tpl', msg='')
    print("HERE IN GET Department")
    #department=request.forms.get('data')
    #print(department)
    
    requestData = request.json
    department = requestData.get('depId')
    print(department)
    
    #dep_schema={"depId":null}
   
    #department = json.loads(department)
    #depId=department["depId"]
    print(department)
    #print(depId)
    #mycol = mydb["yknDepartmentMaster"]
    depFromDB=mydb.yknDepartmentMaster.find_one({"department.dep_id":department},{"_id":0})
    print(depFromDB)
    response = {}
    response["msg"] = "Success"
    response["data"] = depFromDB
    print(response)
    print("before dumps")
    #print(json.dumps(response, ensure_ascii=False))
    return json.dumps(response)


@app.post('/ysCreateScheme')
def createScheme():
	# return template('templates/login.tpl', msg='')
    print("HERE IN CREATE SCHEME")
    scheme=request.forms.get('data')
    #print(scheme.decode("utf-8"))
    #json_string = json.dumps(scheme, ensure_ascii=False)
    #assert type(json_string) is unicode
    #r = json.loads(json.dumps(scheme))
    #assert "correct" in r
    #assert type(r["correct"]) is unicode
    #print(r)
    #scheme = request.json
    scheme = json.loads(scheme,  encoding='utf-8')
    #scheme=json.JSONEncoder().encode(scheme)
    #print(scheme)
    mycol = mydb["yknSchemeDescMasterTest"]
    x = mycol.insert_one(scheme)
    
    schemeMaster={
    "scheme": {
        "dep_id": scheme['scheme']['department'],
        "scheme_ID": scheme['scheme']['schemeID'],
        "schemeShortName": {
            "kan": scheme['scheme']['schemeShortName']['details']['kan'],
            "eng": scheme['scheme']['schemeShortName']['details']['eng']
        },
        "schemeName": {
            "kan": scheme['scheme']['schemeName']['details']['kan'],
            "eng": scheme['scheme']['schemeName']['details']['eng']
        },
        "schemeDesc": {
            "kan": scheme['scheme']['detailedschemeName']['details']['kan'],
            "eng": scheme['scheme']['detailedschemeName']['details']['eng']
        },
        "scheme_Logo": "logo.png",
        "active": "Y",
        "created_Time": scheme['scheme']['Created_Time'],
        "created_By": scheme['scheme']['Created_By'],
        "modified_Time": scheme['scheme']['Modified_Time'],
        "modified_By": scheme['scheme']['Modified_By']
    }
    }
    #mycol = mydb["yknSchemeMasterTest"]
    #x = mycol.insert_one(schemeMaster)
    
    lastSchemeNumber=scheme['scheme']['schemeNumber']
    mydb.yknDepartmentMaster.find_one_and_update({"department.dep_id" : scheme["department"]},{"$set":{"department.lastSchemeID": lastSchemeNumber,"department.modified_time":scheme['scheme']['Modified_Time']}})
        
    response = {}
    response["msg"] = "Success"
	
    return json.dumps(response)

@app.post('/incrementSchemeNum')
def incrementSchemeNum():
    print("HERE IN incrementSchemeNum")
    scheme=request.forms.get('data')
    scheme = json.loads(scheme,  encoding='utf-8')
    
    lastSchemeNumber=scheme['scheme']['schemeNumber']
    mydb.yknDepartmentMaster.find_one_and_update({"department.dep_id" : scheme['scheme']["department"]},{"$set":{"department.lastSchemeID": lastSchemeNumber,"department.modified_time":scheme['scheme']['Modified_Time']}})
    
    
    response = {}
    response["msg"] = "Success"
	
    return json.dumps(response)

    
@app.post('/ysCreateDep')
def createDepartment():
	# return template('templates/login.tpl', msg='')
    print("HERE IN CREATE Department")
    department=request.forms.get('data')
    print(department)
    department = json.loads(department)
    print("After json")
    print(department)
    #kanName= department['department']['shortName']['kan']
    #print(kanName)
    #print(codecs.decode(kanName))
    #department=codecs.decode(department)
    #print("///////")
    #print(department)
    #print(department.decode("utf-8"))
    #json_string = json.dumps(scheme, ensure_ascii=False)
    #assert type(json_string) is unicode
    #r = json.loads(json.dumps(scheme))
    #assert "correct" in r
    #assert type(r["correct"]) is unicode
    #print(r)
    #scheme = request.json
    #department = json.loads(department)
    #scheme=json.JSONEncoder().encode(scheme)
    #print(scheme)
    mycol = mydb["yknDepartmentMaster"]
    x = mycol.insert_one(department)
    response = {}
    response["msg"] = "Success"
	
    return json.dumps(response)
	

@app.route('/ysSelectScheme')
def getAllDepsAndSchemes():
	# return template('templates/login.tpl', msg='')
    departmentsObj = mydb.yknDepartmentMaster.find({"department.active":True})
    departmentArr = []
    for y in  departmentsObj:
        #print(y)
        scheme = mydb.yknSchemeMaster.find({"scheme.dep_id":y['department']['dep_id'],"scheme.active":True})
        schemeArr = []
        for z in  scheme:
            #print(z)
            scheme_id=z['scheme']['scheme_ID']
            #scheme_name=z['scheme']['schemeName']['eng']
            scheme_name=z['scheme']['schemeName']['kan']
            scheme_obj={'scheme_id':scheme_id, 'scheme_name':scheme_name}
            schemeArr.append(scheme_obj)
        inactivescheme = mydb.yknSchemeMaster.find({"scheme.dep_id":y['department']['dep_id'],"scheme.active":False})
        inactiveschemeArr = []
        for z in  inactivescheme:
            #print(z)
            scheme_id=z['scheme']['scheme_ID']
            #scheme_name=z['scheme']['schemeName']['eng']
            scheme_name=z['scheme']['schemeName']['kan']
            scheme_obj={'scheme_id':scheme_id, 'scheme_name':scheme_name}
            inactiveschemeArr.append(scheme_obj)
            
        department={"department":{"Dep_ID":y['department']['dep_id'],"Dep_Short_Name_English":y['department']['shortName']['eng'],"Schemes":schemeArr,"inactiveSchemes":inactiveschemeArr}}
        departmentArr.append(department)
                    
    departments={"Departments":departmentArr}
    return template('templates/yspSchemeList.tpl',data=departments)
@app.route('/yspViewScheme')
def viewScheme():
    return template('templates/yspSchemeView.tpl')
    
@app.route('/yuvaspandanaScheme')
def goToScheme():
	# return template('templates/login.tpl', msg='')
    departmentsObj = mydb.yknDepartmentMaster.find({"department.active":True})
    departmentArr = []
    for y in  departmentsObj:
        departmentArr.append(y)
    departments={"Departments":departmentArr}
    print(departments)
    return template('templates/yspScheme.tpl', data=departments)



###Yuvaspandana MIS End###

@app.route('/ncdlanding')
def root():
	# return template('templates/login.tpl', msg='')
	return static_file('ncdlanding.html', root='templates/')

@app.route('/ncdStress')
def ncd_stress():
	data = get_stress_json()
	return template('templates/assessment_stress_home.tpl', data=data)

@app.route('/ncdScreening')
def ncd_screening():
	data = get_screening_json()
	return template('templates/assessment_screening_home.tpl', data=data)

@app.route('/ncdRapid')
def ncd_rapid():
	data = get_rapid_json()
	return template('templates/assessment_rapid_home.tpl', data=data)

@app.route('/ncdFeasibility')
def ncd_feasibility():
	data = get_feasibility_json()
	return template('templates/assessment_feasibility_home.tpl', data=data)

@app.route('/ncdhome')
def ncd_home():
	#data = get_stress_json()
    # to be created
	return static_file('ncd_home.html', root='templates/')

@app.route('/ncdscreening_score')
def ncdStress_score():
	return static_file('assessment_screening_score.html', root='templates/')

@app.route('/ncdfeasibility_score')
def ncdFeasibility_score():
	return static_file('assessment_feasibility_score.html', root='templates/')

@app.route('/ncdrapid_score')
def ncdRapid_score():
	return static_file('assessment_rapid_score.html', root='templates/')

@app.route('/ncdStress_score')
def assessment_score():
	return static_file('assessment_stress_score.html', root='templates/')

@app.route('/ncdFeasometer')
def ncd_feasometer():
	data = get_feasometer()
	return template('templates/assessment_feasometer_home.tpl', data=data)

@app.route('/ncdOrgRegistration')
def ncd_orgReg():
	data = get_org_json()
	return template('templates/ncd_org_Reg_home.tpl', data=data)

@app.route('/ncdthankyou')
def ncdRapid_score():
	return static_file('ncdThankyou.html', root='templates/')



@app.route('/policy')
def policy():
	return static_file('policy.pdf', root='templates/')

#/ncd_home -- NCD Home page

#/ncd_screening 

#/ncd_rapid

#/ncd_feasibility

#/ncd_workstress

####Other assessments to be added here #######

##################### Stress App #####################

@app.post('/add_ncdstress_assessment')
def add_ncd_Stress():

	assessment_data = request.forms.get('data')
	time_stamp = time.time()

	try:
		assessment_data = json.loads(assessment_data)
	except Exception as e:
		print(e)

	#cur = db.stress_assessments.insert({'ncd_stress_data': assessment_data, 'time_stamp': time_stamp})
	return {'status': 'ok'}

@app.post('/add_ncdfeasibility_assessment')
def add_ncd_feasibility():

	assessment_data = request.forms.get('data')
	time_stamp = time.time()

	try:
		assessment_data = json.loads(assessment_data)
	except Exception as e:
		print(e)

	#cur = db.stress_assessments.insert({'ncd_stress_data': assessment_data, 'time_stamp': time_stamp})
	return {'status': 'ok'}

@app.post('/add_ncdrapid_assessment')
def add_ncd_rapid():

	assessment_data = request.forms.get('data')
	time_stamp = time.time()

	try:
		assessment_data = json.loads(assessment_data)
	except Exception as e:
		print(e)

	#cur = db.stress_assessments.insert({'ncd_rapid_data': assessment_data, 'time_stamp': time_stamp})
	return {'status': 'ok'}

@app.post('/add_ncdscreening_assessment')
def add_ncd_screening():

	assessment_data = request.forms.get('data')
	time_stamp = time.time()

	try:
		assessment_data = json.loads(assessment_data)
	except Exception as e:
		print(e)

	#cur = db.stress_assessments.insert({'ncd_screening_data': assessment_data, 'time_stamp': time_stamp})
	return {'status': 'ok'}

@app.post('/add_ncdfeasometer_assessment')
def add_feasometer():

	assessment_data = request.forms.get('data')
	time_stamp = time.time()

	try:
		assessment_data = json.loads(assessment_data)
	except Exception as e:
		print(e)

	#cur = db.stress_assessments.insert({'ncd_feasometer_data': assessment_data, 'time_stamp': time_stamp})
	return {'status': 'ok'}

@app.post('/add_organization_Details')
def add_OrganizationDetails():

	assessment_data = request.forms.get('data')
	time_stamp = time.time()

	try:
		assessment_data = json.loads(assessment_data)
	except Exception as e:
		print(e)

	#cur = db.stress_assessments.insert({'ncd_feasometer_data': assessment_data, 'time_stamp': time_stamp})
	return {'status': 'ok'}

######################### Static Routes Start #########################

# @app.route('/<filename:re:.*\.js>')
# def javascripts(filename):
#     return static_file(filename, root='static')

# @app.route('/<filename:re:.*\.css>')
# def stylesheets(filename):
#     return static_file(filename, root='static')

# @app.route('/<filename:re:.*\.(jpg|png|gif|ico|svg)>')
# def images(filename):
#     return static_file(filename, root='static')

# @app.route('/<filename:re:.*\.(eot|ttf|woff|svg)>')
# def fonts(filename):
#     return static_file(filename, root='static')

@app.route('/<filename:re:.*\.*>')
def javascripts(filename):
    return static_file(filename, root='static')

@app.hook('after_request')
def enable_cors():
	response.headers['Access-Control-Allow-Origin'] = '*'
	response.headers['Access-Control-Allow-Methods'] = 'PUT, GET, POST, DELETE, OPTIONS'
	response.headers['Access-Control-Allow-Headers'] = 'Origin, Accept, Content-Type, X-Requested-With, X-CSRF-Token'

######################### Static Routes End #########################
