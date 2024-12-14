CREATE OR REPLACE PROCEDURE "C##TEST".CREATE_PERSON_FROM_XML (
    P_PERSON_XML IN XMLTYPE,
    P_RESPONSE_XML OUT XMLTYPE
)
AS
    l_username     VARCHAR2(50);
    l_name         VARCHAR2(255);
    l_social_name  VARCHAR2(50);
    l_gender       VARCHAR2(50);
    l_birth_date   DATE;
BEGIN
    -- Extract values from the XML input
    SELECT
        p_person_xml.extract('//username/text()').getStringVal(),
        p_person_xml.extract('//name/text()').getStringVal(),
        p_person_xml.extract('//social_name/text()').getStringVal(),
        p_person_xml.extract('//gender/text()').getStringVal(),
        TO_DATE(p_person_xml.extract('//birth_date/text()').getStringVal(), 'YYYY-MM-DD')
    INTO
        l_username, l_name, l_social_name, l_gender, l_birth_date
    FROM
        dual;

    -- Insert into PEOPLE table
    INSERT INTO PEOPLE (
        username, name, social_name, gender, birth_date
    ) VALUES (
        l_username, l_name, l_social_name, l_gender, l_birth_date
    );

    -- Set the output XML response
    p_response_xml := XMLTYPE('<response><status>Success</status><message>Person created successfully</message></response>');

EXCEPTION
    WHEN OTHERS THEN
        -- Return an error response in case of exception
        p_response_xml := XMLTYPE('<response><status>Error</status><message>' || SQLERRM || '</message></response>');
        ROLLBACK;
END CREATE_PERSON_FROM_XML;