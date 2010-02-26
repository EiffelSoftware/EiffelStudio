note
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
			is_function,
			initialize,
			body_code
		end

	EB_QUERY_EDITOR
		undefine
			initialize
		redefine
			is_function
		end

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor {EB_ROUTINE_EDITOR}
			add_setter
		end

	routine_is_part: EV_HORIZONTAL_BOX
			-- Box with `add_argument_button' and "): ".
		local
			c: EV_CELL
			l_vbox: EV_VERTICAL_BOX
		do
			create Result
			create l_vbox
			l_vbox.extend (add_argument_button)
			l_vbox.disable_item_expand (l_vbox.last)
			l_vbox.extend (create {EV_CELL})
			Result.extend (l_vbox)
			Result.disable_item_expand (Result.last)


			create l_vbox
			l_vbox.extend (new_label ("): "))
			l_vbox.disable_item_expand (l_vbox.last)
			l_vbox.extend (create {EV_CELL})
			Result.extend (l_vbox)
			Result.disable_item_expand (Result.last)

			create l_vbox
			create type_selector
			l_vbox.extend (type_selector)
			l_vbox.disable_item_expand (l_vbox.last)
			l_vbox.extend (create {EV_CELL})
			Result.extend (l_vbox)
			Result.disable_item_expand (Result.last)
			create c
			extend (c)
			disable_item_expand (c)
		end

feature -- Access

	code: STRING
			-- Current text of the feature in the wizard.
		local
			l_arguments_code: STRING
		do
			create Result.make (100)
			Result.append ("%T" + feature_name_field.text)
			l_arguments_code := arguments_code
			if
				l_arguments_code /= Void and then not l_arguments_code.is_empty
			then
				Result.append (" (" + l_arguments_code + ")")
			end
			 Result.append (": " + type_selector.code)
			if assigner_check_box.is_selected then
				Result.append (" assign " + setter_text.text)
			end
			Result.append ("%N")
			Result.append (comments_code)
			Result.append (routine_code)
		end

feature {NONE} -- Implementation

	body_code: STRING
			-- Code for routine body.
		do
			Result := Precursor
			if (once_button.is_selected or do_button.is_selected) and then type_selector.detachable_check_box.is_sensitive and then not type_selector.detachable_check_box.is_selected then
				Result.append ("%T%T%TResult := ({like " + feature_name_field.text + "}).default -- Remove line when function is implemented.%N")
			end
		end

feature -- Status report

	is_function: BOOLEAN = True
			-- Is `Current' a function editor?

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class EB_FUNCTION_EDITOR
