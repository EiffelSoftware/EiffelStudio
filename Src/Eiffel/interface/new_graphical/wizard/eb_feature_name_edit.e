note
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

	initialize
		do
			Precursor
			set_minimum_width (100)
			change_actions.extend (agent on_text_change)
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Are contents of `Current' valid?
		do
			Result := (create {EIFFEL_SYNTAX_CHECKER}).is_valid_feature_name (text)
		end

feature {NONE} -- Implementation

	on_text_change
		local
			t: STRING
		do
			t := text
			if not t.is_empty then
				if not is_valid then
					set_foreground_color (Red)
				elseif is_defined (t) then
					set_foreground_color (Red)
				else
					set_foreground_color (Black)
				end
			end
		end

	is_defined (a_string: STRING): BOOLEAN
			-- Is `a_string' already defined in current class?
		require
			a_string_not_void: a_string /= Void
		do
				-- FIXME: Check that `a_string' is not already defined in current class.
			Result := False
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

end -- class EB_FEATURE_NAME_EDIT
