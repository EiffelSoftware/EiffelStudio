indexing
	description	: "Resource encapsulating an array of strings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ARRAY_RESOURCE

inherit
	STRING_RESOURCE
		rename
			make as sr_make,
			default_value as value
		redefine
			set_value, value, xml_trace,
			registry_name
		end


create
	make, 
	make_from_string

feature {NONE} -- Initialization

	make (a_name: STRING; a_value: ARRAY [STRING]) is
			-- Initialize Current
		do
			name := a_name
			actual_value := a_value
			update_value
		end

	make_from_string (a_name: STRING; a_value: STRING) is
			-- Initialize Current
		do
			name := a_name
			value := a_value
			update_actual_value
		end

feature -- Access

	value: STRING
			-- Value of the resource 

	actual_value: ARRAY [STRING]
			-- The array, as reprensented by `value'.

feature -- Setting

	set_actual_value (an_array: ARRAY [STRING]) is
			-- Set `actual_value' to `an_array' and
			-- update `value'.
		do
			actual_value := an_array
			update_value
		end

	set_value (a_string: STRING) is
			-- Set `value' to `a_string' and update
			-- `actual_value',
		do
			value := a_string
			update_actual_value
		end

feature {NONE} -- Implementation

	update_value is
			-- Updates `value' using current `actual_value'.
		local
			index: INTEGER
			not_first_time: BOOLEAN
			c: INTEGER
		do
			create value.make (0)
			c := actual_value.count
			if c > 0 then
				from
					index := 1
				until
					index > c
				loop
					if not not_first_time then
						not_first_time := True
					else
						value.append (";")
					end;
					value.append (actual_value.item (index))
					index := index + 1
				end
			end
		end

	update_actual_value is
			-- Update `actual_value' using current `value'.
		local
			start_pos, end_pos: INTEGER
		do
			create actual_value.make (1, 0)
			if not value.is_empty then
				from
					start_pos := 1
					end_pos := value.index_of (';', start_pos)
				until
					end_pos = 0 or start_pos = value.count
				loop
					actual_value.force (value.substring (start_pos, end_pos - 1), actual_value.count + 1)
					start_pos := end_pos + 1
					end_pos := value.index_of (';', start_pos)
				end
				if start_pos <= value.count then
					actual_value.force (value.substring (start_pos, value.count), actual_value.count + 1)
				end
			end
		end

feature -- Output

	xml_trace: STRING is
			-- XML representation of current
		local
			xml_name, xml_value: STRING
		do
			xml_name := name
			xml_value := value

			create Result.make (41 + xml_name.count + xml_value.count)
			Result.append ("<TEXT>")
			Result.append (xml_name)
			Result.append ("<LIST_STRING>")
			Result.append (xml_value)
			Result.append ("</LIST_STRING></TEXT>")
		end

	registry_name: STRING is
			-- name of Current in the registry
		do
			Result := "EIFARR_" + name
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ARRAY_RESOURCE
