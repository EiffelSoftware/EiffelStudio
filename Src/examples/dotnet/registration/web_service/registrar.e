indexing
	description: "Registration services, include adding new registrants and new registrations."

class
	REGISTRAR
alias
	"RegistrationService.Registrar"

inherit
	WEB_SERVICE

create
	start

feature {NONE} -- Initialization

	start is
			-- Set empty error message.
		do
			set_last_operation_successful (True)
			set_last_error_message ("No Error")
			set_last_registrant_identifier (-1)
		end

feature -- Access

	registrants_database: DATABASE [REGISTRANT, INTEGER] is
			-- Registrants database
		once
			create Result.make
		end

	registrations_database: DATABASE [REGISTRATION, INTEGER] is
			-- Registrations database
		once
			create Result.make
		end

	last_error_message: STRING is
			-- Last error description
		do
			Result ?= Application.item_system_string ("last_error_message")
		end

	last_registrant_identifier: INTEGER is
			-- Last registered registrant identifier
		local
			encoded: STRING
		do
			encoded ?= Application.item_system_string ("last_registrant_identifier")
			Result := encoded.toint32
		end

	last_operation_successful: BOOLEAN is
			-- Was last operation successful?
		local
			encoded: STRING
		do
			encoded ?= Application.item_system_string ("last_operation_successful")
			Result := Result.FromString (encoded)
		end

feature -- Element Change

	set_last_error_message (message: STRING) is
			-- Set `last_error_message' with `message'.
		require
			non_void_message: message /= Void
			valid_message: not (message.count = 0)
		do
			Application.set_item( "last_error_message", message )
		ensure
			last_error_message_set: last_error_message.equals (message)
		end
		
	set_last_registrant_identifier (id: INTEGER) is
			-- Set `last_registrant_identifier' with `id'.
		local
			encoded: STRING
		do
			Application.set_item ("last_registrant_identifier", encoded.concat_system_object (id))
		ensure
			last_registrant_identifier_set: last_registrant_identifier = id
		end
	
	set_last_operation_successful (success: BOOLEAN) is
			-- Set `last_operation_successful' with `success'
		local
			encoded: STRING
		do
			Application.set_item ("last_operation_successful", encoded.concat_system_object (success))
		ensure
			last_operation_successful_set: last_operation_successful = success
		end
		
feature -- Basic Operations

	add_registrant (address_form, first_name, last_name, company_name, address, city, state, zip, country: STRING) is
			-- Add new registrant.
		require
			non_void_address_form: address_form /= Void
			non_void_first_name: first_name /= Void
			non_void_last_name: last_name /= Void
			non_void_company_name: company_name /= Void
			non_void_address: address /= Void
			non_void_city: address /= Void
			non_void_state: address /= Void
			non_void_zip: address /= Void
			non_void_country: address /= Void
			valid_adress_form:
								address_form.equals ("Mr.")
									or
								address_form.equals ("Mrs.")
									or
								address_form.equals ("Miss")
									or
								address_form.equals ("Ms.")
									or
								address_form.equals ("Dr.")
			valid_first_name: first_name.count /= 0
			valid_last_name: last_name.count /= 0
			valid_address: address.count /= 0
			valid_city: city.count /= 0
			valid_state: state.count /= 0
			valid_zip: zip.count /= 0
			valid_country: country.count /= 0
		local
			new_registrant: REGISTRANT
			full_address: STRING
			zip_verifier: MY_STRING
		do
			create zip_verifier.make (zip)
			if not zip_verifier.is_integer then
				set_last_registrant_identifier (-1)
				set_last_error_message ("Invalid zip code")
				set_last_operation_successful (False)
			else	
				full_address := string.concat (address, ", ")
				full_address := string.concat (full_address, city)
				full_address := string.concat (full_address, " ")
				full_address := string.concat (full_address, state)
				full_address := string.concat (full_address, " ")
				full_address := string.concat (full_address, zip)
				full_address := string.concat (full_address, ", ")
				full_address := string.concat (full_address, country)
				create new_registrant.make (address_form,
										first_name,
										last_name,
										company_name,
										full_address)
									
				if new_registrant.initialized then
					set_last_registrant_identifier (new_registrant.identifier)
					
					registrants_database.store (new_registrant,
											last_registrant_identifier)
										
					set_last_operation_successful (True)
				else
					set_last_registrant_identifier (-1)
					set_last_error_message (new_registrant.error_message)
					set_last_operation_successful (False)
				end
			end
		end

	add_registration (registrant_id: INTEGER;
					quantity, discount_plan: STRING;
					preconf, wet, conference, esummit, postconf: BOOLEAN) is
			-- Add new registration.
		require
			non_void_quantity: quantity /= Void
			non_void_discount_plan: discount_plan /= Void
			valid_discount_plan:
								discount_plan.equals ("Regular")
									or
								discount_plan.equals ("Non-academic Authors")
									or
								discount_plan.equals ("Full-Time Students")
									or
								discount_plan.equals ("Full-Time Faculty Members")
		local
			new_registration: REGISTRATION
		do
			create new_registration.make (registrant_id,
									quantity,
									discount_plan,
									preconf,
									wet,
									conference,
									esummit,
									postconf)
									
			if new_registration.initialized then
			
				registrations_database.store (new_registration,
										new_registration.identifier)
										
				set_last_operation_successful (True)
			else
				set_last_error_message (new_registration.error_message)
				set_last_operation_successful (False)
			end
		end

feature {NONE} -- Implementation

	string: STRING
			-- String statics access

invariant

	message_if_error:
						not last_operation_successful
							implies
						(last_error_message /= Void
							and then
						(last_error_message.count /= 0))

end -- class REGISTRAR

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

