external class
	INPUT_CHECKER
alias
	"RegistrationClient.InputChecker"

create
	make

feature {NONE} -- Initialization

	make is
		external
			"IL creator use RegistrationClient.InputChecker"
		end

feature -- Access

	success: BOOLEAN is
		external
			"IL field signature :System.Boolean use RegistrationClient.InputChecker"
		alias
			"Success"
		end

	status: STRING is
		external
			"IL field signature :System.String use RegistrationClient.InputChecker"
		alias
			"Status"
		end

feature -- Element Change

	set_success is
		external
			"IL set_field signature (System.Boolean) use RegistrationClient.InputChecker"
		alias
			"Success"
		end

	set_status is
		external
			"IL set_field signature (System.String) use RegistrationClient.InputChecker"
		alias
			"Status"
		end

feature -- Basic Operations

	frozen check_registrant (Title: STRING; FirstName: STRING; LastName: STRING; CompanyName: STRING; Address: STRING; City: STRING; State: STRING; ZipCode: STRING; Country: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String, System.String): System.Void use RegistrationClient.InputChecker"
		alias
			"CheckRegistrant"
		end

	frozen check_registration (RegistrantID: INTEGER; Quantity: STRING; DiscountPlan: STRING) is
		external
			"IL signature (System.Int32, System.String, System.String): System.Void use RegistrationClient.InputChecker"
		alias
			"CheckRegistration"
		end

end -- class INPUT_CHECKER