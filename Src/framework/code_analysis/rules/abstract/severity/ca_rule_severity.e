note
	description: "Represents the categorization of a rule regarding severity."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CA_RULE_SEVERITY

feature -- Properties

	is_critical: BOOLEAN
			-- Is the severity category critical for program execution?
		deferred
		end

	name: STRING_32
			-- What the severity is called; what is shown to the user.
		deferred
		ensure
			valid_result: Result /= Void
		end

	short_form: STRING_32
			-- Short form (ideally a single character) of the  severity.
		deferred
		ensure
			valid_result: Result /= Void
		end
end
