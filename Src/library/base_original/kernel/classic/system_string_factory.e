indexing
	description: "Factory for creating SYSTEM_STRING instances."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_STRING_FACTORY

feature -- Conversion

	from_string_to_system_string (a_str: STRING_GENERAL): SYSTEM_STRING is
			-- Convert `a_str' to an instance of SYSTEM_STRING.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
		do
		ensure
			from_string_to_system_string_not_void: Result /= Void
		end

	read_system_string_into (a_str: SYSTEM_STRING; a_result: STRING_GENERAL) is
			-- Fill `a_result' with `a_str' content.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_result_not_void: a_result /= Void
			a_result_valid: a_result.count = a_str.length
		do
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
