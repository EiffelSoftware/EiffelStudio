USE [EiffelDB]
GO

/****** Object:  StoredProcedure [dbo].[AddUser2]    Script Date: 25/02/2014 18:47:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddUser2]
	@FirstName		VARCHAR(50),
	@LastName		VARCHAR(50),
	@EMail			VARCHAR(100),
	@Username		VARCHAR(100),
	@PasswordHash	CHAR(40),
	@PasswordSalt		CHAR(24),
	@AnswerHash		CHAR(40),
	@AnswerSalt		CHAR(24),
	@RegistrationToken	CHAR(7),
	@QuestionID		INT

AS

DECLARE @Count		INT
DECLARE @ContactID		INT
DECLARE  @MembershipID	INT
DECLARE @Now datetime
DECLARE @AlreadyExists	BIT
SET @Now = getdate()


BEGIN TRANSACTION AddUserTransaction

		/* 1. Check username isn't taken already */
	SELECT	@Count = COUNT(*)
	FROM	Memberships
	WHERE	Username = @Username

		/* 1.a Check username/email is not already trying to register */
	IF @Count = 0
	BEGIN
		SELECT	@Count = COUNT(*)
		FROM	Registrations
		WHERE	Username = @Username or Email = @Email
	END

		/* 1.b Check username/email is not already registered */
	IF @Count = 0
	BEGIN
		SELECT	@ContactID= ContactID
		FROM	Contacts
		WHERE	Email = @Email
		IF @ContactID IS NOT NULL
		BEGIN
			SELECT @Count = COUNT(*)
			FROM Memberships
			WHERE ContactID=@ContactID;
		END
	END

	IF @Count = 0
	BEGIN

		/* 2. Retrieve/create ContactID */
		SELECT	@ContactID = ContactID
		FROM		Contacts
		WHERE	EMail = @EMail

		IF @ContactID IS NULL
		BEGIN
			INSERT INTO Contacts (
				FirstName,
				LastName,
				EMail,
				DateOfLastModification,
				DateOfCreation
			)
			VALUES (
				@FirstName,
				@LastName,
				@EMail,
				@Now,
				@Now
			)
			SELECT @ContactID = SCOPE_IDENTITY()
		END
		ELSE
		BEGIN
			DELETE FROM Memberships
			WHERE ContactID = @ContactID
		END

		/* 3. Store membership information */		

		INSERT INTO Memberships (
			ContactID,
			QuestionID,
			Username,
			PasswordHash,
			PasswordSalt,
			AnswerHash,
			AnswerSalt,
			CreationDate,
			IsActive
			)
		VALUES (
			@ContactID,
			@QuestionID,
			@Username,
			@PasswordHash,
			@PasswordSalt,
			@AnswerHash,
			@AnswerSalt,
			@Now,
			1
		)
		SELECT @MembershipID = SCOPE_IDENTITY()

		/* 4. Create registration table entry */
		INSERT INTO Registrations(
			RegistrationToken,
			EMail,
			Username,
			CreationDate
		)
		VALUES(
			@RegistrationToken,
			@EMail,
			@Username,
			@Now
		)

		/* 5. Initialize Role from presets */
		EXEC SetPresetRole @EMail
	END
	ELSE
		SET @AlreadyExists = 1

	SELECT @ContactID, @AlreadyExists

COMMIT TRANSACTION AddUserTransaction
GO

