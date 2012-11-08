note
	description: "Abstract description of a call as an instruction, %
				%Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INSTR_CALL_AS

inherit
	INSTRUCTION_AS
		redefine
			starts_with_parenthesis
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like call)
			-- Create a new INSTR_CALL AST node.
		require
			c_not_void: c /= Void
		do
			call := c
		ensure
			call_set: call = c
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_instr_call_as (Current)
		end

feature -- Attributes

	call: CALL_AS
			-- Call instruction

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			Result := call.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := call.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := call.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call)
		end

feature {INTERNAL_AS} -- Status report

	starts_with_parenthesis: BOOLEAN
			-- Is the first format item a "(".
			-- See: AST_FORMATTER_VISITOR.format_compound.
		do
			Result := attached {NESTED_EXPR_AS} call
		end

invariant
	call_not_void: call /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class INSTR_CALL_AS
