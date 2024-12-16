# Oracle XMLType with Mule 4

This example shows how to use Oracle XMLType in Mule 4 and how to call Oracle Stored Procedures with XMLType parameters.

## Prerequisites

- **Mule 4 Runtime**: Ensure Mule 4 is installed and set up.
- **Oracle Database**: A running Oracle Database instance with support for XMLType.
- **Docker**: Ensure Docker is installed to run Oracle Database locally if needed.

## Setup Instructions

1. **Database Configuration**:
   - Run the provided SQL script to set up the necessary database objects.
     ```bash
     docker-compose up -d
     ```
   - At startup it will execute the scripts in the `docker/oracle-db/scripts` directory and create a few objects in the `C##TEST` owner. Take note for the stored procedure `CREATE_PERSON_FROM_XML` that is used in the Mule application.

2. **Configure Mule Application**:
   - On the `src/main/resources` directory, it can be found the `common-config.yaml` file with the Oracle Database connection details:

3. **Running the Application**:
   - Deploy the Mule application using Anypoint Studio.

## Troubleshooting

Some issues happened during the development of this example, so here are some tips to help you troubleshoot:

### Error: Cannot load class 'oracle.xdb.XMLType'

```bash
Message               : org.mule.runtime.module.artifact.api.classloader.exception.CompositeClassNotFoundException: Cannot load class 'oracle.xdb.XMLType': [
	Class 'oracle.xdb.XMLType' has no package mapping for region 'domain/default/app/mule-example-database-oracle-xmltype'., 
	Cannot load class 'oracle.xdb.XMLType': [
	Class 'oracle.xdb.XMLType' has no package mapping for region '/domain/default'., 
	Class 'oracle.xdb.XMLType' not found in classloader for artifact 'container'.]]
```

This error is caused by the XDB and XMLParserV2 dependencies not being included in the project's `lib` directory.

<!--
### Error: java.lang.reflect.InvocationTargetException

```bash
Message               : java.lang.reflect.InvocationTargetException
```
-->

### Error: XSDException: Duplicated definition for: 'identifiedType'

