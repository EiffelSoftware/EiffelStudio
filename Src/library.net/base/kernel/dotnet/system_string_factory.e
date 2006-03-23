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
		local
			i, nb: INTEGER
			l_str: STRING_BUILDER
			l_str8: STRING
		do
			if a_str.is_string_8 then
				l_str8 ?= a_str
				create Result.make (l_str8.area.native_array, 0, a_str.count)
			else
				nb := a_str.count
				create l_str.make (nb)
				from
					i := 1
				until
					i > nb
				loop
					l_str := l_str.append (a_str.code (i))
					i := i + 1
				end
				Result := l_str.to_string
			end
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
		local
			i, nb: INTEGER
			l_str8: STRING
		do
			if a_result.is_string_8 then
				l_str8 ?= a_result
				a_str.copy_to (0, l_str8.area.native_array, 0, a_str.length)
			else
				from
					i := 0
					nb := a_str.length
				until
					i = nb
				loop
					a_result.put_code (a_str.chars (i).natural_32_code, i + 1)
					i := i + 1
				end
			end
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
