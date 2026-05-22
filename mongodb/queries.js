
//  SECTION 1 — DROP EXISTING COLLECTIONS (clean slate)

use("gebar_commercial_bank");

db.branches.drop();
db.customers.drop();
db.accounts.drop();
db.loans.drop();
db.transactions.drop();
db.employees.drop();
db.loan_payments.drop();
db.users.drop();
db.audit_log.drop();

print("✔  Old collections dropped.");


//  SECTION 2 — CREATE COLLECTIONS WITH SCHEMA VALIDATION

// ── 2.1  Branches ────
db.createCollection("branches", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["branch_id", "branch_name", "address", "phone_number"],
      properties: {
        branch_id:    { bsonType: "string", description: "Unique branch identifier (PK)" },
        branch_name:  { bsonType: "string", description: "Name of the branch" },
        address:      { bsonType: "string", description: "City / physical address" },
        phone_number: { bsonType: "string", description: "Branch contact number" },
        manager_id:   { bsonType: ["string", "null"], description: "FK → employees.employee_id" },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.2  Customers
db.createCollection("customers", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "customer_id", "first_name", "last_name",
        "date_of_birth", "gender", "address", "phone_number", "national_id", "branch_id", "registration_date"
      ],
      properties: {
        customer_id:       { bsonType: "string" },
        first_name:        { bsonType: "string" },
        last_name:         { bsonType: "string" },
        date_of_birth:     { bsonType: "date" },
        gender:            { enum: ["Male", "Female", "Other"] },
        address:           { bsonType: "string" },
        phone_number:      { bsonType: "string" },
        email:             { bsonType: ["string", "null"] },
        national_id:       { bsonType: "string" },
        branch_id:         { bsonType: "string", description: "FK → branches.branch_id" },
        registration_date: { bsonType: "date" },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.3  Accounts
db.createCollection("accounts", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["account_no", "customer_id", "account_type", "balance", "open_date", "status", "branch_id"],
      properties: {
        account_no:   { bsonType: "string" },
        customer_id:  { bsonType: "string", description: "FK → customers.customer_id" },
        account_type: { enum: ["Savings", "Current", "Fixed Deposit"] },
        balance:      { bsonType: "double", minimum: 0 },
        open_date:    { bsonType: "date" },
        status:       { enum: ["Active", "Dormant", "Inactive", "Closed", "Frozen"] },
        branch_id:    { bsonType: "string", description: "FK → branches.branch_id" },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.4  Loans
db.createCollection("loans", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: [
        "loan_id", "customer_id", "branch_id", "loan_type",
        "loan_amount", "interest_rate", "duration_months", "application_date", "status"
      ],
      properties: {
        loan_id:              { bsonType: "string" },
        customer_id:          { bsonType: "string", description: "FK → customers.customer_id" },
        branch_id:            { bsonType: "string", description: "FK → branches.branch_id" },
        loan_type:            { enum: ["Home Loan", "Business Loan", "Education Loan", "Car Loan", "Personal Loan"] },
        loan_amount:          { bsonType: "double", minimum: 0 },
        interest_rate:        { bsonType: "double", minimum: 0, maximum: 100 },
        duration_months:      { bsonType: "int",    minimum: 1 },
        application_date:     { bsonType: "date" },
        approval_date:        { bsonType: ["date", "null"] },
        disbursement_date:    { bsonType: ["date", "null"] },
        monthly_installment:  { bsonType: ["double", "null"] },
        total_payable:        { bsonType: ["double", "null"] },
        outstanding_balance:  { bsonType: ["double", "null"] },
        next_due_date:        { bsonType: ["date", "null"] },
        status:               { enum: ["Pending", "Approved", "Active", "Closed", "Rejected", "Defaulted"] },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.5  Transactions
db.createCollection("transactions", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["transaction_id", "account_no", "transaction_type", "amount", "transaction_date", "branch_id"],
      properties: {
        transaction_id:   { bsonType: "string" },
        account_no:       { bsonType: "string", description: "FK → accounts.account_no" },
        transaction_type: { enum: ["Deposit", "Withdrawal", "Transfer", "Loan Disbursement", "Loan Repayment"] },
        amount:           { bsonType: "double", minimum: 0.01 },
        transaction_date: { bsonType: "date" },
        description:      { bsonType: ["string", "null"] },
        reference_number: { bsonType: ["string", "null"] },
        branch_id:        { bsonType: "string", description: "FK → branches.branch_id" },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.6  Employees
db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["employee_id", "first_name", "last_name", "position", "salary", "branch_id", "email", "phone_number"],
      properties: {
        employee_id:  { bsonType: "string" },
        first_name:   { bsonType: "string" },
        last_name:    { bsonType: "string" },
        position:     { bsonType: "string" },
        salary:       { bsonType: "double", minimum: 0 },
        hire_date:    { bsonType: ["date", "null"] },
        branch_id:    { bsonType: "string", description: "FK → branches.branch_id" },
        email:        { bsonType: "string" },
        phone_number: { bsonType: "string" },
      },
    },
  },
  validationAction: "warn",
});


// ── 2.7  Loan Payments
db.createCollection("loan_payments", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["payment_id", "loan_id", "payment_date", "amount_paid", "recorded_by"],
      properties: {
        payment_id:        { bsonType: "string" },
        loan_id:           { bsonType: "string", description: "FK → loans.loan_id" },
        payment_date:      { bsonType: "date" },
        amount_paid:       { bsonType: "double", minimum: 0.01 },
        principal_paid:    { bsonType: ["double", "null"] },
        interest_paid:     { bsonType: ["double", "null"] },
        remaining_balance: { bsonType: ["double", "null"] },
        recorded_by:       { bsonType: "string", description: "FK → employees.employee_id" },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.8  Users
db.createCollection("users", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["user_id", "username", "password_hash", "role", "status"],
      properties: {
        user_id:       { bsonType: "string" },
        username:      { bsonType: "string" },
        password_hash: { bsonType: "string" },
        employee_id:   { bsonType: ["string", "null"], description: "FK → employees.employee_id" },
        customer_id:   { bsonType: ["string", "null"], description: "FK → customers.customer_id" },
        role:          { enum: ["manager", "teller", "customer"] },
        status:        { enum: ["active", "inactive", "suspended"] },
        last_login:    { bsonType: ["date", "null"] },
      },
    },
  },
  validationAction: "warn",
});

// ── 2.9  Audit Log
db.createCollection("audit_log", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["log_id", "table_name", "record_id", "action", "changed_by", "changed_at"],
      properties: {
        log_id:      { bsonType: "string" },
        table_name:  { bsonType: "string" },
        record_id:   { bsonType: "string" },
        action:      { enum: ["INSERT", "UPDATE", "DELETE"] },
        changed_by:  { bsonType: "string", description: "FK → employees.employee_id" },
        changed_at:  { bsonType: "date" },
        description: { bsonType: ["string", "null"] },
      },
    },
  },
  validationAction: "warn",
});

print("✔  Collections created with schema validation.");

//  SECTION 3 — INDEXES

db.branches.createIndex({ branch_id: 1 }, { unique: true, name: "idx_branch_id" });
db.customers.createIndex({ customer_id: 1 }, { unique: true, name: "idx_customer_id" });
db.customers.createIndex({ national_id: 1 }, { unique: true, name: "idx_national_id" });
db.customers.createIndex({ branch_id: 1 }, { name: "idx_customer_branch" });
db.customers.createIndex({ last_name: 1, first_name: 1 }, { name: "idx_customer_name" });
db.accounts.createIndex({ account_no: 1 }, { unique: true, name: "idx_account_no" });
db.accounts.createIndex({ customer_id: 1 }, { name: "idx_account_customer" });
db.accounts.createIndex({ branch_id: 1 }, { name: "idx_account_branch" });
db.accounts.createIndex({ status: 1 }, { name: "idx_account_status" });
db.loans.createIndex({ loan_id: 1 }, { unique: true, name: "idx_loan_id" });
db.loans.createIndex({ customer_id: 1 }, { name: "idx_loan_customer" });
db.loans.createIndex({ branch_id: 1 }, { name: "idx_loan_branch" });
db.loans.createIndex({ status: 1 }, { name: "idx_loan_status" });
db.transactions.createIndex({ transaction_id: 1 }, { unique: true, name: "idx_txn_id" });
db.transactions.createIndex({ account_no: 1 }, { name: "idx_txn_account" });
db.transactions.createIndex({ transaction_date: -1 }, { name: "idx_txn_date" });
db.transactions.createIndex({ transaction_type: 1 }, { name: "idx_txn_type" });
db.transactions.createIndex({ account_no: 1, transaction_date: -1 }, { name: "idx_txn_account_date" });
db.employees.createIndex({ employee_id: 1 }, { unique: true, name: "idx_employee_id" });
db.employees.createIndex({ branch_id: 1 }, { name: "idx_employee_branch" });
db.loan_payments.createIndex({ payment_id: 1 }, { unique: true, name: "idx_payment_id" });
db.loan_payments.createIndex({ loan_id: 1 }, { name: "idx_payment_loan" });
db.loan_payments.createIndex({ payment_date: -1 }, { name: "idx_payment_date" });
db.loan_payments.createIndex({ recorded_by: 1 }, { name: "idx_payment_recorded_by" });
db.users.createIndex({ user_id: 1 }, { unique: true, name: "idx_user_id" });
db.users.createIndex({ username: 1 }, { unique: true, name: "idx_username" });
db.users.createIndex({ employee_id: 1 }, { sparse: true, name: "idx_user_employee" });
db.users.createIndex({ customer_id: 1 }, { sparse: true, name: "idx_user_customer" });
db.audit_log.createIndex({ log_id: 1 }, { unique: true, name: "idx_log_id" });
db.audit_log.createIndex({ table_name: 1, record_id: 1 }, { name: "idx_log_table_record" });
db.audit_log.createIndex({ changed_by: 1 }, { name: "idx_log_changed_by" });
db.audit_log.createIndex({ changed_at: -1 }, { name: "idx_log_changed_at" });

print("✔  Indexes created.");

//  SECTION 4 — LOAD & INSERT SEED DATA FROM collections.json

function parseDates(doc, dateFields) {
  const out = Object.assign({}, doc);
  for (const field of dateFields) {
    if (out[field]) out[field] = new Date(out[field]);
  }
  return out;
}

const seed = JSON.parse(fs.readFileSync("mongodb/collections.json", "utf8"));

db.branches.insertMany(seed.branches);
db.employees.insertMany(seed.employees);
db.customers.insertMany(seed.customers.map(c => parseDates(c, ["date_of_birth", "registration_date"])));
db.accounts.insertMany(seed.accounts.map(a => parseDates(a, ["open_date"])));
db.loans.insertMany(seed.loans.map(l => parseDates(l, ["application_date", "approval_date", "disbursement_date", "next_due_date"])));
db.transactions.insertMany(seed.transactions.map(t => parseDates(t, ["transaction_date"])));
db.loan_payments.insertMany(seed.loan_payments.map(p => parseDates(p, ["payment_date"])));
db.users.insertMany(seed.users.map(u => parseDates(u, ["last_login"])));
db.audit_log.insertMany(seed.audit_log.map(a => parseDates(a, ["changed_at"])));

print("✔  Seed data inserted from collections.json.");

//  SECTION 5 — CRUD OPERATIONS

print("\n═══════════════════════════════════════════════════════");
print("  SECTION 5 — CRUD OPERATIONS EXAMPLES");
print("═══════════════════════════════════════════════════════");

// 5.1 CREATE: Register a new customer
print("\n─ 5.1 INSERT new customer ─");
db.customers.insertOne({
  customer_id:       "C012",
  first_name:        "Liya",
  last_name:         "Abebe",
  date_of_birth:     new Date("2001-03-08"),
  gender:            "Female",
  address:           "Gulele Sub-city, Addis Ababa",
  phone_number:      "0912000012",
  email:             "liya.abebe@example.com",
  national_id:       "3340987654321098",
  branch_id:         "B003",
  registration_date: new Date(),
});
print("  New customer C012 inserted.");

// 5.2 READ: Find a customer by ID
print("\n─ 5.2 FIND customer by customer_id ─");
printjson(db.customers.findOne(
  { customer_id: "C001" },
  { _id: 0, first_name: 1, last_name: 1, phone_number: 1, branch_id: 1 }
));

// 5.3 UPDATE: Update customer phone number
print("\n─ 5.3 UPDATE customer phone ─");
db.customers.updateOne(
  { customer_id: "C001" },
  { $set: { phone_number: "0912999001", address: "Bole Atlas, Addis Ababa" } }
);
print("  C001 phone & address updated.");

// 5.4 DELETE: Remove a closed account
print("\n─ 5.4 DELETE closed account ─");
const delResult = db.accounts.deleteOne({ account_no: "A1009", status: "Closed" });
print(`  Deleted ${delResult.deletedCount} closed account(s).`);

// 5.5 DEPOSIT: Update balance and insert transaction
print("\n─ 5.5 DEPOSIT — update balance + insert transaction ─");
const depositAmount  = 10000.00;
const depositAccount = "A1001";
const acc = db.accounts.findOne({ account_no: depositAccount });
if (acc) {
  const newBalance = acc.balance + depositAmount;
  db.accounts.updateOne(
    { account_no: depositAccount },
    { $set: { balance: newBalance } }
  );
  db.transactions.insertOne({
    transaction_id:   "T005",
    account_no:       depositAccount,
    transaction_type: "Deposit",
    amount:           depositAmount,
    transaction_date: new Date(),
    description:      "Walk-in cash deposit",
    reference_number: "CASH-2026-100",
    branch_id:        "B001"
  });
  print(`  Deposited ${depositAmount} ETB. New balance: ${newBalance} ETB.`);
}

// 5.6 WITHDRAWAL: Debit with balance check
print("\n─ 5.6 WITHDRAWAL — debit with balance guard ─");
const withdrawAmount  = 5000.00;
const withdrawAccount = "A1001";
const wAcc = db.accounts.findOne({ account_no: withdrawAccount });
if (wAcc && wAcc.balance >= withdrawAmount) {
  const wNewBalance = wAcc.balance - withdrawAmount;
  db.accounts.updateOne(
    { account_no: withdrawAccount },
    { $set: { balance: wNewBalance } }
  );
  db.transactions.insertOne({
    transaction_id:   "T006",
    account_no:       withdrawAccount,
    transaction_type: "Withdrawal",
    amount:           withdrawAmount,
    transaction_date: new Date(),
    description:      "Counter withdrawal",
    reference_number: "WDR-2026-050",
    branch_id:        "B001"
  });
  print(`  Withdrawn ${withdrawAmount} ETB. New balance: ${wNewBalance} ETB.`);
} else {
  print("  ✗ Insufficient funds or account not found.");
}

// 5.7 TRANSFER: Between two accounts
print("\n─ 5.7 TRANSFER between accounts ─");
const fromAcc  = "A1008";
const toAcc    = "A1002";
const tfAmount = 15000.00;
const srcAcc   = db.accounts.findOne({ account_no: fromAcc });
const dstAcc   = db.accounts.findOne({ account_no: toAcc });
if (srcAcc && dstAcc && srcAcc.balance >= tfAmount) {
  db.accounts.updateOne({ account_no: fromAcc }, { $inc: { balance: -tfAmount } });
  db.accounts.updateOne({ account_no: toAcc   }, { $inc: { balance:  tfAmount } });
  const refNo = "TRF-2026-888";
  db.transactions.insertMany([
    {
      transaction_id:   "T007",
      account_no:       fromAcc,
      transaction_type: "Transfer",
      amount:           tfAmount,
      transaction_date: new Date(),
      description:      `Outgoing transfer → ${toAcc}`,
      reference_number: refNo,
      branch_id:        "B001"
    },
    {
      transaction_id:   "T008",
      account_no:       toAcc,
      transaction_type: "Transfer",
      amount:           tfAmount,
      transaction_date: new Date(),
      description:      `Incoming transfer ← ${fromAcc}`,
      reference_number: refNo,
      branch_id:        "B002"
    }
  ]);
  print(`  Transferred ${tfAmount} ETB from ${fromAcc} to ${toAcc}. Ref: ${refNo}`);
}

// 5.8 LOAN APPLICATION
print("\n─ 5.8 LOAN APPLICATION ─");
db.loans.insertOne({
  loan_id:             "L006",
  customer_id:         "C012",
  branch_id:           "B003",
  loan_type:           "Personal Loan",
  loan_amount:         40000.00,
  interest_rate:       14.0,
  duration_months:     24,
  application_date:    new Date(),
  approval_date:       null,
  disbursement_date:   null,
  monthly_installment: null,
  total_payable:       null,
  outstanding_balance: null,
  next_due_date:       null,
  status:              "Pending",
});
print("  Loan L006 for C012 submitted.");

// 5.9 LOAN STATUS UPDATE
print("\n─ 5.9 APPROVE loan ─");
db.loans.updateOne(
  { loan_id: "L006" },
  { $set: { status: "Approved" } }
);
print("  Loan L006 status changed to Approved.");


//  SECTION 6 — AGGREGATION PIPELINES

print("  SECTION 6 — AGGREGATION PIPELINES");

// 6.1 Account statement — last 10 transactions (calculate running balance on the fly)
print("\n─ 6.1 Account Statement for A1001 (latest 10 with running balance) ─");
const txns = db.transactions.find(
  { account_no: "A1001" },
  { _id: 0, transaction_id: 1, transaction_type: 1, amount: 1, transaction_date: 1, description: 1 }
).sort({ transaction_date: -1 }).limit(10).toArray();

txns.reverse();
let running = db.accounts.findOne({ account_no: "A1001" }).balance;
for (let i = txns.length-1; i >= 0; i--) {
  if (txns[i].transaction_type === "Deposit" || txns[i].transaction_type === "Loan Disbursement") {
    running -= txns[i].amount;
  } else {
    running += txns[i].amount;
  }
  txns[i].calculated_balance = running;
}
txns.reverse();
printjson(txns);

// 6.2 Total deposits & withdrawals per account
print("\n─ 6.2 Summary of deposits & withdrawals per account ─");
printjson(
  db.transactions.aggregate([
    { $match: { transaction_type: { $in: ["Deposit", "Withdrawal"] } } },
    {
      $group: {
        _id:   { account_no: "$account_no", type: "$transaction_type" },
        total: { $sum: "$amount" },
        count: { $sum: 1 },
      },
    },
    { $sort: { "_id.account_no": 1, "_id.type": 1 } },
    {
      $project: {
        _id: 0,
        account_no:       "$_id.account_no",
        transaction_type: "$_id.type",
        total_amount:     "$total",
        num_transactions: "$count",
      },
    },
  ]).toArray()
);

// 6.3 Branch-wise total balance
print("\n─ 6.3 Total balance held per branch ─");
printjson(
  db.accounts.aggregate([
    { $match: { status: "Active" } },
    {
      $group: {
        _id:           "$branch_id",
        total_balance: { $sum: "$balance" },
        num_accounts:  { $sum: 1 },
      },
    },
    { $sort: { total_balance: -1 } },
    {
      $project: {
        _id: 0,
        branch_id:     "$_id",
        total_balance: 1,
        num_accounts:  1,
      },
    },
  ]).toArray()
);

// 6.4 Loan portfolio summary by status
print("\n─ 6.4 Loan portfolio by status ─");
printjson(
  db.loans.aggregate([
    {
      $group: {
        _id:          "$status",
        total_amount: { $sum: "$loan_amount" },
        num_loans:    { $sum: 1 },
        avg_rate:     { $avg: "$interest_rate" },
      },
    },
    { $sort: { total_amount: -1 } },
    {
      $project: {
        _id: 0,
        status:       "$_id",
        total_amount: 1,
        num_loans:    1,
        avg_interest: { $round: ["$avg_rate", 2] },
      },
    },
  ]).toArray()
);

// 6.5 Customers with multiple accounts
print("\n─ 6.5 Customers with more than one account ─");
printjson(
  db.accounts.aggregate([
    { $match: { status: { $ne: "Closed" } } },
    {
      $group: {
        _id:          "$customer_id",
        num_accounts: { $sum: 1 },
        account_list: { $push: "$account_no" },
        total_bal:    { $sum: "$balance" },
      },
    },
    { $match: { num_accounts: { $gt: 1 } } },
    {
      $lookup: {
        from:         "customers",
        localField:   "_id",
        foreignField: "customer_id",
        as:           "customer_info",
      },
    },
    {
      $project: {
        _id: 0,
        customer_id: "$_id",
        full_name: {
          $concat: [
            { $arrayElemAt: ["$customer_info.first_name", 0] }, " ",
            { $arrayElemAt: ["$customer_info.last_name",  0] },
          ],
        },
        num_accounts:  1,
        account_list:  1,
        total_balance: "$total_bal",
      },
    },
  ]).toArray()
);

// 6.6 Monthly transaction volume
print("\n─ 6.6 Monthly transaction volume (current year) ─");
printjson(
  db.transactions.aggregate([
    { $match: { transaction_date: { $gte: new Date("2026-01-01") } } },
    {
      $group: {
        _id: {
          year:  { $year:  "$transaction_date" },
          month: { $month: "$transaction_date" },
        },
        total_volume: { $sum: "$amount" },
        num_txns:     { $sum: 1 },
      },
    },
    { $sort: { "_id.year": 1, "_id.month": 1 } },
    {
      $project: {
        _id: 0,
        year:         "$_id.year",
        month:        "$_id.month",
        total_volume: 1,
        num_txns:     1,
      },
    },
  ]).toArray()
);

// 6.7 Branch employee count & average salary
print("\n─ 6.7 Branch employee count & average salary ─");
printjson(
  db.employees.aggregate([
    {
      $group: {
        _id:           "$branch_id",
        num_employees: { $sum: 1 },
        avg_salary:    { $avg: "$salary" },
        total_payroll: { $sum: "$salary" },
      },
    },
    {
      $lookup: {
        from:         "branches",
        localField:   "_id",
        foreignField: "branch_id",
        as:           "branch_info",
      },
    },
    {
      $project: {
        _id: 0,
        branch_id:     "$_id",
        branch_name:   { $arrayElemAt: ["$branch_info.branch_name", 0] },
        num_employees: 1,
        avg_salary:    { $round: ["$avg_salary", 2] },
        total_payroll: 1,
      },
    },
    { $sort: { total_payroll: -1 } },
  ]).toArray()
);

// 6.8 Top 5 depositors (by account balance)
print("\n─ 6.8 Top 5 customers by account balance ─");
printjson(
  db.accounts.aggregate([
    { $match: { status: "Active" } },
    {
      $group: {
        _id: "$customer_id",
        total_balance: { $sum: "$balance" },
      },
    },
    { $sort: { total_balance: -1 } },
    { $limit: 5 },
    {
      $lookup: {
        from: "customers",
        localField: "_id",
        foreignField: "customer_id",
        as: "customer",
      },
    },
    {
      $project: {
        _id: 0,
        customer_id: "$_id",
        full_name: {
          $concat: [
            { $arrayElemAt: ["$customer.first_name", 0] }, " ",
            { $arrayElemAt: ["$customer.last_name", 0] }
          ]
        },
        total_balance: 1,
      },
    }
  ]).toArray()
);

// 6.9 Pending loan applications with customer details
print("\n─ 6.9 All pending loan applications with customer details ─");
printjson(
  db.loans.aggregate([
    { $match: { status: "Pending" } },
    {
      $lookup: {
        from:         "customers",
        localField:   "customer_id",
        foreignField: "customer_id",
        as:           "customer",
      },
    },
    {
      $project: {
        _id: 0,
        loan_id:          1,
        loan_type:        1,
        loan_amount:      1,
        branch_id:        1,
        application_date: 1,
        full_name: {
          $concat: [
            { $arrayElemAt: ["$customer.first_name", 0] }, " ",
            { $arrayElemAt: ["$customer.last_name",  0] },
          ],
        },
        phone: { $arrayElemAt: ["$customer.phone_number", 0] },
      },
    },
  ]).toArray()
);

// 6.10 Average transaction amount by type
print("\n─ 6.10 Average transaction amount by type ─");
printjson(
  db.transactions.aggregate([
    {
      $group: {
        _id:        "$transaction_type",
        avg_amount: { $avg: "$amount" },
        max_amount: { $max: "$amount" },
        min_amount: { $min: "$amount" },
        count:      { $sum: 1 },
      },
    },
    { $sort: { avg_amount: -1 } },
    {
      $project: {
        _id: 0,
        transaction_type: "$_id",
        avg_amount:       { $round: ["$avg_amount", 2] },
        max_amount:       1,
        min_amount:       1,
        count:            1,
      },
    },
  ]).toArray()
);



//  SECTION 7 — Number of records in each collection

print("  SECTION 7 — VERIFICATION SUMMARY");
print(`  Branches:      ${db.branches.countDocuments()}`);
print(`  Customers:     ${db.customers.countDocuments()}`);
print(`  Accounts:      ${db.accounts.countDocuments()}`);
print(`  Loans:         ${db.loans.countDocuments()}`);
print(`  Transactions:  ${db.transactions.countDocuments()}`);
print(`  Employees:     ${db.employees.countDocuments()}`);
print(`  Loan Payments: ${db.loan_payments.countDocuments()}`);
print(`  Users:         ${db.users.countDocuments()}`);
print(`  Audit Log:     ${db.audit_log.countDocuments()}`);
print("\n✅  Gebar Commercial Bank MongoDB setup complete!");
