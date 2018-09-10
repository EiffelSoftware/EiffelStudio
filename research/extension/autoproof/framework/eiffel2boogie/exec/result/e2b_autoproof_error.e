note
	description: "A result for a failed verification."
	date: "$Date$"
	revision: "$Revision$"

class
	E2B_AUTOPROOF_ERROR

inherit

	E2B_VERIFICATION_RESULT
		redefine
			is_equal
		end

	E2B_SHARED_CONTEXT
		redefine
			is_equal
		end

feature -- Access

	type: STRING
			-- Type of error.

	single_line_message (a_formatter: TEXT_FORMATTER)
			-- Single line description of this result.
		do
			a_formatter.add (internal_message)
		end

	context_line_number: INTEGER
			-- Line number of error (if any)

	is_warning: BOOLEAN
			-- Should verification proceed if this error occurs?

feature -- Element change

	set_type (a_string: STRING)
			-- Set `type' to `a_type'.
		do
			type := a_string
		end

	set_message (a_string: STRING)
			-- Set `single_line_message' to `a_string'.
		do
			internal_message := a_string
		end

	set_line_number (a_value: INTEGER)
			-- Set `context_line_number' to `a_value'.
		do
			context_line_number := a_value
		end

	set_warning (a_flag: BOOLEAN)
			-- Set `is_warning' to `a_flag'
		do
			is_warning := a_flag
		end

feature -- Comparison

	is_equal (a_other: like Current): BOOLEAN
			-- Does `a_other' represent the same error in the same context?
		do
			Result := type ~ a_other.type and
				helper.is_same_class (context_class, a_other.context_class) and
				helper.is_same_feature (context_feature, a_other.context_feature) and
				context_line_number = a_other.context_line_number and
				internal_message ~ a_other.internal_message
		end

feature {E2B_AUTOPROOF_ERROR} -- Implementation

	internal_message: STRING
			-- Message for this error.

end
