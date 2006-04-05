indexing
	description: "An error abstraction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ERROR

create
	make,
	make_with_line_information
	
feature -- Creation

	make (a_desc: like description) is
			-- New error with description
		require
			description_not_void: a_desc /= Void
			description_not_empty: not a_desc.is_empty
		do
			description := a_desc
		ensure
			has_description: description /= Void
			description_valid: not description.is_empty
		end
		
	make_with_line_information (a_desc: like description; a_no, a_pos: like line_number) is
			-- New error with description and line data
		require
			valid_number: a_no > 0
           	valid_pos: a_pos > 0
     	do
        	make (a_desc)
        end

feature -- Status Setting

	set_action (a_action: like action) is
			-- Set action
		require
			action_not_void: a_action /= Void
		do
			action := a_action
		ensure
			action_set: action = a_action
		end		

feature -- Access

	description: STRING
			-- Error description
			
	line_number: INTEGER
			-- Line number of error if applicable
	
	line_position: INTEGER
			-- Line position of error if applicable
			
	action: PROCEDURE [ANY, TUPLE]
			-- Response action for error

invariant
	has_description: description /= Void
	description_valid: not description.is_empty

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
end -- class ERROR
