indexing

	description:
		"Abstract notion of a profile filter used to check the language %
		%type of a function.";
	date: "$Date$";
	revision: "$Revision$"

deferred class LANGUAGE_FILTER

inherit
	PROFILE_FILTER

feature {NONE} -- Implementation

	filter(input_set: PROFILE_SET): PROFILE_SET is
		do
		end

	filtering_is_allowed: BOOLEAN is
		do
		end

	set_operator (new_operator: STRING) is
		do
		end

	set_value (new_value: COMPARABLE) is
		do
		end

	set_value_range( lower, upper: COMPARABLE) is
		do
		end

	extend (new_filter: PROFILE_FILTER) is
		do
		end

end -- class LANGUAGE_FILTER
