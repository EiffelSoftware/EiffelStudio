/***************************************************\
 *              - Input Checker -                  *
 *                                                 *
 * Checks data to be sent to registration service. *
\***************************************************/

using System;

namespace RegistrationClient
{

	public class InputChecker
	{
		public InputChecker()
		{
			Status = DefaultStatus;
		}

		public void CheckRegistrant( String Title,
					String FirstName,
					String LastName,
					String CompanyName,
					String Address,
					String City,
					String State,
					String ZipCode,
					String Country )
		{
			Success = true;
			CheckString( Title, "Title", true );
			CheckString( FirstName, "First Name", true );
			CheckString( LastName, "Last Name", true );
			CheckString( CompanyName, "Company Name", false );
			CheckString( Address, "Address", true );
			CheckString( City, "City", true );
			CheckString( State, "State", true );
			if( Success )
			{
				Success =( State.Length == 2 );
				if( !Success )
					Status = "Invalid State Code";
			}
			CheckString( ZipCode, "Zip Code", true );
			if( Success )
			{
				Success = IsInteger( ZipCode );
				if( !Success )
					Status = "Invalid Zip Code";
			}
			CheckString( Country, "Country", true );
		}

		public void CheckRegistration( Int32 RegistrantID,
					  String Quantity,
					  String DiscountPlan )
		{
			Success =( RegistrantID > 0 );
			if( !Success )
				Status = "Registrant ID invalid.";
			CheckString( Quantity, "Number of participants", true );
			if( Success )
			{
				Success =( IsInteger( Quantity )&&( Quantity.ToInt32() > 0));
				if( !Success )
					Status = "Number of participants must be an integer and greater than 0";
			}
			CheckString( DiscountPlan, "Discount Plan", true );
			if( Success )
			{
				Success =( DiscountPlan.Equals( "Regular" )||
				       DiscountPlan.Equals( "Non-academic Authors" )||
				       DiscountPlan.Equals( "Full-Time Students" )||
				       DiscountPlan.Equals( "Full-Time Faculty Members" ));
				if( !Success )
					Status = "Unknown discount plan";
			}
		}


		// Status message, describe error if any.
		public String Status;

		// Was last checked data valid?
		public Boolean Success;

		// Check validity of string 'CheckedString'.
		// Create status message from 'Name'.
		private void CheckString( String CheckedString, String Name, Boolean CheckEmpty )
		{
			if( Success )
			{
				Success =(( CheckEmpty&&( CheckedString != null )&&( CheckedString.Length != 0 ))
						||( !CheckEmpty&&( CheckedString != null )));
				if( Success )
					Status = Name + " is valid.";
				else
					Status = Name + " is null or empty.";
			}
		}

		// Default Status
		private String DefaultStatus = "Unknown Status";
		
		// Is `Value' an integer?
		private Boolean IsInteger( String Value )
		{
			Boolean IsInt = true;
			char[] Characters = Value.ToCharArray();
			
			for( int i = 0;(( i < Characters.Length )&&IsInt ); i++)
				IsInt = char.IsDigit( Characters [i] );
			
			return IsInt;
		}
	}
}