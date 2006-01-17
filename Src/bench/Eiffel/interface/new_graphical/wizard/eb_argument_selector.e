indexing
	description:
		"Combobox that lets the user select a type%N%
		%If that type has generics, displays more type selectors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_SELECTOR

inherit
	EV_HORIZONTAL_BOX
		redefine
			initialize,
			is_in_default_state
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, is_equal, copy
		end

feature {NONE} -- Initialization

	initialize is
			-- Build interface.
		local
			hb: EV_HORIZONTAL_BOX
		do
			Precursor
			create hb
			create name_field
			name_field.set_minimum_width (60)
			extend (name_field)
			disable_item_expand (last)
			extend (new_label (": "))
			disable_item_expand (last)
			create type_selector
			hb.extend (type_selector)
			hb.disable_item_expand (hb.last)
			create remove_button
			remove_button.set_pixmap (Pixmaps.icon_delete_small @ 1)
			remove_button.set_minimum_size (16, 16)
			hb.extend (remove_button)
			hb.disable_item_expand (hb.last)
			hb.set_padding (Layout_constants.small_padding_size)
			extend (hb)
		end

feature -- Access

	name_field: EB_FEATURE_NAME_EDIT
			-- Argument label text box.
	
	type_selector: EB_TYPE_SELECTOR
			-- Argument type selection widget.
			
	remove_button: EV_BUTTON
			-- Button to remove `Current' from its container.
			-- Does nothing until `set_remove_procedure' gets called.

	code: STRING is
			-- Generated code.
		local
			t: STRING
		do
			t := name_field.text
			create Result.make (10)
			if not t.is_empty then
				Result.append (t)
				Result.append (": ")
				Result.append (type_selector.code)
			end
		ensure
			not_void: Result /= Void
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		local
			t: STRING
		do
			t := name_field.text
			Result := t /= Void and then not t.is_empty
		end

feature -- Status setting

	add_semicolon is
			-- Append a semicolon label at the end of `Current'.
		do
			extend (new_label (";"))
			disable_item_expand (last)
		end

	remove_semicolon is
			-- Remove the semicolon label at the end of `Current'.
		local
			lbl: EV_LABEL
		do
			lbl ?= last
			if lbl /= Void then
				prune_all (lbl)
			end
		end
		
feature -- Element change

	set_name (a_name: STRING) is
			-- Put `a_name' in `name_field'.
		do
			if a_name.is_empty then
				name_field.remove_text
			else
				name_field.set_text (a_name)
			end
		end

	set_remove_procedure (proc: PROCEDURE [ANY, TUPLE]) is
			-- Make `remove_button' call `proc'.
		require
			proc_exists: proc /= Void
		do
			remove_button.select_actions.wipe_out
			remove_button.select_actions.extend (proc)
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := (
				not is_homogeneous and
				border_width = 0 and
				padding = 0			
			)
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

end -- class EB_ARGUMENT_SELECTOR
