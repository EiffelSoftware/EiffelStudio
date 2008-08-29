indexing
	description: "Abstract notion of a routine body."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class ROUT_BODY_AS

inherit
	AST_EIFFEL

feature -- Properties

	is_attribute: BOOLEAN
			-- Is it an attribute?
		do
			-- Do nothing
		end

	is_once: BOOLEAN is
			-- Is the routine body a once one ?
		do
			-- Do nothing
		end

	is_deferred: BOOLEAN is
			-- Is the routine body a deferred one ?
		do
			-- Do nothing
		end

	is_external: BOOLEAN is
			-- Is the routine body an external one ?
		do
			-- Do nothing
		end

	is_built_in: BOOLEAN is
			-- Is the routine body an external `built_in' one?
		do
		end

feature -- Access

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
			-- Has current routine body instruction `i'?
		do
			-- Do nothing
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i'.
		do
			-- Do nothing
		end

feature -- test for empty body

	is_empty : BOOLEAN is
			-- Is body empty?
		do
			Result := True  -- redefined in INTERNAL_AS
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

end -- class ROUT_BODY_AS