```bash
<Line 43, Column 57>: XML-24509: (Error) Duplicated definition for: 'identifiedType'
<Line 61, Column 28>: XML-24509: (Error) Duplicated definition for: 'beans'
<Line 182, Column 34>: XML-24509: (Error) Duplicated definition for: 'description'
<Line 194, Column 29>: XML-24509: (Error) Duplicated definition for: 'import'
<Line 216, Column 28>: XML-24509: (Error) Duplicated definition for: 'alias'
<Line 245, Column 33>: XML-24509: (Error) Duplicated definition for: 'beanElements'
<Line 260, Column 44>: XML-24509: (Error) Duplicated definition for: 'beanAttributes'
<Line 515, Column 43>: XML-24509: (Error) Duplicated definition for: 'meta'
<Line 523, Column 35>: XML-24509: (Error) Duplicated definition for: 'metaType'
<Line 540, Column 27>: XML-24509: (Error) Duplicated definition for: 'bean'
<Line 560, Column 38>: XML-24509: (Error) Duplicated definition for: 'constructor-arg'
<Line 639, Column 51>: XML-24509: (Error) Duplicated definition for: 'property'
<Line 650, Column 32>: XML-24509: (Error) Duplicated definition for: 'qualifier'
<Line 666, Column 48>: XML-24509: (Error) Duplicated definition for: 'attribute'
<Line 676, Column 36>: XML-24509: (Error) Duplicated definition for: 'lookup-method'
<Line 718, Column 38>: XML-24509: (Error) Duplicated definition for: 'replaced-method'
<Line 755, Column 31>: XML-24509: (Error) Duplicated definition for: 'arg-type'
<Line 782, Column 26>: XML-24509: (Error) Duplicated definition for: 'ref'
<Line 811, Column 28>: XML-24509: (Error) Duplicated definition for: 'idref'
<Line 836, Column 28>: XML-24509: (Error) Duplicated definition for: 'value'
<Line 864, Column 27>: XML-24509: (Error) Duplicated definition for: 'null'
<Line 878, Column 39>: XML-24509: (Error) Duplicated definition for: 'collectionElements'
<Line 897, Column 28>: XML-24509: (Error) Duplicated definition for: 'array'
<Line 920, Column 27>: XML-24509: (Error) Duplicated definition for: 'list'
<Line 943, Column 26>: XML-24509: (Error) Duplicated definition for: 'set'
<Line 964, Column 26>: XML-24509: (Error) Duplicated definition for: 'map'
<Line 985, Column 45>: XML-24509: (Error) Duplicated definition for: 'entry'
<Line 994, Column 28>: XML-24509: (Error) Duplicated definition for: 'props'
<Line 1016, Column 26>: XML-24509: (Error) Duplicated definition for: 'key'
<Line 1027, Column 27>: XML-24509: (Error) Duplicated definition for: 'prop'
<Line 1046, Column 39>: XML-24509: (Error) Duplicated definition for: 'propertyType'
<Line 1090, Column 41>: XML-24509: (Error) Duplicated definition for: 'collectionType'
<Line 1102, Column 40>: XML-24509: (Error) Duplicated definition for: 'listOrSetType'
<Line 1111, Column 34>: XML-24509: (Error) Duplicated definition for: 'mapType'
<Line 1133, Column 36>: XML-24509: (Error) Duplicated definition for: 'entryType'
<Line 1180, Column 36>: XML-24509: (Error) Duplicated definition for: 'propsType'
<Line 1193, Column 45>: XML-24509: (Error) Duplicated definition for: 'defaultable-boolean'
INFO  2024-12-13 20:05:56,248 [WrapperListener_start_runner] [processor: ; event: ] org.mule.runtime.api.message.AbstractMuleMessageBuilderFactory: Loaded MuleMessageBuilderFactory implementation 'org.mule.runtime.core.internal.message.DefaultMessageBuilderFactory' from classloader 'org.mule.runtime.module.reboot.internal.MuleContainerSystemClassLoader@6d8cee40'
INFO  2024-12-13 20:05:56,259 [WrapperListener_start_runner] [processor: ; event: ] org.mule.runtime.api.el.AbstractBindingContextBuilderFactory: Loaded BindingContextBuilderFactory implementation 'org.mule.runtime.core.api.el.DefaultBindingContextBuilderFactory' from classloader 'org.mule.runtime.module.reboot.internal.MuleContainerSystemClassLoader@6d8cee40'
ERROR 2024-12-13 20:05:56,296 [WrapperListener_start_runner] [processor: ; event: ] org.mule.runtime.config.internal.SpringRegistry: Failed to shut down registry cleanly: org.mule.Registry.Spring
org.mule.runtime.api.lifecycle.LifecycleException: org.mule.runtime.api.exception.MuleRuntimeException: Failed to lookup beans of type class java.lang.Object from the Spring registry
Caused by: org.mule.runtime.api.exception.MuleRuntimeException: org.mule.runtime.api.exception.MuleRuntimeException: Failed to lookup beans of type class java.lang.Object from the Spring registry
Caused by: org.mule.runtime.api.exception.MuleRuntimeException: Failed to lookup beans of type class java.lang.Object from the Spring registry
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'Database_Config_OracleDataSource': Cannot create inner bean '(inner bean)#71604b43' of type [org.mule.runtime.module.extension.internal.config.dsl.connection.ConnectionProviderObjectFactory$$EnhancerByCGLIB$$fc09cb67] while setting bean property 'connectionProviderResolver'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name '(inner bean)#71604b43': Initialization of bean failed; nested exception is java.lang.IllegalStateException: BeanFactory not initialized or already closed - call 'refresh' before accessing beans via the ApplicationContext
	at org.springframework.beans.factory.support.BeanDefinitionValueResolver.resolveInnerBean(BeanDefinitionValueResolver.java:389) ~[spring-beans-5.3.21.jar:5.3.21]
...
Caused by: org.springframework.beans.factory.BeanCreationException: Error creating bean with name '(inner bean)#71604b43': Initialization of bean failed; nested exception is java.lang.IllegalStateException: BeanFactory not initialized or already closed - call 'refresh' before accessing beans via the ApplicationContext
...
ERROR 2024-12-13 20:05:56,307 [WrapperListener_start_runner] [processor: ; event: ] org.mule.runtime.module.deployment.impl.internal.application.DefaultMuleApplication: org.springframework.beans.factory.xml.XmlBeanDefinitionStoreException: Line 14 in XML document from org.mule.extension.spring.internal.context.ResourceDelegate@79ec3d46 is invalid; nested exception is org.xml.sax.SAXParseException; lineNumber: 14; columnNumber: 75; <Line 14, Column 75>: XML-24500: (Error) Can not build schema 'http://www.springframework.org/schema/jdbc' located at 'http://www.springframework.org/schema/jdbc/spring-jdbc-4.2.xsd'
oracle.xml.parser.schema.XSDException: Duplicated definition for: 'identifiedType'
	at oracle.xml.parser.schema.XSDBuilder.buildSchema(XSDBuilder.java:1198) ~[xmlparserv2-23.6.0.24.10.jar:23.0.0.0.0]
...
ERROR 2024-12-13 20:05:56,508 [WrapperListener_start_runner] org.mule.runtime.module.deployment.internal.DefaultArchiveDeployer: Failed to deploy artifact [mule-example-database-oracle-xmltype]
org.mule.runtime.deployment.model.api.DeploymentException: Failed to deploy artifact [mule-example-database-oracle-xmltype]
Caused by: org.mule.runtime.api.exception.MuleRuntimeException: org.mule.runtime.deployment.model.api.DeploymentInitException: XSDException: Duplicated definition for: 'identifiedType'
Caused by: org.mule.runtime.deployment.model.api.DeploymentInitException: XSDException: Duplicated definition for: 'identifiedType'
Caused by: org.mule.runtime.core.api.config.ConfigurationException: org.springframework.beans.factory.xml.XmlBeanDefinitionStoreException: Line 14 in XML document from org.mule.extension.spring.internal.context.ResourceDelegate@79ec3d46 is invalid; nested exception is org.xml.sax.SAXParseException; lineNumber: 14; columnNumber: 75; <Line 14, Column 75>: XML-24500: (Error) Can not build schema 'http://www.springframework.org/schema/jdbc' located at 'http://www.springframework.org/schema/jdbc/spring-jdbc-4.2.xsd'
Caused by: org.mule.runtime.api.lifecycle.InitialisationException: org.springframework.beans.factory.xml.XmlBeanDefinitionStoreException: Line 14 in XML document from org.mule.extension.spring.internal.context.ResourceDelegate@79ec3d46 is invalid; nested exception is org.xml.sax.SAXParseException; lineNumber: 14; columnNumber: 75; <Line 14, Column 75>: XML-24500: (Error) Can not build schema 'http://www.springframework.org/schema/jdbc' located at 'http://www.springframework.org/schema/jdbc/spring-jdbc-4.2.xsd'
Caused by: org.mule.runtime.api.exception.MuleRuntimeException: org.springframework.beans.factory.xml.XmlBeanDefinitionStoreException: Line 14 in XML document from org.mule.extension.spring.internal.context.ResourceDelegate@79ec3d46 is invalid; nested exception is org.xml.sax.SAXParseException; lineNumber: 14; columnNumber: 75; <Line 14, Column 75>: XML-24500: (Error) Can not build schema 'http://www.springframework.org/schema/jdbc' located at 'http://www.springframework.org/schema/jdbc/spring-jdbc-4.2.xsd'
Caused by: org.springframework.beans.factory.xml.XmlBeanDefinitionStoreException: Line 14 in XML document from org.mule.extension.spring.internal.context.ResourceDelegate@79ec3d46 is invalid; nested exception is org.xml.sax.SAXParseException; lineNumber: 14; columnNumber: 75; <Line 14, Column 75>: XML-24500: (Error) Can not build schema 'http://www.springframework.org/schema/jdbc' located at 'http://www.springframework.org/schema/jdbc/spring-jdbc-4.2.xsd'
	at org.springframework.beans.factory.xml.XmlBeanDefinitionReader.doLoadBeanDefinitions(XmlBeanDefinitionReader.java:402) ~[spring-beans-5.3.21.jar:5.3.21]
```

