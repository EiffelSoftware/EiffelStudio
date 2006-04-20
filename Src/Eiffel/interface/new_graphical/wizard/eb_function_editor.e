indexing
	description:
		"Wizard to create features and insert them in a specific%N%
		%feature clause."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FUNCTION_EDITOR

inherit
	EB_ROUTINE_EDITOR
		undefine
			adapt
		redefine
			is_function
		end

	EB_QUERY_EDITOR
		undefine
			initialize
		redefine
			is_function,
			enable_expanded_needed
		end

feature {NONE} -- Initialization

	routine_is_part: EV_HORIZONTAL_BOX is
			-- Box with `add_argument_button' and "): is".
		local
			c: EV_CELL
		do
			create Result
			Result.extend (add_argument_button)
			Result.disable_item_expand (Result.last)
			Result.extend (new_label ("): "))
			Result.disable_item_expand (Result.last)
			create type_selector
			Result.extend (type_selector)
			Result.extend (new_label (" is"))
			Result.disable_item_expand (Result.last)
			create c
			extend (c)
			disable_item_expand (c)
		end

feature -- Access

	code: STRING is
			-- Current text of the feature in the wizard.
		do
			create Result.make (100)
			Result.append ("%T" + feature_name_field.text + arguments_code + ": " + type_selector.code + " is%N")
			Result.append (comments_code)
			Result.append (routine_code)
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		do
		end

	is_function: BOOLEAN is True
			-- Is `Current' a function editor?

feature {EB_QUERY_COMPOSITION_WIZARD} -- Status setting

	enable_expanded_needed is
			-- Set `expanded_needed' to `True'.
		local
			hb_type: EV_HORIZONTAL_BOX
		do
			Precursor
			hb_type ?= type_selector.parent
			check hb_type /= Void end
			hb_type.prune (hb_type.last)
			hb_type.prune (hb_type.last)
			hb_type.extend (new_label ("expanded "))
			hb_type.disable_item_expand (hb_type.last)
			hb_type.extend (type_selector)
			hb_type.extend (new_label (" is"))
			hb_type.disable_item_expand (hb_type.last)
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

end -- class EB_FUNCTION_EDITOR
