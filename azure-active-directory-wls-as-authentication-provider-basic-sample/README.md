This article intoduces how to deploy a secure Java EE application to Weblogic server with basic authentication using Azure Active Directory (AAD) authentication provider.

## Prerequisites
* Install [Oracle JDK 8](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)  
* Install [mvn](https://maven.apache.org/download.cgi)  
* [Azure Active Directory with LDAP configured](https://docs.microsoft.com/en-us/azure/active-directory-domain-services/tutorial-configure-ldaps).
* Set up [WebLogic Server that has integrated Azure Active Directory](https://portal.azure.com/#create/oracle.20191009-arm-oraclelinux-wls-admin-preview20191009-arm-oraclelinux-wls-admin)  

## Create secure roles
We will only allow users with `webuser` role to access the application.  
We will set up role named webuser to secure Java EE applciation, granting users from AAD group aad-webuser with the role.  
Firstly, create group name `aad-webuser` in AAD and add user to the group.  
* Go to azure portal https://ms.portal.azure.com and login.  
* Search `Active Directory`, and click "Azure Active Directory"  
* Go to "Manage" in the left panel, click "Users"  
* Click "New user", select "Create user"
* Specify "User name" with test
* Specify "Name" with Test， Click Create.  
* Go back to Azure Active Direcroty by clicking "Default Direcroty | Overview"  
* * Go to "Manage" in the left panel, click "Groups" 
* Click "New Group" 
* Specify "Group Name" with `aad-webuser`
* Hit Create
It will take several seconds to create the group, when it ready, click group "aad-webuser", click members and add test user to the group.

Secondly, make sure Azure Active Directory is accessible from weblogic server, you will find users from AD provider in this page.  

Then create role in WebLoigc Server.
* Go to WebLogic Server console portal.  
* 

## Configure Java EE application security
We will limite access to the web application, only allow user with `webuser` role to login.  
We have to add security-constraint configuration to web.xml as following.  
```
<security-constraint>
        <web-resource-collection>
            <web-resource-name>Success</web-resource-name>
            <url-pattern>/welcome.jsp</url-pattern>
            <http-method>GET</http-method>
            <http-method>POST</http-method>
        </web-resource-collection>
        <auth-constraint>
            <role-name>webuser</role-name>
        </auth-constraint>
    </security-constraint>
    <login-config>
        <auth-method>BASIC</auth-method>
        <realm-name>myrealm</realm-name>
    </login-config>
    <security-role>
        <role-name>webuser</role-name>
    </security-role>
```
Besides, we need to configure weblogic as following:  
```
<?xml version='1.0' encoding='UTF-8'?>
<weblogic-web-app xmlns="http://www.bea.com/ns/weblogic/90" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <security-role-assignment>
        <role-name>webuser</role-name>
        <principal-name>aad-webuser</principal-name>
    </security-role-assignment>
</weblogic-web-app>
```

`aad-webuser` is group from AAD, we created just now.  

## Deploy Java EE application
Build the application with command:  
```
mvn package
```
You will get wlssecurity-1.0.0.war in target folder.  

Then deploy the applciation to weblogic with the following steps:  
* Go to Admin Server console portal  
* 

## Test with different users