indexing
	description: "Conference registrant"

class
	REGISTRANT
alias
	"RegistrationService.Registrant"

inherit
	DATABASE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_address_form, a_first_name, a_last_name, a_company_name, a_address: STRING) is
			-- Initialize new registrant with given values.
		require
			non_void_address_form: a_address_form /= Void
			non_void_first_name: a_first_name /= Void
			non_void_last_name: a_last_name /= Void
			non_void_company_name: a_company_name /= Void
			non_void_address: a_address /= Void
			valid_address_form:
								a_address_form.equals ("Mr.")
									or
								a_address_form.equals ("Mrs.")
									or
								a_address_form.equals ("Miss")
									or
								a_address_form.equals ("Ms.")
									or
								a_address_form.equals ("Dr.")
			valid_first_name: a_first_name.count /= 0
			valid_last_name: a_last_name.count /= 0
			valid_address: a_address.count /= 0
		do
			identifier := id_factory.next_registrant_identifier
			address_form := a_address_form
			first_name := a_first_name
			last_name := a_last_name
			company_name := a_company_name
			address := a_address
			initialized := true
		ensure
			address_form_set: initialized implies address_form.equals (a_address_form)
			first_name_set: initialized implies first_name.equals (a_first_name)
			last_name_set: initialized implies last_name.equals (a_last_name)
			company_name_set: initialized implies company_name.equals (a_company_name)
			address_set: initialized implies address.equals (a_address)
		end

feature -- Access

	address_form: STRING
			-- Address form, can be "Mr." Ms." "Mrs." "Miss" or "Dr."

	first_name: STRING
			-- First name

	last_name: STRING
			-- Last name

	company_name: STRING
			-- Company name

	address: STRING 
			-- Mail address

	to_string: STRING is
			-- String representation
		do
			create Result.make (address_form)
			Result := string.concat (Result, " ")
			Result := string.concat (Result, first_name)
			Result := string.concat (Result, " ")
			Result := string.concat (Result, last_name)
			Result := string.concat (Result, ", ")
			Result := string.concat (Result, company_name)
			Result := string.concat (Result, ", ")
			Result := string.concat (Result, address)
		end

feature {NONE} -- Implementation

	string: STRING
			-- String statics access

invariant

	non_void_first_name: initialized implies first_name /= Void
	non_void_last_name: initialized implies last_name /= Void
	non_void_company_name: initialized implies company_name /= Void
	non_void_address: initialized implies address /= Void
	valid_address_form:
						initialized
							implies
						(address_form.equals ("Mr.")
							or
						address_form.equals ("Ms.")
							or
						address_form.equals ("Mrs.")
							or
						address_form.equals ("Miss")
							or
						address_form.equals ("Dr."))

end -- class REGISTRANT