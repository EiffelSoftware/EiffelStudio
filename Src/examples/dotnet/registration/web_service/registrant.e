indexing
	description: "Conference registrant"

class
	REGISTRANT
alias
	"RegistrationService.Registrant"

inherit
	DATABASE_ITEM
		redefine
			to_string
		end

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
								a_address_form.is_equal ("Mr.")
									or
								a_address_form.is_equal ("Mrs.")
									or
								a_address_form.is_equal ("Miss")
									or
								a_address_form.is_equal ("Ms.")
									or
								a_address_form.is_equal ("Dr.")
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
			address_form_set: initialized implies address_form.is_equal (a_address_form)
			first_name_set: initialized implies first_name.is_equal (a_first_name)
			last_name_set: initialized implies last_name.is_equal (a_last_name)
			company_name_set: initialized implies company_name.is_equal (a_company_name)
			address_set: initialized implies address.is_equal (a_address)
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
			Result := address_form
			Result := string.concat_string_string (Result, " ")
			Result := string.concat_string_string (Result, first_name)
			Result := string.concat_string_string (Result, " ")
			Result := string.concat_string_string (Result, last_name)
			Result := string.concat_string_string (Result, ", ")
			Result := string.concat_string_string (Result, company_name)
			Result := string.concat_string_string (Result, ", ")
			Result := string.concat_string_string (Result, address)
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
						(address_form.is_equal ("Mr.")
							or
						address_form.is_equal ("Ms.")
							or
						address_form.is_equal ("Mrs.")
							or
						address_form.is_equal ("Miss")
							or
						address_form.is_equal ("Dr."))

end -- class REGISTRANT
--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

