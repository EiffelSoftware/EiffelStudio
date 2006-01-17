indexing
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

feature -- Access

	code: STRING is
			-- Current text of the feature in the wizard.
		deferred
		end

	name_number: INTEGER
			-- Number to append to initial feature name.

feature -- Element change

	set_name_number (a_number: INTEGER) is
			-- Assign `a_number' to `name_number'.
		deferred
		ensure
			a_number_assigned: name_number = a_number
		end

feature -- Status report

	valid_content: BOOLEAN is
			-- Is user input valid for code generation?
		deferred
		end

	is_procedure: BOOLEAN is
			-- Is `Current' a procedure editor?
		do
		end

	is_function: BOOLEAN is
			-- Is `Current' a function editor?
		do
		end

	is_attribute: BOOLEAN is
			-- Is `Current' an attribute editor?
		do
		end

feature {NONE} -- Implementation

	comments_code: STRING is
			-- Formatted Eiffel comments.
		local
			l_text: STRING
		do
			l_text := comment_field.text
			if not l_text.is_empty then
				create Result.make (7 + l_text.count)
				Result.append_character ('%T')
				Result.append_character ('%T')
				Result.append_character ('%T')
				Result.append_character ('-')
				Result.append_character ('-')
				Result.append_character (' ')
				Result.append (l_text)
				Result.append_character ('%N')
			else
				create Result.make_empty
			end
		end

	add_label (a_text: STRING; ind: INTEGER) is
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

	add_indented (a_widget: EV_WIDGET; ind: INTEGER; enable_resizing: BOOLEAN) is
			-- Add `a_widget' to `Current', indented.
		local
			hb: EV_HORIZONTAL_BOX
			tab: EV_CELL
		do
			create hb
			tab := new_tab (ind)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			hb.extend (a_widget)
			extend (hb)
			if not enable_resizing then
				disable_item_expand (hb)
			end
		end

	add_comment_field is
			-- Add `comment_field' to `Current'.
		local
			hb: EV_HORIZONTAL_BOX
			tab: EV_CELL
		do
			create hb
			tab := new_tab (3)
			hb.extend (tab)
			hb.disable_item_expand (tab)
			hb.extend (new_label ("-- "))
			hb.disable_item_expand (hb.last)
			create comment_field
			hb.extend (comment_field)
			extend (hb)
		end

feature -- Adaptation

	adapt (other: EB_FEATURE_EDITOR) is
			-- Set with `other'.
		local
			tmpstr: STRING
		do
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

feature {EB_FEATURE_EDITOR, EB_FEATURE_COMPOSITION_WIZARD} -- Access

	feature_clause_selector: EB_FEATURE_CLAUSE_SELECTOR

	feature_name_field: EB_FEATURE_NAME_EDIT

	comment_field: EV_TEXT_FIELD

feature {EV_ANY} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := True
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

end -- class EB_FEATURE_EDITOR
