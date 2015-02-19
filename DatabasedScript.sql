CREATE TABLE CLIENT
(
	ClientId varchar(10) NOT NULL,
	ClientName varchar(20) NOT NULL,
	TaxId varchar(9) NOT NULL,
	PhoneNumber varchar(10) NULL,
	PRIMARY KEY (ClientId)
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
CREATE TABLE MUTUAL_FUND_TYPE
(
	MutualFundTypeId varchar(10) NOT NULL,
	MutualFundTypeDescription varchar(30) NOT NULL,
	PRIMARY KEY (MutualFundTypeId)
)
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
	StockTypeDescription varchar(30) NOT NULL,
	PRIMARY KEY (StockTypeId)
);
CREATE TABLE STOCK
(
	StockId varchar(6) NOT NULL,
	StockType varchar(10) NOT NULL,
	StockName varchar(30) NOT NULL,
	StockExchange varchar(10) NOT NULL,
	PRIMARY KEY (StockId),
	CONSTRAINT fk_stock_type FOREIGN KEY (StockType) REFERENCES STOCK_TYPE (StockTypeId)
);
CREATE TABLE BOND_TYPE
(
	BondTypeId varchar(10) NOT NULL,
	BondTypeDescription varchar(30) NOT NULL,
	PRIMARY (BondTypeId)
);;
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