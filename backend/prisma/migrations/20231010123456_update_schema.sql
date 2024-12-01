-- Create tables
CREATE TABLE "Company" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL
);

CREATE TABLE "Employee" (
    "id" SERIAL PRIMARY KEY,
    "companyId" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) UNIQUE NOT NULL,
    "role" VARCHAR(50) NOT NULL,
    "isActive" BOOLEAN NOT NULL,
    FOREIGN KEY ("companyId") REFERENCES "Company"("id")
);

CREATE TABLE "Position" (
    "id" SERIAL PRIMARY KEY,
    "companyId" INTEGER NOT NULL,
    "interviewFlowId" INTEGER NOT NULL,
    "title" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "status" VARCHAR(50) NOT NULL,
    "isVisible" BOOLEAN NOT NULL,
    "location" VARCHAR(100) NOT NULL,
    "jobDescription" TEXT,
    "requirements" TEXT,
    "responsibilities" TEXT,
    "salaryMin" FLOAT NOT NULL,
    "salaryMax" FLOAT NOT NULL,
    "employmentType" VARCHAR(50) NOT NULL,
    "benefits" TEXT,
    "companyDescription" TEXT,
    "applicationDeadline" TIMESTAMP NOT NULL,
    "contactInfo" VARCHAR(100) NOT NULL,
    FOREIGN KEY ("companyId") REFERENCES "Company"("id"),
    FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id")
);

CREATE TABLE "InterviewFlow" (
    "id" SERIAL PRIMARY KEY,
    "description" VARCHAR(255) NOT NULL
);

CREATE TABLE "InterviewStep" (
    "id" SERIAL PRIMARY KEY,
    "interviewFlowId" INTEGER NOT NULL,
    "interviewTypeId" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "orderIndex" INTEGER NOT NULL,
    FOREIGN KEY ("interviewFlowId") REFERENCES "InterviewFlow"("id"),
    FOREIGN KEY ("interviewTypeId") REFERENCES "InterviewType"("id")
);

CREATE TABLE "InterviewType" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT
);

CREATE TABLE "Candidate" (
    "id" SERIAL PRIMARY KEY,
    "firstName" VARCHAR(100) NOT NULL,
    "lastName" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) UNIQUE NOT NULL,
    "phone" VARCHAR(15),
    "address" VARCHAR(100)
);

CREATE TABLE "Application" (
    "id" SERIAL PRIMARY KEY,
    "positionId" INTEGER NOT NULL,
    "candidateId" INTEGER NOT NULL,
    "applicationDate" TIMESTAMP NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "notes" TEXT,
    FOREIGN KEY ("positionId") REFERENCES "Position"("id"),
    FOREIGN KEY ("candidateId") REFERENCES "Candidate"("id")
);

CREATE TABLE "Interview" (
    "id" SERIAL PRIMARY KEY,
    "applicationId" INTEGER NOT NULL,
    "interviewStepId" INTEGER NOT NULL,
    "employeeId" INTEGER NOT NULL,
    "interviewDate" TIMESTAMP NOT NULL,
    "result" VARCHAR(50),
    "score" INTEGER,
    "notes" TEXT,
    FOREIGN KEY ("applicationId") REFERENCES "Application"("id"),
    FOREIGN KEY ("interviewStepId") REFERENCES "InterviewStep"("id"),
    FOREIGN KEY ("employeeId") REFERENCES "Employee"("id")
);

-- Add any additional constraints or indexes as needed 

CREATE INDEX idx_employee_companyId ON Employee(companyId);
CREATE INDEX idx_employee_email ON Employee(email);

CREATE INDEX idx_position_companyId ON Position(companyId);
CREATE INDEX idx_position_interviewFlowId ON Position(interviewFlowId);

CREATE INDEX idx_application_positionId ON Application(positionId);
CREATE INDEX idx_application_candidateId ON Application(candidateId);

CREATE INDEX idx_interview_applicationId ON Interview(applicationId);
CREATE INDEX idx_interview_interviewStepId ON Interview(interviewStepId);
CREATE INDEX idx_interview_employeeId ON Interview(employeeId);