This error is caused by the XDB and XMLParserV2.

The solution is to include JVM Arguments during Run/Debug on Anypoint Studio:

```bash
-Djavax.xml.parsers.SAXParserFactory=com.sun.org.apache.xerces.internal.jaxp.SAXParserFactoryImpl
-Djavax.xml.parsers.DocumentBuilderFactory=com.sun.org.apache.xerces.internal.jaxp.DocumentBuilderFactoryImpl
```
Why? ... [Troubleshoot Oracle’s XML Extensions using System Properties](https://docs.mulesoft.com/db-connector/latest/database-connector-troubleshooting#troubleshoot-oracles-xml-extensions-using-system-properties)


## Links:

- [Using SQL XMLType in Mule 4 | MuleSoft Help Center (help.mulesoft.com)](https://help.mulesoft.com/s/article/Using-SQL-XMLType-in-Mule-4) or [Using SQL XMLType in Mule 4](./exchange-docs/using-sql-xmltype-in-mule-4.md)
- ["Invalid column type" error when calling Oracle Stored Procedure with XMLTYPE parameter | MuleSoft Help Center (help.mulesoft.com)](https://help.mulesoft.com/s/article/Invalid-column-type-error-when-calling-Oracle-Stored-Procedure-with-XMLTYPE-parameter) or [Invalid column type error when calling Oracle Stored Procedure with XMLTYPE parameter](./exchange-docs/invalid-column-type-error-when-calling-oracle-stored-procedure-with-xmltype-parameter.md)
- [XMLTYPE cast exception c3p0 pool Oracle Database | MuleSoft Help Center (help.mulesoft.com)](https://help.mulesoft.com/s/article/XMLTYPE-cast-exception-c3p0-pool-Oracle-Database) or [XMLTYPE cast exception c3p0 pool Oracle Database](./exchange-docs/xmltype-cast-exception-c3p0-pool-oracle-database.md)


