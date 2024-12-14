### "Invalid column type" error when calling Oracle Stored Procedure with XMLTYPE parameter

Link: ["Invalid column type" error when calling Oracle Stored Procedure with XMLTYPE parameter | MuleSoft Help Center (help.mulesoft.com)](https://help.mulesoft.com/s/article/Invalid-column-type-error-when-calling-Oracle-Stored-Procedure-with-XMLTYPE-parameter)

Jul 25, 2017 Knowledge

#### SYMPTOM
When trying to invoke the Oracle Stored Procedure with XMLTYPE parameter, if you are getting the below exception

```bash
*******************************************************************************
Message : java.sql.SQLException: Invalid column type (org.mule.module.db.internal.result.statement.OutputParamProcessingException). Message payload is of type: NullPayload
Code : MULE_ERROR--2
--------------------------------------------------------------------------------
Exception stack is:
1. Invalid column type (java.sql.SQLException)
oracle.jdbc.driver.NamedTypeAccessor:438 (null)
2. java.sql.SQLException: Invalid column type (org.mule.module.db.internal.result.statement.OutputParamProcessingException)
org.mule.module.db.internal.result.statement.StatementResultIterator:220 (http://www.mulesoft.org/docs/site/current3/apidocs/org/mule/module/db/internal/result/statement/OutputParamProcessingException.html)
3. java.sql.SQLException: Invalid column type (org.mule.module.db.internal.result.statement.OutputParamProcessingException). Message payload is of type: NullPayload (org.mule.api.MessagingException)
org.mule.execution.ExceptionToMessagingExceptionExecutionInterceptor:32 (http://www.mulesoft.org/docs/site/current3/apidocs/org/mule/api/MessagingException.html)
--------------------------------------------------------------------------------
Root Exception stack trace:
java.sql.SQLException: Invalid column type
at oracle.jdbc.driver.NamedTypeAccessor.getSQLXML(NamedTypeAccessor.java:438)
at oracle.jdbc.driver.OracleCallableStatement.getSQLXML(OracleCallableStatement.java:7007)
at oracle.jdbc.driver.OracleCallableStatementWrapper.getSQLXML(OracleCallableStatementWrapper.java:858)
+ 3 more (set debug level logging or '-Dmule.verbose.exceptions=true' for everything)
********************************************************************************
```

#### CAUSE
To use this data type the application will require additional configuration and Oracle's libraries.

#### SOLUTION
Please ensure that:

1. Your Stored Procedure has the field type "XMLTYPE" defined correctly.
2. You Mule configuration has the field type "XMLTYPE" defined correctly
3. You have the necessary Oracle libs in your project, depending on the actual Oracle DMBS instance that you are connecting, if you are connecting to 11g XE, normally it should include
```bash
-rw-r--r--   1 dereklin  staff    2739670 Jun 23 11:58 ojdbc6.jar
-rw-r-----@  1 dereklin  staff    1669145 Jul 14 08:31 xmlparserv2.jar
-rwxr-xr-x   1 dereklin  staff     244175 Jul 13 14:21 xdb.jar
```
Please also pay attention to the xmlparserv2.jar, there are different version of the xmlparserv2.jar distributed by Oracle, using the wrong version of the xmlparserv2.jar will also result in other exception such as "oracle.xml.binxml.BinXMLMetadataProvider (java.lang.ClassNotFoundException)"

Sample flow:

```xml
<db:oracle-configname="Oracle_Configuration"host="${db.host}"port="${db.port}"instance="${db.instance}"user="${db.user}"password="${db.password}"doc:name="Oracle Configuration"/>
<context:property-placeholderlocation="db.properties"/>
<http:listener-configname="HTTP_Listener_Configuration"host="localhost"port="8081"doc:name="HTTP Listener Configuration"/>

<flow name="connector_db_oracle_sp_xmltypeFlow">
 <http:listenerconfig-ref="HTTP_Listener_Configuration"path="/"doc:name="HTTP"/>
 <db:stored-procedureconfig-ref="Oracle_Configuration"doc:name="Database">
  <db:parameterized-query><![CDATA[ call my_procedure(:my_xml)]]></db:parameterized-query>
  <db:out-paramname="my_xml"type="XMLTYPE"/>
 </db:stored-procedure>
 <mulexml:object-to-xml-transformerdoc:name="Object to XML"/>
</flow>
```

If you would like to use XMLTYPE in your select statement, for example, return a String representation, you can use

```sql
select (AGENT_XML).getStringVal() AS AGENT_XML from TABLE1 where AGENT_XML is of XMLTYPE in TABLE1
```

Note
- It has been reported that for newer versions a different version of xdb must be used to match the driver version. For example xdb6.jar with ojdbc6.jar.
- In some cases the type SQLXML should be used instead of XMLTYPE.