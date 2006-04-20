indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class INH_ASSERT_INFO

inherit
	SHARED_WORKBENCH

create
	make

feature {NONE} -- Initialization

	make (feat: FEATURE_I) is
			-- Update `has_precondition' and 
			-- `has_postcondition' fields.
		do
			written_in := feat.written_in
			body_index := feat.body_index
			has_postcondition := feat.has_postcondition
			has_precondition := feat.has_precondition
			precondition_count := feat.number_of_precondition_slots
			postcondition_count := feat.number_of_postcondition_slots
		end

feature -- Access

	written_in: INTEGER
			-- Written_in id of the routine that has assertion

	body_index: INTEGER
			-- Body index value of the routine that has the assertion

	has_postcondition: BOOLEAN
			-- Is has_postcondition set to True? 

	has_precondition: BOOLEAN
			-- Is has_precondition set to True? 

	has_assertion: BOOLEAN is
		do
			Result := (has_precondition or else has_postcondition)
		end

	precondition_count: INTEGER
			-- Number of preconditions
			-- (inherited assertions are not taken into account)

	postcondition_count: INTEGER
			-- Number of postconditions
			-- (inherited assertions are not taken into account)

feature -- Comparison

	same_as (other: like Current): BOOLEAN is
			-- Check to see if assertions has changed
		do
			Result := (has_precondition = other.has_precondition) and then
					(has_postcondition = other.has_postcondition) and then
					(body_index = other.body_index)
		end

feature -- Debugging

	trace is
		do
			io.put_string ("written_in class: ")
			io.put_string (System.class_of_id (written_in).name)
			io.put_new_line
			io.put_string ("body_index: ")
			io.put_integer (body_index)
			io.put_new_line
			io.put_string ("has_postcondition: ")
			io.put_boolean (has_postcondition)
			io.put_new_line
			io.put_string ("has_precondition: ")
			io.put_boolean (has_precondition)
			io.put_new_line
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
