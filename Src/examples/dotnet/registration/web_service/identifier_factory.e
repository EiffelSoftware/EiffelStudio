indexing
	description: "Registrants and registrations ids factory"

class
	IDENTIFIER_FACTORY
alias
	"RegistrationService.IdentifierFactory"

create
	make

feature {NONE} -- Initialization

	make is
			-- Initilize identifiers to default values.
		do
			registrant_id := Default_registrant_id
			registration_id := Default_registration_id
		end

feature -- Access

	next_registrant_identifier: STRING is
			-- New registrant identifier
		local
			converter: SYSTEM_CONVERT
		do
			Result := converter.to_string_int32 (registrant_id)
			registrant_id := registrant_id + 1
		end

	next_registration_identifier: STRING is
			-- New registration identifier
		local
			converter: SYSTEM_CONVERT
		do
			Result := converter.to_string_int32 (registration_id)
			registration_id := registration_id + 1
		end

	Default_registrant_id: INTEGER is 1000
			-- First registrant identifier

	Default_registration_id: INTEGER is 1000
			-- First registration identifier

feature {NONE} -- Implementation

	registrant_id: INTEGER
			-- Next registrant id to be generated

	registration_id: INTEGER
			-- Next registration id to be generated

end -- class IDENTIFIER_FACTORY

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

