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

	next_registrant_identifier: INTEGER is
			-- New registrant identifier
		do
			Result := registrant_id
			registrant_id := registrant_id + 1
		end

	next_registration_identifier: INTEGER is
			-- New registration identifier
		do
			Result := registration_id
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
