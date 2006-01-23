indexing
	description: "Objects that represent a naming dialog"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_NAMER_DIALOG

inherit
	EV_DIALOG
		export
			{NONE} all
			{ANY} show_modal_to_window
		redefine
			initialize
		end
		
	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
	
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_NAMING_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create,
	make_with_names_and_prompts

feature -- Initialization
		
	make_with_names_and_prompts (names: ARRAYED_LIST [STRING]; an_initial_text, a_title, an_invalid_message: STRING) is
			-- Create `Current' and assign `names' to `all_existing_names' which will be non permitted values for entry.
			-- Display `a_title' as title of `Current', use `an_intial_text' as initial text in text field. `an_invalid_message'
			-- will be displayed when the entry is not permitted.
		do
			default_create
			all_existing_names := names
			all_existing_names.compare_objects
			name_field.set_text (unique_name (names, an_initial_text))
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
			set_title (a_title)
			initial_text := an_initial_text
			invalid_message := an_invalid_message
		end
		
	initialize is
			-- Initialize `Current'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			accept_button, cancel_button: EV_BUTTON
		do
			Precursor {EV_DIALOG}
			create name_field
			create accept_button.make_with_text ("OK")
			create cancel_button.make_with_text ("Cancel")
			create vertical_box
			create horizontal_box
			extend (vertical_box)
			vertical_box.extend (name_field)
			vertical_box.extend (horizontal_box)
			horizontal_box.set_padding_width (default_padding_size)
			horizontal_box.set_border_width (default_border_size)
			set_default_size_for_button (accept_button)
			set_default_size_for_button (cancel_button)
			horizontal_box.extend (accept_button)
			horizontal_box.extend (cancel_button)
			set_default_push_button (accept_button)
			accept_button.select_actions.extend (agent hide_and_set)
			cancel_button.select_actions.extend (agent hide)
			show_actions.extend (agent name_field.set_focus)
				-- We must never return a void, name.
			name := ""
		end
		
	set_name (a_name: STRING) is
			-- Assign `a_name' to `name'.
		do
			name := a_name
			name_field.set_text (name)
		end
		
	name: STRING
		-- The name currently represented by `Current'.
		
feature {NONE} -- Implementation

	initial_text: STRING
		-- Text displayed at start.
		
	invalid_message: STRING
		-- Message displayed if `text' not valid.
	
	hide_and_set is
			-- Hide `Current' and set `name'.
		local
			warning: EV_WARNING_DIALOG
			temp_string: STRING
		do
				-- Components use the same naming convention
				-- as class names.
			if valid_class_name (name_field.text) then
				temp_string := name_field.text
				temp_string.to_lower
				if all_existing_names.has (temp_string) then
					create warning.make_with_text ("'" + name_field.text + "'" + invalid_message)
					warning.show_modal_to_window (Current)
				else
					hide
					name := name_field.text
				end
			else
				create warning.make_with_text ("'" + name_field.text + "'" + invalid_message)
				warning.show_modal_to_window (Current)
			end
		end
		
	name_field: EV_TEXT_FIELD
		-- The entry field for new name.
		
	all_existing_names: ARRAYED_LIST [STRING];
		-- All named components currently in the system.
		-- We must ensure that a new name entered by the user
		-- is not identical to a member of this list.
	
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


end -- class GB_NAMER_DIALOG
