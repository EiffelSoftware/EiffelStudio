indexing
	description: "Shared objects"

class
	SHARED_DATA
alias
	"RegistrationService.SharedData"

feature -- Access

	id_factory: IDENTIFIER_FACTORY is
			-- Registrants and registrations ids factory
		once
			create Result.make
		end

end -- class SHARED_DATA
