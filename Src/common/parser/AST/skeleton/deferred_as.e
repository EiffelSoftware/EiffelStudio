indexing
	description: "AST representation of a deferred routine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEFERRED_AS

inherit
	ROUT_BODY_AS
		undefine
			text
		redefine
			is_deferred, has_instruction, index_of_instruction,
			is_equivalent
		end

	KEYWORD_AS
		undefine
			number_of_breakpoint_slots,
			is_equivalent,
			process
		end

create
	make_with_location

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_deferred_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	is_deferred: BOOLEAN is True
			-- Is the current routine body a defferred one ?

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Has the current routine body an instruction `i'?
		do
			Result := False
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this deferred feature.
			-- Result is `0'.
		do
			Result := 0
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

end -- class DEFERRED_AS
