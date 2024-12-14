### How to use XMLType in Mule 4

Link: [Using SQL XMLType in Mule 4 | MuleSoft Help Center (help.mulesoft.com)](https://help.mulesoft.com/s/article/Using-SQL-XMLType-in-Mule-4)

Nov 23, 2018 Knowledge

#### Content
##### GOAL
The purpose of this guide is how to use XMLType in Mule 4 for MS SQL and Oracle databases.
##### PROCEDURE
The Database connector can coerce a String into XMLType by it self. The example below is a DW 2 script that maps a JSON array into a text/plain output.

Script:

```dataweave
%dw 2.0
output text/plain
---
"<?xml version=\"1.0\"' encoding=\"UTF-8\"?> "
++ write({
XMLDATA: {
(payload map ( payload01 , indexOfPayload01 ) -> {
Person: {
Name: payload01.Name,
Value: payload01.Value as Number,
Type: payload01.Type as Number
}
})
}
} , "application/xml",{writeDeclaration: false})
```

Input:

```json
[
{
"Name": "John Doe",
"Value": "11",
"Type": "1"
},
{
"Name": "Susan Doe",
"Value": "1234567",
"Type": "2"
}
]
```

Output:

```xml
<?xml version="1.0"' encoding="UTF-8"?>
<XMLDATA>
  <Person>
    <Name>John Doe</Name>
    <Value>11</Value>
    <Type>1</Type>
  </Person>
  <Person>
    <Name>Susan Doe</Name>
    <Value>1234567</Value>
    <Type>2</Type>
  </Person>
</XMLDATA>
```

Insert Example:

```xml
<db:insert doc:name="Insert" config-ref="Database_Config_XE">
			<db:sql>INSERT INTO hr.warehouses (warehouse_id,warehouse_spec,warehouse_name) VALUES (17, :warehouse_spec,'BarnesNobles')</db:sql>
			<db:input-parameters><![CDATA[#[{'warehouse_spec' : payload}]]]></db:input-parameters>
</db:insert>
```

Stored Procedure Example:

```xml
<db:stored-procedure doc:name="Store" config-ref="Database_Config">
	<db:sql >{CALL SP_MySP(:xml)}</db:sql>
	<db:input-parameters ><![CDATA[#[{xml: payload}]]]></db:input-parameters>
</db:stored-procedure>
```