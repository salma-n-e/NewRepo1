CREATE DATABASE HotelReservation;
GO
USE HotelReservation;
GO


CREATE TABLE Hotelsss (
    HotelID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    City VARCHAR(100),
    StarRating INT,
    ContactNumber VARCHAR(20),
    ManagedBy_StaffID INT NULL
);


CREATE TABLE Staf (
    StaffID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(100),
    Salary DECIMAL(10, 2),
    WorksAt_HotelID INT,
    FOREIGN KEY (WorksAt_HotelID) REFERENCES Hotelss(HotelID)
);


ALTER TABLE Hotels 
ADD CONSTRAINT FK_Hotel_Manager 
FOREIGN KEY (ManagedBy_StaffID) REFERENCES Staff(StaffID);

CREATE TABLE Servicess (
    ServiceID INT PRIMARY KEY IDENTITY(1,1),
    ServiceName VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Charge DECIMAL(10, 2),
    RequestDate DATETIME,
    HotelID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotelss(HotelID)
);


CREATE TABLE Roomss (
    RoomNumber INT PRIMARY KEY,
    RoomType VARCHAR(50),
    Capacity INT,
    DailyRate DECIMAL(10, 2),
    Availability BIT,
    HotelID INT,
    FOREIGN KEY (HotelID) REFERENCES Hotelss(HotelID)
);


CREATE TABLE Amenitiess (
    AmenityID INT PRIMARY KEY IDENTITY(1,1),
    Amenity VARCHAR(100) NOT NULL
);


CREATE TABLE Guestss (
    GuestID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Nationality VARCHAR(50),
    PassportNumber VARCHAR(50),
    DateOfBirth DATE
);


CREATE TABLE Guest_Contact_Detailss (
    GuestID INT,
    Contact VARCHAR(100),
    PRIMARY KEY (GuestID, Contact),
    FOREIGN KEY (GuestID) REFERENCES Guestss(GuestID)
);


CREATE TABLE Reservationss (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    BookingDate DATETIME NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    ReservationStatus VARCHAR(50),
    TotalPrice DECIMAL(10, 2),
    NumberOfAdults INT,
    NumberOfChildren INT
);


CREATE TABLE Reservations_Roomss (
    ReservationID INT,
    RoomNumber INT,
    PRIMARY KEY (ReservationID, RoomNumber),
    FOREIGN KEY (ReservationID) REFERENCES Reservationss(ReservationID),
    FOREIGN KEY (RoomNumber) REFERENCES Roomss(RoomNumber)
);


CREATE TABLE Reservations_Guests (
    ReservationID INT,
    GuestID INT,
    PRIMARY KEY (ReservationID, GuestID),
    FOREIGN KEY (ReservationID) REFERENCES Reservationss(ReservationID),
    FOREIGN KEY (GuestID) REFERENCES Guestss(GuestID)
);


CREATE TABLE Reservations_Services (
    ServiceID INT,
    ReservationID INT,
    PRIMARY KEY (ServiceID, ReservationID),
    FOREIGN KEY (ServiceID) REFERENCES Servicess(ServiceID),
    FOREIGN KEY (ReservationID) REFERENCES Reservationss(ReservationID)
);


CREATE TABLE Paymentss (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    Method VARCHAR(50),
    Date DATETIME,
    Amount DECIMAL(10, 2),
    ConfirmationNumber VARCHAR(100)
);


CREATE TABLE Reservations_Payments (
    ReservationID INT,
    PaymentID INT,
    PRIMARY KEY (ReservationID, PaymentID),
    FOREIGN KEY (ReservationID) REFERENCES Reservationss(ReservationID),
    FOREIGN KEY (PaymentID) REFERENCES Paymentss(PaymentID)
);