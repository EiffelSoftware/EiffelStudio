indexing
	description: "Entry in completion list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPLETION_ENTRY

feature -- Access

	name: STRING is
			-- Completion entry name
		deferred
		end

	signature: STRING is
			-- Completion entry description
		deferred
		end

	is_feature (return_value: BOOLEAN_REF) is
			-- Is entry a feature? (could be a variable)
		deferred
		end

end -- class COMPLETION_ENTRY
