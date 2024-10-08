﻿note
	description: "Resource table hashed on resource name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	RESOURCE_TABLE

inherit
	HASH_TABLE [STRING, STRING]

create

	make

feature -- Access

	get_integer (name: STRING; default_value: INTEGER): INTEGER
			-- Value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
		do
			if
				attached item (name) as string_value and then
				string_value.is_integer
			then
				Result := string_value.to_integer
			else
				Result := default_value
			end
		end

	get_pos_integer (name: STRING; default_value: INTEGER): INTEGER
			-- Positive value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
			valid_default_value: default_value >= 0
		do
			if
				attached item (name) as string_value and then
				string_value.is_integer
			then
				Result := string_value.to_integer.abs
			else
				Result := default_value
			end
		ensure
			result_is_positive: Result >= 0
		end

	get_boolean (name: STRING; default_value: BOOLEAN): BOOLEAN
			-- Value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
		do
			if
				attached item (name) as string_value and then
				string_value.is_boolean
			then
				Result := string_value.to_boolean
			else
				Result := default_value
			end
		end

	get_real (name: STRING; default_value: REAL): REAL
			-- Value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
		do
			if
				attached item (name) as string_value and then
				string_value.is_real
			then
				Result := string_value.to_real
			else
				Result := default_value
			end
		end

	get_string (name: STRING): detachable STRING
			-- Value of the resource `name'.
		require
			name_not_void: name /= Void
		do
			Result := item (name)
		end

	get_string_or_default (name: STRING; default_value: like get_string_or_default): STRING
			-- Value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
			default_value_attached: default_value /= Void
		do
			Result := get_string (name)
			if not attached Result then
				Result := default_value
			end
		ensure
			result_attached: Result /= Void
		end

	get_array (name: STRING): detachable ARRAY [STRING]
			-- Array value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
		local
			a_list: LINKED_LIST [STRING]
			c, pos, last_pos: INTEGER
			an_entry: STRING
		do
			if attached item (name) as a_text then
				create a_list.make
				from
					c := a_text.count
					last_pos := 1
					pos := 1
				until
					last_pos >= c
				loop
					pos := a_text.index_of (';', pos)
					if pos = 0 then
						an_entry := a_text.substring (last_pos, c)
						last_pos := c
							-- Remove leading / trailing spaces.
						an_entry.left_adjust
						an_entry.right_adjust
						a_list.extend (an_entry)
					elseif last_pos /= pos then
						an_entry := a_text.substring (last_pos, pos - 1)
							-- Remove leading / trailing spaces.
						an_entry.left_adjust
						an_entry.right_adjust
						a_list.extend (an_entry)
						pos := pos + 1
						last_pos := pos
					else
						pos := pos + 1
						last_pos := pos
					end
				end
				across
					a_list as l
				from
					create Result.make_empty
					pos := 1
				loop
					Result.force (l, pos)
					pos := pos + 1
				end
			end
		end

	get_array_or_default (name: STRING; default_value: like get_array_or_default): ARRAY [STRING]
			-- Array value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
			default_value_attached: default_value /= Void
		do
			Result := get_array (name)
			if not attached Result then
				Result := default_value
			end
		end

	get_character (name: STRING; default_value: CHARACTER): CHARACTER
			-- Value of the resource `name';
			-- `default_value' if this value is not known.
		require
			name_not_void: name /= Void
		do
			if
				attached item (name) as string_value and then
				string_value.count > 0
			then
				Result := string_value [1]
			else
				Result := default_value
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
