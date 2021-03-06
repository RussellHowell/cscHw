CREATE TABLE CLIENT
(
	ClientId varchar(10) NOT NULL,
	ClientName varchar(20) NOT NULL,
	TaxId varchar(9) NOT NULL,
	PhoneNumber varchar(10) NULL,
	PRIMARY KEY (ClientId)
);
CREATE TABLE EMPLOYEE
(
	EmployeeId varchar(10) NOT NULL,
	EmployeeSsn varchar(9) NOT NULL,
	FirstName varchar(20) NOT NULL,
	MiddleName varchar(20) NULL,
	LastName varchar(20) NOT NULL,
	Address varchar(50) NOT NULL,
	Salary decimal(13,2) NOT NULL,
	PhoneNumber varchar(10) NULL,
	Birthdate date NOT NULL,
	StartDate date NOT NULL,
	Sex varchar(1) NOT NULL,
	SupervisorId varchar(10) NULL,
	DepartmentId varchar(10) NOT NULL,
	PRIMARY KEY (EmployeeId),
	CONSTRAINT fk_supervisor_id FOREIGN KEY (SupervisorId) REFERENCES EMPLOYEE(EmployeeId)
);
CREATE TABLE DEPARTMENT
(
	DepartmentId varchar(10) NOT NULL,
	DepartmentName varchar(30) NULL,
	NumberOfEmployees int NOT NULL,
	PhoneNumber varchar(10) NOT NULL,
	ManagerId varchar(10) NOT NULL,
	PRIMARY KEY (DepartmentId),
	CONSTRAINT fk_manager_id FOREIGN KEY (ManagerId) REFERENCES EMPLOYEE(EmployeeId)
);
CREATE TABLE EMPLOYEE_DEPARTMENT
(
	EmployeeId varchar(10) NOT NULL,
	DepartmentId varchar(10) NOT NULL,
	PRIMARY KEY (EmployeeId, DepartmentId),
	CONSTRAINT fk_employee_id FOREIGN KEY (EmployeeId) REFERENCES EMPLOYEE(EmployeeId),
	CONSTRAINT fk_department_id FOREIGN KEY (DepartmentId) REFERENCES DEPARTMENT(DepartmentId)
);
CREATE TABLE ACCOUNT_TYPE
(
	AccountTypeId varchar(10) NOT NULL,
	AccountTypeName varchar(20) NOT NULL,
	PRIMARY KEY (AccountTypeId)
);
CREATE TABLE ACCOUNT
(
	AccountId varchar(10) NOT NULL,
	AccountType varchar(10) NOT NULL,
	AccountBalance decimal(13,2) NOT NULL,
	ClientId varchar(10) NOT NULL,
	SetupDate timestamp(0) NOT NULL,
	PRIMARY KEY (AccountId),
	CONSTRAINT fk_account_type FOREIGN KEY (AccountType) REFERENCES ACCOUNT_TYPE(AccountTypeId)
);
CREATE TABLE EMPLOYEE_ACCOUNT
(
	EmployeeId varchar(10) NOT NULL,
	AccountId varchar(10) NOT NULL,
	StartDate date NOT NULL,
	PRIMARY KEY (EmployeeId, AccountId),
	CONSTRAINT fk_account_employee_id FOREIGN KEY (EmployeeId) REFERENCES EMPLOYEE(EmployeeId),
	CONSTRAINT fk_account_id FOREIGN KEY (AccountId) REFERENCES ACCOUNT(AccountId)
);
CREATE TABLE PORTFOLIO
(
	PortfolioId varchar(10) NOT NULL,
	PortfolioBalance decimal(13,2) NOT NULL,
	SetupDate timestamp(0) NOT NULL,
	PRIMARY KEY (PortfolioId)
);
CREATE TABLE MUTUAL_FUND_TYPE
(
	MutualFundTypeId varchar(10) NOT NULL,
	MutualFundTypeDescription varchar(30) NULL,
	PRIMARY KEY (MutualFundTypeId)
);
CREATE TABLE MUTUAL_FUND
(
	MutualFundId varchar(10) NOT NULL,
	MutualFundType varchar(10) NOT NULL,
	Value decimal(13,2) NOT NULL,
	PRIMARY KEY (MutualFundId),
	CONSTRAINT fk_mutual_fund_type FOREIGN KEY (MutualFundType) REFERENCES MUTUAL_FUND_TYPE(MutualFundTypeId)
);
CREATE TABLE STOCK_TYPE
(
	StockTypeId varchar(10) NOT NULL,
	StockTypeDescription varchar(30) NULL,
	PRIMARY KEY (StockTypeId)
);
CREATE TABLE STOCK
(
	StockId varchar(6) NOT NULL,
	StockType varchar(10) NOT NULL,
	StockName varchar(30) NULL,
	StockExchange varchar(10) NOT NULL,
	PRIMARY KEY (StockId),
	CONSTRAINT fk_stock_type FOREIGN KEY (StockType) REFERENCES STOCK_TYPE (StockTypeId)
);
CREATE TABLE BOND_TYPE
(
	BondTypeId varchar(10) NOT NULL,
	BondTypeDescription varchar(30) NULL,
	PRIMARY KEY (BondTypeId)
);
CREATE TABLE BOND
(
	BondId varchar(12) NOT NULL,
	BondType varchar(10) NOT NULL,
	BondIssuer varchar(30) NOT NULL,
	BondName varchar(30) NOT NULL,
	FaceValue decimal(13,2) NOT NULL,
	IssueDate date NOT NULL,
	MaturityDate date NOT NULL,
	InterestRate decimal(8,4) NOT NULL,
	PRIMARY KEY (BondId),
	CONSTRAINT fk_bond_type FOREIGN KEY (BondType) REFERENCES BOND_TYPE (BondTypeId)
);
CREATE TABLE PORTFOLIO_ITEM
(
	PortfolioItemId varchar(10) NOT NULL,
	PortfolioId varchar(10) NOT NULL,
	MutualFundId varchar(10) NULL,
	StockId varchar(6) NULL,
	BondId varchar(12) NULL,
	Quantity integer NOT NULL,
	PRIMARY KEY (PortfolioItemId, PortfolioId),
	CONSTRAINT fk_portfolio_id FOREIGN KEY (PortfolioId) REFERENCES PORTFOLIO(PortfolioId),
	CONSTRAINT fk_mutual_fund_id FOREIGN KEY (MutualFundId) REFERENCES MUTUAL_FUND(MutualFundId),
	CONSTRAINT fk_stock_id FOREIGN KEY (StockId) REFERENCES STOCK(StockId),
	CONSTRAINT fk_bond_id FOREIGN KEY (BondId) REFERENCES BOND(BondId)
);
CREATE TABLE TRANSACTION_TYPE
(
	TransTypeId varchar(10) NOT NULL,
	TransTypeDescription varchar(30) NULL,
	PRIMARY KEY (TransTypeId)
);
CREATE TABLE ITEM_TRANSACTION
(
	TransactionId char(16) NOT NULL,
	TransactionTimestamp timestamp(6) NOT NULL,
	TransactionType varchar(10) NOT NULL,
	TransactionValue decimal (13,2) NOT NULL,
	ByEmployeeId varchar(10) NOT NULL,
	TransactionItemId varchar(10) NOT NULL,
	TransactionPortfolioId varchar(10) NOT NULL,
	Quantity int NOT NULL,
	PRIMARY KEY (TransactionId),
	CONSTRAINT fk_transaction_type FOREIGN KEY (TransactionType) REFERENCES TRANSACTION_TYPE(TransTypeId),
	CONSTRAINT fk_by_employee_id FOREIGN KEY (ByEmployeeId) REFERENCES EMPLOYEE(EmployeeId),
	CONSTRAINT fk_transaction_portfolio_item FOREIGN KEY (TransactionItemId, TransactionPortfolioId) REFERENCES PORTFOLIO_ITEM(PortfolioItemId, PortfolioId)
);