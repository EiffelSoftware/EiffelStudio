note
	description: "Factory for creating SYSTEM_STRING instances."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_STRING_FACTORY

feature -- Conversion

	from_string_to_system_string (a_str: READABLE_STRING_GENERAL): SYSTEM_STRING
			-- Convert `a_str' to an instance of SYSTEM_STRING.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
		local
			i, nb: INTEGER
			l_str: STRING_BUILDER
			l_dummy: ?STRING_BUILDER
			l_string: ?SYSTEM_STRING
		do
			if {l_str8: STRING_8} a_str then
				create Result.make (l_str8.area.native_array, 0, a_str.count)
			else
				nb := a_str.count
				create l_str.make (nb)
				from
					i := 1
				until
					i > nb
				loop
					l_dummy := l_str.append_character (a_str.code (i).to_character_8)
					i := i + 1
				end
				l_string := l_str.to_string
				check l_string_attached: l_string /= Void end
				Result := l_string
			end
		ensure
			from_string_to_system_string_not_void: Result /= Void
		end

	read_system_string_into (a_str: SYSTEM_STRING; a_result: STRING_GENERAL)
			-- Fill `a_result' with `a_str' content.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_result_not_void: a_result /= Void
			a_result_valid: a_result.count = a_str.length
		local
			i, nb: INTEGER
		do
			if {l_str8: STRING_8} a_result then
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

	read_system_string_into_area_8 (a_str: SYSTEM_STRING; a_area: SPECIAL [CHARACTER_8])
			-- Fill `a_result' with `a_str' content.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_area_not_void: a_area /= Void
			a_area_valid: a_area.count >= a_str.length
		do
			a_str.copy_to (0, a_area.native_array, 0, a_str.length)
		end

	read_system_string_into_area_32 (a_str: SYSTEM_STRING; a_area: SPECIAL [CHARACTER_32])
			-- Fill `a_area' with `a_str' content.
		require
			is_dotnet: {PLATFORM}.is_dotnet
			a_str_not_void: a_str /= Void
			a_area_not_void: a_area /= Void
			a_area_valid: a_area.count >= a_str.length
		local
			i, nb: INTEGER
		do
			from
				i := 0
				nb := a_str.length
			until
				i = nb
			loop
				a_area.put (a_str.chars (i), i)
				i := i + 1
			end
		end

note
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
