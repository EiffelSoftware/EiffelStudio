note
	description:
			"Abstract description of the content of a %
			%feature. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class CONTENT_AS

inherit
	AST_EIFFEL

feature -- Properties

	is_built_in: BOOLEAN
			-- Is the current content a built in?
		deferred
		end

	is_constant: BOOLEAN
			-- is the current content a constant content ?
		do
			-- Do nothing
		end

	is_unique: BOOLEAN
			-- Is the current content a unique ?
		do
			-- Do nothing
		end

	is_require_else: BOOLEAN
			-- Is the precondition block of the content preceeded by
			-- `require else' ?
		do
			-- Do nothing
		end

	is_ensure_then: BOOLEAN
			-- Is the postcondition block of the content preceeded by
			-- `ensure then' ?
		do
			-- Do nothing
		end

	has_precondition: BOOLEAN
			-- Has the content precondition(s) ?
		do
			-- Do nothing
		end

	has_postcondition: BOOLEAN
			-- Has the content postcondition(s) ?
		do
			-- Do nothing
		end

feature -- Access

	has_assertion: BOOLEAN
			-- Has the content pre- or postcondition(s) ?
		do
			Result := has_precondition or else has_postcondition
		end

	has_rescue: BOOLEAN
			-- Has the current content a rescue clause ?
		do
			-- Do nothing
		end

	is_body_equiv (other: like Current): BOOLEAN
		-- Is the current feature equivalent to `other' ?
		require
			valid_other: other /= Void
		deferred
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN
			-- Does the current content has instruction `i'?
		deferred
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER
			-- Index of `i' in current content.
		deferred
		end

	number_of_precondition_slots: INTEGER
			-- Number of postconditions
			-- (inherited assertions are not taken into account)
		do
			-- Return 0
		end

	number_of_postcondition_slots: INTEGER
			-- Number of preconditions
			-- (inherited assertions are not taken into account)
		do
			-- Return 0
		end

feature -- test for empty body

	is_empty : BOOLEAN
			-- Is content empty?
		do
			Result := True  -- redefined in ROUTINE_AS
		end

feature -- default rescue

	create_default_rescue (def_resc_name_id: INTEGER)
			-- Create default rescue clause if necessary
		require
			valid_feature_name_id: def_resc_name_id > 0
		do
			-- redefined in ROUTINE_AS
		end

note
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

end -- class CONTENT_AS
