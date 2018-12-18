note
	description	: "Abstract class representing routines that have a body."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			is_empty,
			has_instruction, index_of_instruction
		end

feature {AST_FACTORY} -- Initialization

	initialize (c: like compound)
			-- Create a new INTERNAL AST node.
		do
			compound := c
		ensure
			compound_set: compound = c
		end

feature -- Attributes

	compound: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound.

	first_breakpoint_slot_index: INTEGER
			-- Index of the first breakpoint slot. Set during semantic check (AST_FEATURE_CHECKER_GENERATOR).

feature -- Status report

	is_empty : BOOLEAN
		do
			Result := not attached compound as l_compound or else l_compound.is_empty
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (compound, other.compound)
		end

feature -- Access

	has_instruction (i: INSTRUCTION_AS): BOOLEAN
			-- Does the current routine body has instruction `i'?
		do
			if attached compound as l_compound then
				from
					l_compound.start
				until
					Result or else l_compound.off
				loop
					Result := equivalent (l_compound.item, i)
					l_compound.forth
				end
			end
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER
			-- Index of `i' in this feature.
		do
			if attached compound as l_compound then
				from
					l_compound.start
				until
					l_compound.off or else equivalent (i, l_compound.item)
				loop
					l_compound.forth
				end

				if not l_compound.off then
					Result := l_compound.index
				end
			end
		end

	set_first_breakpoint_slot_index (slot_index: INTEGER)
			-- Set `first_first_breakpoint_slot_index' to `slot_index'.
		do
			first_breakpoint_slot_index := slot_index
		ensure
			first_breakpoint_slot_index_set: first_breakpoint_slot_index = slot_index
		end

feature {INTERNAL_AS} -- Replication

	set_compound (c: like compound)
		do
			compound := c
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
