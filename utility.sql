USE Hotel_Realta;
GO

CREATE TYPE [HR].[ShiftList] AS TABLE(
    [ShiftName] [nvarchar](25) NOT NULL,
    [ShiftStartTime] [datetime2](7) NOT NULL,
    [ShiftEndTime] [datetime2](7) NOT NULL
)