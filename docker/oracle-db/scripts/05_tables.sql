CREATE TABLE C##TEST.PEOPLE (
    person_id NUMBER DEFAULT C##TEST.PEOPLE_SEQ.NEXTVAL PRIMARY KEY,
    username VARCHAR2(50) NOT NULL,
    name VARCHAR2(255),
    social_name VARCHAR2(50),
    gender VARCHAR2(50),
    birth_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE C##TEST.EMAILS (
    email_id NUMBER DEFAULT C##TEST.EMAILS_SEQ.NEXTVAL PRIMARY KEY,
    person_id NUMBER,
    status NUMBER(1),
    email VARCHAR2(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_table_emails_table_person
        FOREIGN KEY (person_id)
        REFERENCES C##TEST.PEOPLE(person_id)
);

CREATE TABLE C##TEST.ADRESSES (
    adress_id NUMBER DEFAULT C##TEST.ADRESSES_SEQ.NEXTVAL PRIMARY KEY,
    person_id NUMBER,
    status NUMBER(1),
    zipcode VARCHAR2(9) NOT NULL,
    state VARCHAR2(255),
    city VARCHAR2(255),
    adress VARCHAR2(255),
    adress_number NUMBER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_table_adresses_table_person
        FOREIGN KEY (person_id)
        REFERENCES C##TEST.PEOPLE(person_id)
);

CREATE TABLE C##TEST.PHONES (
    phone_id NUMBER DEFAULT C##TEST.PHONES_SEQ.NEXTVAL PRIMARY KEY,
    person_id NUMBER,
    status NUMBER(1),
    ddd VARCHAR2(3) NOT NULL,
    phone_number VARCHAR2(9) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_table_phones_table_person
        FOREIGN KEY (person_id)
        REFERENCES C##TEST.PEOPLE(person_id)
);