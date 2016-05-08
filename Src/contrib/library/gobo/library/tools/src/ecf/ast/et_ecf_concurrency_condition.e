note

	description:

		"ECF concurrency conditions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_ECF_CONCURRENCY_CONDITION

inherit

	ET_ECF_CONDITION

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make,
	make_excluded

feature {NONE} -- Initialization

	make (a_value: STRING)
			-- Create a new condition where the concurrency mode should be equal to `a_value'.
		require
			a_value_not_void: a_value /= Void
			a_value_not_empty: not a_value.is_empty
		do
			value := a_value
			is_excluded := False
		ensure
			value_set: value = a_value
			not_excluded: not is_excluded
		end

	make_excluded (a_value: STRING)
			-- Create a new condition where the concurrency mode should not be equal to `a_value'.
		require
			a_value_not_void: a_value /= Void
			a_value_not_empty: not a_value.is_empty
		do
			value := a_value
			is_excluded := True
		ensure
			value_set: value = a_value
			excluded: is_excluded
		end

feature -- Access

	value: STRING
			-- Concurrency mode value

feature -- Status report

	is_enabled (a_state: ET_ECF_STATE): BOOLEAN
			-- Does `a_state' fulfill current condition?
		local
			l_expected_value: STRING
			l_splitter: ST_SPLITTER
		do
			if a_state.is_multithreaded then
				l_expected_value := "thread"
			elseif a_state.is_scoop then
				l_expected_value := "scoop"
			else
				l_expected_value := "none"
			end
			if value.has (' ') then
				create l_splitter.make_with_separators (" ")
				Result := l_splitter.split (value).there_exists (agent STRING_.same_case_insensitive (?, l_expected_value))
			else
				Result := STRING_.same_case_insensitive (value, l_expected_value)
			end
			Result := (is_excluded /= Result)
		end

	is_excluded: BOOLEAN
			-- Should the concurrency mode not be equal to `value'?

invariant

	value_not_void: value /= Void
	value_not_empty: not value.is_empty

end
