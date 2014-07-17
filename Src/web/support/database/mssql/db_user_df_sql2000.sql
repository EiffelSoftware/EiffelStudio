USE [test]
GO
/****** Object:  UserDefinedFunction [dbo].[UserSynopsis]    Script Date: 21/05/2014 8:58:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[UserSynopsis] (

@ContactID AS INT

)  

RETURNS VARCHAR (500) AS  

BEGIN 

	DECLARE @FirstName VARCHAR(240)
	DECLARE @LastName VARCHAR(240)
	DECLARE @Email VARCHAR(150)
	DECLARE @OrganizationName VARCHAR(500)
	DECLARE @UserSynopsis VARCHAR(500)

	SELECT @FirstName = FirstName, @LastName = LastName, @Email = Email, @OrganizationName = OrganizationName FROM Contacts WHERE ContactID = @ContactID

	IF (@FirstName IS NULL) OR (DataLength (@FirstName) < 2)
	BEGIN
		IF (@LastName IS NULL) OR (DataLength (@LastName) < 2)
		BEGIN
			SELECT @UserSynopsis = @Email
		END
		ELSE
		BEGIN
			SELECT @UserSynopsis = @LastName + ' (' + @Email + ')'
		END
	END
	ELSE
	BEGIN
		IF (@LastName IS NULL) OR (@LastName = '')
		BEGIN
			SELECT @UserSynopsis = @FirstName + ' (' + @Email + ')'
		END
		ELSE
		BEGIN
			SELECT @UserSynopsis = @FirstName + ' ' +  @LastName
		END
	END

	RETURN @UserSynopsis

END




GO
/****** Object:  UserDefinedFunction [dbo].[UserSynopsisFast]    Script Date: 21/05/2014 8:58:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[UserSynopsisFast] (

@FirstName VARCHAR(240),
@LastName VARCHAR(240),
@UserName VARCHAR(150)

)  

RETURNS VARCHAR (500) AS  

BEGIN 

	IF (@FirstName IS NULL) OR (DataLength (@FirstName) < 2)
	BEGIN
		IF (@LastName IS NULL) OR (DataLength (@LastName) < 2)
		BEGIN
			RETURN @UserName
		END
		ELSE
		BEGIN
			RETURN @LastName + ' (' + @Username + ')'
		END
	END
	ELSE
	BEGIN
		IF (@LastName IS NULL) OR (@LastName = '')
		BEGIN
			RETURN @FirstName + ' (' + @Username + ')'
		END
		ELSE
		BEGIN
			RETURN @FirstName + ' ' +  @LastName
		END
	END

	RETURN @UserName

END






GO
