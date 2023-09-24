DROP TABLE FAULTREPORT;
DROP TABLE RAGREEMENT;
DROP TABLE VEHICLE;
ALTER TABLE EMPLOYEE DROP COLUMN outNo;
DROP TABLE OUTLET;
DROP TABLE EMPLOYEE;
DROP TABLE CLIENT;

CREATE TABLE Client
(ClientNo CHAR(7),
FName VARCHAR2(15),
LName VARCHAR2(25),
Phone CHAR(10),
Email VARCHAR2(50),
Street VARCHAR2(40),
City VARCHAR2(25),
State CHAR(2),
ZipCode CHAR(5),
CONSTRAINT Client_ClientNo_PK PRIMARY KEY (ClientNo),
CONSTRAINT Client_Email_CK CHECK (Email LIKE '%@%.%'));

CREATE TABLE Outlet
(outNo CHAR(2),
Street VARCHAR2(40),
City VARCHAR2(25),
State CHAR(2),
ZipCode CHAR(5),
Phone CHAR(10),
ManagerNo CHAR(4),
CONSTRAINT Outlet_outNo_PK PRIMARY KEY (outNo));

CREATE TABLE Vehicle(
LicenseNo CHAR(10),
Make VARCHAR2(15),
Model VARCHAR2(15),
Color VARCHAR2(15),
Year NUMBER(4), /*Mark fix this later*/
NoDoors NUMBER(1),
Capacity NUMBER(2),
DailyRate NUMBER(6,2),
InspectionDate DATE DEFAULT SYSDATE,
outNo CHAR(2),
CONSTRAINT Vehicle_LicenseNo_PK PRIMARY KEY (LicenseNo),
CONSTRAINT Vehicle_outNo_FK FOREIGN KEY (outNo) REFERENCES Outlet (outNo),
CONSTRAINT Vehicle_Year_CK CHECK (Year > 1900));

CREATE TABLE Employee(
EmpNo CHAR(4),
FName VARCHAR2(15),
LName VARCHAR2(25),
Position VARCHAR2(30),
Phone CHAR(10),
Email VARCHAR2(50),
DOB DATE DEFAULT SYSDATE,
Gender CHAR(1),
Salary NUMBER(6),
HireDate DATE DEFAULT SYSDATE,
OutNo CHAR(2),
SuperNo CHAR(4),
CONSTRAINT Employee_EmpNo_PK PRIMARY KEY (EmpNo),
CONSTRAINT Employee_SuperNo_FK FOREIGN KEY (SuperNo) REFERENCES Employee (EmpNo),
CONSTRAINT Employee_outNo_FK FOREIGN KEY (outNo) REFERENCES Outlet (outNo),
CONSTRAINT Employee_Email_CK CHECK (Email LIKE '%@aandd.com'),
CONSTRAINT Employee_Gender_CK CHECK (Gender IN ('F', 'M', 'N', 'T')));

CREATE TABLE RAgreement(
RentalNo NUMBER(10),
StartDate DATE DEFAULT SYSDATE,
ReturnDate DATE DEFAULT SYSDATE,
MileageBefore NUMBER(6),
MileageAfter NUMBER(6),
InsuranceType VARCHAR2(15),
ClientNo CHAR(7),
LicenseNo CHAR(10),
CONSTRAINT RAgreement_RentalNo_PK PRIMARY KEY (RentalNo),
CONSTRAINT RAgreement_ClientNo_FK FOREIGN KEY (ClientNo) REFERENCES Client (ClientNo),
CONSTRAINT RAgreement_LisenceNo_FK FOREIGN KEY (LicenseNo) REFERENCES Vehicle (LicenseNo),
CONSTRAINT RAgreement_MileageAfter_CK CHECK (MileageAfter >= MileageBefore));

CREATE TABLE FaultReport(
ReportNum CHAR(10),
DateChecked DATE DEFAULT SYSDATE,
Comments VARCHAR2(300),
EmpNo CHAR(4),
LicenseNo CHAR(10),
RentalNo NUMBER(10),
CONSTRAINT FaultReport_ReportNum_PK PRIMARY KEY (ReportNum),
CONSTRAINT FaultReport_EmpNo_FK FOREIGN KEY (EmpNo) REFERENCES Employee (EmpNo),
CONSTRAINT FaultReport_LicenseNo_FK FOREIGN KEY (LicenseNo) REFERENCES Vehicle (LicenseNo),
CONSTRAINT FaultReport_RentalNo_FK FOREIGN KEY (RentalNo) REFERENCES RAgreement (RentalNo));

ALTER TABLE OUTLET
ADD CONSTRAINT Outlet_Manager_No_FK
FOREIGN KEY (ManagerNo) REFERENCES Employee (EmpNo);
