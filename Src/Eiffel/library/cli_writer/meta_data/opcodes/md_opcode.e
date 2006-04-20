indexing
	description: "Data about opcodes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_OPCODE

create
	make
	
feature {NONE} -- Initialization

	make (an_opcode_value: INTEGER_16; a_stack_depth_transition: INTEGER; a_format: INTEGER) is
			-- Initialize current opcode with `an_opcode_value'
			-- and `a_format'.
		do
			value := an_opcode_value
			format := a_format
			stack_depth_transition := a_stack_depth_transition
		ensure
			value_set: value = an_opcode_value
			format_set: format = a_format
			stack_depth_transition_set: stack_depth_transition = a_stack_depth_transition
		end
		
feature -- Access

	value: INTEGER_16
			-- Opcode value.
			-- See MD_OPCODES for possible values.
			
	format: INTEGER
			-- Format of arguments.
			-- See MD_OPCODE_FORMATS for possible values.

	stack_depth_transition: INTEGER;
			-- Stack depth transition.

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

end -- class MD_OPCODE
