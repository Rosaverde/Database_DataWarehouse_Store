import pyodbc
from random import randint, uniform # module imported only for mocking parts of data

datafile = input("Enter datafile in CSV: ")
if datafile == '' :
    print("File not provided")
    exit()
try:
    with open(datafile) as f:
        print('Loading data...')
except FileNotFoundError:
    print('File does not exists')
    exit()


fhand = open(datafile)

conn = pyodbc.connect(
    Trusted_Connection = "Yes",
    Driver = 'SQL Server',
    Server = "DESKTOP-NFCJJSR",
    Database = "salesDB"
)

cur = conn.cursor()

for line in fhand:
    c = line.split(',')
    if c[0] == "EmployeeName": continue
    
    employeeName = c[0]
    employeeSurname = c[1]
    cashRegisterNumber = c[2]
    productCategory = c[3]
    size = c[4]
    product = c[5]
    amountSold = int(c[6])
    transactionID = int(c[7])
    transactionDate = c[8]
    transactionSum = float(c[9])

    # Employee table
    cur.execute('SELECT ID_Employee FROM Employee WHERE EmployeeName = ? AND EmployeeSurname = ?', (employeeName,employeeSurname))
    emplyeeID = cur.fetchone()
    if emplyeeID is not None:
        emplyeeID = emplyeeID[0]
    else:
        cur.execute('INSERT INTO employee (employeename, employeesurname) VALUES( ? , ? )' ,(employeeName, employeeSurname))
        conn.commit()
        cur.execute('SELECT ID_Employee FROM Employee WHERE EmployeeName = ? AND EmployeeSurname = ?', (employeeName,employeeSurname))
        emplyeeID = cur.fetchone()[0]
    
    # CashRegister table
    cur.execute('SELECT ID_CashRegister FROM CashRegister WHERE CashRegisterName = ?', (cashRegisterNumber,))
    cashRegisterID = cur.fetchone()
    if cashRegisterID is not None:
        cashRegisterID = cashRegisterID[0]
    else:
        cur.execute('INSERT INTO CashRegister (cashregistername) VALUES ( ? )', (cashRegisterNumber,))
        conn.commit()
        cur.execute('SELECT ID_CashRegister FROM CashRegister WHERE CashRegisterName = ?', (cashRegisterNumber,))
        cashRegisterID = cur.fetchone()[0]

    # Category table
    cur.execute('SELECT ID_Category FROM ProductCategory WHERE Category = ?', (productCategory,))
    categoryID = cur.fetchone()
    if categoryID is not None:
        categoryID = categoryID[0]
    else:
        cur.execute('INSERT INTO ProductCategory (Category) VALUES ( ? )', (productCategory,))
        conn.commit()
        cur.execute('SELECT ID_Category FROM ProductCategory WHERE Category = ?', (productCategory,))
        categoryID = cur.fetchone()[0]

    # Size table
    cur.execute('SELECT ID_Size FROM Size WHERE Size = ?', (size,))
    sizeID = cur.fetchone()
    if sizeID is not None:
        sizeID = sizeID[0]
    else:
        cur.execute('INSERT INTO Size (size) VALUES ( ? )', (size,))
        conn.commit()
        cur.execute('SELECT ID_Size FROM Size WHERE Size = ?', (size,))
        sizeID = cur.fetchone()[0]

    # Product table
    # Ideally products should be already in database imported by some stock managment module
    cur.execute('SELECT ID_Product FROM Product WHERE Product = ? AND Size_ID = ?', (product, sizeID))
    productID = cur.fetchone()
    if productID is not None:
        productID = productID[0]
    else:
        amountInStock = randint(1,101)
        price = round(uniform(0, 500),2) # This is only for mockup purpose
        cur.execute('INSERT INTO Product(category_id, size_id, product, amountonstock, productprice) VALUES (?,?,?,?,?)', (categoryID, sizeID, product, amountInStock, price))
        conn.commit()
        cur.execute('SELECT ID_Product FROM Product WHERE Product = ? AND Size_ID = ?', (product, sizeID))
        productID = cur.fetchone()[0]
    
    # Transaction table
    cur.execute('SELECT ID_Transaction FROM Transactions WHERE ID_Transaction = ?', (transactionID,))
    if cur.fetchone() is None:
        cur.execute('INSERT INTO Transactions (ID_Transaction, Employee_ID, CashRegister_ID, TransactionDate, TransactionSum) VALUES (?,?,?,?,?)', (transactionID, emplyeeID, cashRegisterID, transactionDate, transactionSum))
    
    # Operation table
    cur.execute('SELECT Transaction_ID, Product_ID FROM Operation WHERE Transaction_ID = ? AND Product_ID = ?', (transactionID, productID))
    if cur.fetchone() is None:
        cur.execute('INSERT INTO Operation (Transaction_ID, Product_ID, AmountSold) VALUES (?, ?, ?)', (transactionID, productID, amountSold))

    conn.commit()
    
print("Finished")