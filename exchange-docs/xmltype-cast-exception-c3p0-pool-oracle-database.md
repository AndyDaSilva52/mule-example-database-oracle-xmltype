### XMLTYPE cast exception c3p0 pool Oracle Database

Link: [XMLTYPE cast exception c3p0 pool Oracle Database | MuleSoft Help Center (help.mulesoft.com)](https://help.mulesoft.com/s/article/XMLTYPE-cast-exception-c3p0-pool-Oracle-Database)


java.lang.ClassCastException: com.mchange.v2.c3p0.impl.NewProxyConnection cannot be cast to oracle.jdbc.OracleConnection

Mar 20, 2017 Knowledge

#### SYMPTOM
User reports the following error when using XMLTYPE in a simple db:stored-procedure like the following:

```xml
​      <db:stored-procedure config-ref="Oracle_Configuration" streaming="true" doc:name="test sp">
            <db:parameterized-query><![CDATA[{call procedure1(:param1, :param2, :param3)}]]></db:parameterized-query>
            <db:in-param name="param1" type="VARCHAR" value="hello world"/>
            <db:out-param name="param2" type="XMLTYPE"/>
            <db:out-param name="param3" type="CLOB"/>
        </db:stored-procedure>
```

Here is the stored procedure used in this example:

```sql
CREATE OR REPLACE PROCEDURE PROCEDURE1
(
 PARAM1 IN VARCHAR2
 ,PARAM2 IN XMLTYPE
, PARAM3 OUT CLOB
) AS
BEGIN
PARAM3:= to_clob(PARAM1);
END PROCEDURE1;
```

```bash
Root Exception stack trace:
java.lang.ClassCastException: com.mchange.v2.c3p0.impl.NewProxyConnection cannot be cast to oracle.jdbc.OracleConnection
at oracle.sql.OpaqueDescriptor.createDescriptor(OpaqueDescriptor.java:151)
at oracle.xdb.XMLType.<init>(XMLType.java:1388)
at oracle.xdb.XMLType.<init>(XMLType.java:1378)
at sun.reflect.NativeConstructorAccessorImpl.newInstance0(Native Method)
at sun.reflect.NativeConstructorAccessorImpl.newInstance(NativeConstructorAccessorImpl.java:62)
at sun.reflect.DelegatingConstructorAccessorImpl.newInstance(DelegatingConstructorAccessorImpl.java:45)
at java.lang.reflect.Constructor.newInstance(Constructor.java:423)
at org.mule.module.db.internal.domain.type.oracle.OracleXmlType.createXmlType(OracleXmlType.java:97)
at org.mule.module.db.internal.domain.type.oracle.OracleXmlType.createXmlType(OracleXmlType.java:89)
at org.mule.module.db.internal.domain.type.oracle.OracleXmlType.setParameterValue(OracleXmlType.java:53)
```

#### CAUSE
In the code OpaqueDescriptor.java method createDescriptor the connection is casted to oracle.jdbc.OracleConnection:
(oracle.jdbc.OracleConnection)paramConnection

The thing is that c3p0 (used by default) connection doesn't support this and Oracle.jdbc.OracleConnection should be used. The connection should be configured using spring and oracle.jdbc.pool.OracleDataSource

#### SOLUTION
To avoid the mentioned exception and use XMLTYPE we must set the following connection configuration:


```xml
<spring:beans>
       <spring:bean id="OracleDataSource" name="OracleDataSource" class="oracle.jdbc.pool.OracleDataSource">
           <spring:property name="URL" value="${jdbc.url}" />
           <spring:property name="user" value="${jdbc.user}" />
           <spring:property name="password" value="${jdbc.password}" />
           <spring:property name="connectionCachingEnabled" value="true" />
           <spring:property name="connectionCacheProperties">
               <spring:props merge="default">
                   <spring:prop key="MinLimit">${jdbc.pool.MinLimit}</spring:prop>
                   <spring:prop key="MaxLimit">${jdbc.pool.MaxLimit}</spring:prop>
                   <spring:prop key="ConnectionWaitTimeout">${jdbc.pool.ConnectionWaitTimeout}</spring:prop>
                   <spring:prop key="InactivityTimeout">${jdbc.pool.InactivityTimeout}</spring:prop>
                   <spring:prop key="ValidateConnection">true</spring:prop>
               </spring:props>
           </spring:property>
       </spring:bean>
   </spring:beans>
   <db:oracle-config name="Oracle_Configuration" dataSource-ref="OracleDataSource" doc:name="Oracle Configuration">
       <reconnect-forever frequency="30000" />
   </db:oracle-config>
```