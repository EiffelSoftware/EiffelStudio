indexing
	description:
		"Edit field that prompt the user to type a symbol for a feature%N%
		%or local variable. Cannot be a symbol already defined or a keyword."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_NAME_EDIT

inherit
	EV_TEXT_FIELD
		redefine
			initialize
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, copy
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			set_minimum_width (100)
			change_actions.extend (agent on_text_change)
		end

feature -- Status report

	is_valid: BOOLEAN is
			-- Are contents of `Current' valid?
		local
			t: STRING
		do
			t := text
			Result := not t.is_empty and then not is_keyword (t)
		end

feature {NONE} -- Implementation

	on_text_change is
		local
			t: STRING
		do
			t := text
			if not t.is_empty then
				if is_keyword (t) then
					set_foreground_color (Blue)
				elseif is_defined (t) then
					set_foreground_color (Red)
				else
					set_foreground_color (Black)
				end
			end
		end

	is_defined (a_string: STRING): BOOLEAN is
			-- Is `a_string' already defined in current class?
		require
			a_string_not_void: a_string /= Void
		do
				-- FIXME: Check that `a_string' is not already defined in current class.
			Result := False
		end

	is_keyword (a_string: STRING): BOOLEAN is
			-- Is `a_string' an Eiffel keyword?
		require
			a_string_not_void: a_string /= Void
		local
			s: STRING
		do
			s := a_string.as_lower
			Result :=
				s.is_equal ("alias") or
				s.is_equal ("all") or
				s.is_equal ("and") or
				s.is_equal ("as") or
				s.is_equal ("assign") or
				s.is_equal ("bit") or
				s.is_equal ("check") or
				s.is_equal ("class") or
				s.is_equal ("create") or
				s.is_equal ("creation") or
				s.is_equal ("current") or
				s.is_equal ("debug") or
				s.is_equal ("deferred") or
				s.is_equal ("do") or
				s.is_equal ("else") or
				s.is_equal ("elseif") or
				s.is_equal ("end") or
				s.is_equal ("ensure") or
				s.is_equal ("expanded") or
				s.is_equal ("export") or
				s.is_equal ("external") or
				s.is_equal ("false") or
				s.is_equal ("feature") or
				s.is_equal ("from") or
				s.is_equal ("frozen") or
				s.is_equal ("if") or
				s.is_equal ("implies") or
				s.is_equal ("indexing") or
				s.is_equal ("infix") or
				s.is_equal ("inherit") or
				s.is_equal ("inspect") or
				s.is_equal ("invariant") or
				s.is_equal ("is") or
				s.is_equal ("like") or
				s.is_equal ("local") or
				s.is_equal ("loop") or
				s.is_equal ("not") or
				s.is_equal ("obsolete") or
				s.is_equal ("old") or
				s.is_equal ("once") or
				s.is_equal ("or") or
				s.is_equal ("precursor") or
				s.is_equal ("prefix") or
				s.is_equal ("redefine") or
				s.is_equal ("rename") or
				s.is_equal ("require") or
				s.is_equal ("rescue") or
				s.is_equal ("result") or
				s.is_equal ("retry") or
				s.is_equal ("select") or
				s.is_equal ("separate") or
				s.is_equal ("strip") or
				s.is_equal ("then") or
				s.is_equal ("true") or
				s.is_equal ("undefine") or
				s.is_equal ("unique") or
				s.is_equal ("until") or
				s.is_equal ("variant") or
				s.is_equal ("when") or
				s.is_equal ("xor")
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

end -- class EB_FEATURE_NAME_EDIT
