indexing
	description: "Conference registration."

class
	REGISTRATION
alias
	"RegistrationService.Registration"

inherit
	DATABASE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_registrant_id: INTEGER;
			a_quantity, a_discount_plan: STRING;
			a_preconf, a_wet, a_conference, a_esummit, a_postconf: BOOLEAN) is
			-- Initialize new regsitrant with given values.
		require
			non_void_quantity: a_quantity /= Void
			non_void_discount_plan: a_discount_plan /= Void
			valid_registrant_id: a_registrant_id > 0
			valid_discount_plan:
								a_discount_plan.equals ("Regular")
									or
								a_discount_plan.equals ("Non-academic Authors")
									or
								a_discount_plan.equals ("Full-Time Students")
									or
								a_discount_plan.equals ("Full-Time Faculty Members")
		local
			my_quantity: MY_STRING
		do
			create my_quantity.make (a_quantity)
			if not my_quantity.is_integer or else my_quantity.to_integer <= 0 then
				error_message := "Invalid quantity, quantity must be an integer and greater than 0."
			else
				identifier := id_factory.next_registration_identifier
				registrant_id := a_registrant_id
				quantity := my_quantity.to_integer
				discount_plan := a_discount_plan
				preconf := a_preconf
				wet := a_wet
				conference := a_conference
				esummit := a_esummit
				postconf := a_postconf
				initialized := True
			end
		ensure
			registrant_id_set: initialized implies registrant_id.equals (a_registrant_id)
			quantity_set: initialized implies integer.to_string (quantity).equals (a_quantity)
			discount_plan_set: initialized implies discount_plan.equals (a_discount_plan)
			preconf_set: initialized implies preconf.equals (a_preconf)
			wet_set: initialized implies wet.equals (a_wet)
			conference_set: initialized implies conference.equals (a_conference)
			esummit_set: initialized implies esummit.equals (a_esummit)
			postconf_set: initialized implies postconf.equals (a_postconf)
		end

feature -- Access

	registrant_id: INTEGER
			-- Associated registrant identifier

	quantity: INTEGER
			-- Number of seats
	
	discount_plan: STRING
			-- Type of regsitration

	preconf: BOOLEAN
			-- Does registration include participation to pre-conference?

	wet: BOOLEAN
			-- Does registration include participation to wet?

	conference: BOOLEAN
			-- Does registration include participation to main conference?

	esummit: BOOLEAN 
			-- Does registration include participation to Eiffel Summit?
	
	postconf: BOOLEAN 
			-- Does registration include participation to post-conference?

	to_string: STRING is
			-- String representation
		do
			Result := string.concat_system_object (quantity)
			Result := string.concat (Result, " ")
			Result := string.concat (Result, discount_plan)
			if quantity = 1 then
				Result := string.concat (Result, " registration (number ")
			else
				Result := string.concat (Result, " registrations (number ")
			end
			Result := string.concat_system_object_system_object (Result, identifier)
			Result := string.concat (Result, ") for registrant ")
			Result := string.concat_System_object_system_object (Result, registrant_id)
			Result := string.concat (Result, ":\n")
			if preconf then
				Result := string.concat (Result, "Pre-Conference")
			end
			if wet then
				Result := string.concat (Result, "Workshop for Education and Training")
			end
			if conference then
				Result := string.concat (Result, "Main Conference")
			end
			if esummit then
				Result := string.concat (Result, "Eiffel Summit")
			end
			if postconf then
				Result := string.concat (Result, "Post-Conference")
			end
		end

feature {NONE} -- Implementation

	integer: INTEGER
			-- Integer statics access

	string: STRING
			-- String statics access

invariant

	valid_registrant_id: initialized implies (registrant_id > 0)
	valid_quantity: initialized implies (quantity > 0)
	valid_discount_plan:
						initialized
							implies
						(discount_plan.equals ("Regular")
							or
						discount_plan.equals ("Non-academic Authors")
							or
						discount_plan.equals ("Full-Time Students")
							or
						discount_plan.equals ("Full-Time Faculty Members"))

end -- class REGISTRATION
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

