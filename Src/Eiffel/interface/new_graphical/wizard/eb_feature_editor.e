note
	description: "Component to let the user create features."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FEATURE_EDITOR

inherit
	EV_VERTICAL_BOX
		redefine
			is_in_default_state
		end

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, is_equal, copy
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

feature -- Access

	code: STRING_32
			-- Current text of the feature in the wizard.
		deferred
		end

	arguments_code: STRING_32
			-- Arguments needed for feature if any.
		deferred
		end

	name_number: INTEGER
			-- Number to append to initial feature name.

feature -- Access

	type: STRING_32
			-- Full type as string.
		deferred
		end

	client_type: ES_CLASS
			-- Client type of `type'

	supplier_type: ES_CLASS
			-- Supplier type.

feature -- Element change

	set_client_type (a_type: ES_CLASS)
			-- Set content of `client_type' to `a_type'.
		do
			client_type := a_type
			if a_type /= Void then
				feature_clause_selector.export_field.extend (create {EV_LIST_ITEM}.make_with_text (a_type.name_32))
			end
		end

	set_supplier_type (a_type: ES_CLASS)
			-- Set content of `supplier_type' to `a_type'.
		do
			supplier_type := a_type
			if a_type /= Void and then a_type /= client_type then
				feature_clause_selector.export_field.extend (create {EV_LIST_ITEM}.make_with_text (a_type.name_32))
			end
		end

	set_type (a_type: STRING_32)
			-- Set content of `type_field' to `a_type'.
		deferred
		end

feature -- Element change

	set_name_number (a_number: INTEGER)
			-- Assign `a_number' to `name_number'.
		deferred
		ensure
			a_number_assigned: name_number = a_number
		end

feature -- Status report

	valid_content: BOOLEAN
			-- Is user input valid for code generation?
		do
			if feature_name_field /= Void then
				Result := feature_name_field.is_valid
			else
				Result := True
			end
		end

	is_procedure: BOOLEAN
			-- Is `Current' a procedure editor?
		do
		end

	is_function: BOOLEAN
			-- Is `Current' a function editor?
		do
		end

	is_attribute: BOOLEAN
			-- Is `Current' an attribute editor?
		do
		end

feature -- Error

	show_error (a_parent_window: EV_WINDOW)
			-- Check that name class_name is a valid class name.
			-- (export status {NONE})
		require
			not_valid: not valid_content
			a_parent_window_not_void: a_parent_window /= Void
			a_parent_window_not_destroyed: not a_parent_window.is_destroyed
		do
			check
				field_not_void: feature_name_field /= Void
				field_not_destroyed: not feature_name_field.is_destroyed
			end
			prompts.show_error_prompt (warning_messages.w_invalid_feature_name (feature_name_field.text), a_parent_window, Void)
		end

feature {NONE} -- Implementation

	comments_code: STRING_32
			-- Formatted Eiffel comments.
		local
			l_text: STRING_32
		do
			l_text := comment_field.text
			create Result.make (7 + l_text.count)
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_character ('%T')
			Result.append_character ('-')
			Result.append_character ('-')
			Result.append_character (' ')
			if not l_text.is_empty then
				Result.append (l_text)
			else
				Result.append_character ('`')
				Result.append (feature_name_field.text)
				Result.append_character (''')
			end
			Result.append_character ('%N')
		end

	add_label (a_text: STRING_32; ind: INTEGER)
			-- Create new label with `a_text'.
		local
			hb: EV_HORIZONTAL_BOX
			l: EV_LABEL
			tab: EV_CELL
		do
			create hb
			tab := new_tab (ind)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			l := new_label (a_text)
			l.align_text_left
			hb.extend (l)
			extend (hb)
			disable_item_expand (hb)
		end

	add_indented (a_widget: EV_WIDGET; ind: INTEGER; enable_resizing: BOOLEAN)
			-- Add `a_widget' to `Current', indented.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			tab: EV_CELL
		do
			create hb
			tab := new_tab (ind)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			hb.extend (a_widget)

			create vb
			vb.extend (hb)
			vb.disable_item_expand (vb.last)
			vb.extend (create {EV_CELL})

			extend (vb)
			if not enable_resizing then
				vb.disable_item_expand (hb)
			end
		end

	add_comment_field
			-- Add `comment_field' to `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			tab: EV_CELL
		do
			create vb

			create hb
			tab := new_tab (3)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			hb.extend (new_label ("-- "))
			hb.disable_item_expand (hb.last)
			create comment_field
			hb.extend (comment_field)

			vb.extend (hb)
			vb.disable_item_expand (vb.last)
			vb.extend (create {EV_CELL})

			extend (vb)
		end

feature -- Adaptation

	adapt (other: EB_FEATURE_EDITOR)
			-- Set with `other'.
		local
			tmpstr: STRING_32
		do
			set_client_type (other.client_type)
			set_supplier_type (other.supplier_type)
			set_type (other.type)

			feature_clause_selector.export_field.set_text (other.feature_clause_selector.export_field.text)
			feature_clause_selector.comment_field.set_text (other.feature_clause_selector.comment_field.text)

			tmpstr := other.feature_name_field.text
			if tmpstr /= Void and then not tmpstr.is_empty then
				feature_name_field.set_text (tmpstr)
			else
				feature_name_field.remove_text
			end
			tmpstr := other.comment_field.text
			if tmpstr /= Void and then not tmpstr.is_empty then
				comment_field.set_text (tmpstr)
			else
				comment_field.remove_text
			end
		end

feature {EB_FEATURE_EDITOR, EB_FEATURE_COMPOSITION_WIZARD, EB_INHERITANCE_DIALOG} -- Access

	feature_clause_selector: EB_FEATURE_CLAUSE_SELECTOR

	feature_name_field: EB_FEATURE_NAME_EDIT

	comment_field: EV_TEXT_FIELD

	syntax_checker: EIFFEL_SYNTAX_CHECKER
			-- Syntax checking.
		once
			create Result
		end

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state.
		do
			Result := True
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

end -- class EB_FEATURE_EDITOR
