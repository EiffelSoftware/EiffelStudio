note
	description: "Summary description for {ECF_VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ECF_VISITOR

feature -- Visitor

	process_ecf (v: ECF)
		deferred
		end

	process_application_ecf (v: APPLICATION_ECF)
		deferred
		end

	process_library_ecf (v: LIBRARY_ECF)
		deferred
		end

	process_testing_ecf (v: TESTING_ECF)
		deferred
		end

end
