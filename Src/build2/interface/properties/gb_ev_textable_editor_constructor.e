indexing
	description: "Builds an attribute editor for modification of objects of type EV_TEXTABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		redefine
			ev_type
		end
	
	GB_CONSTANTS

feature -- Access

	ev_type: EV_TEXTABLE
		-- Vision2 type represented by `Current'.

	type: STRING is "EV_TEXTABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			line_entry_type: BOOLEAN
		do
			create Result.make_with_components (components)
			
			if is_instance_of (first, dynamic_type_from_string ("EV_TEXT")) or is_instance_of (first, dynamic_type_from_string ("EV_LABEL")) then
				line_entry_type := multiple_line_entry	
			else
				line_entry_type := single_line_entry
			end
			initialize_attribute_editor (Result)
			create text_entry.make (Current, Result, text_string, Gb_ev_textable_text, Gb_ev_textable_text_tooltip,
				agent set_text (?), agent validate_true (?), line_entry_type, components)
				
				-- Menu separators have the textable features not exported, to prevent
				-- calling, so if the obejct represented by `Current' is a menu separator,
				-- we must hide it, to prevent text modification. It must be created, and hidden
				-- to fulfill postconditions on this routine.
			if is_instance_of (first, dynamic_type_from_string ("EV_MENU_SEPARATOR")) then
				text_entry.hide
			end
				
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		ensure
			text_entry_not_void: text_entry /= Void
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent set_text (?), text_string)
			validate_agents.put (agent validate_true (?), text_string)
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			text_entry.update_constant_display (first.text)
		end
		
	set_up_user_events (actual_object: GB_OBJECT; vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
		do
			user_event_widget ?= vision2_object
			if user_event_widget /= Void then
				set_object (actual_object)
				objects.extend (an_object)
				objects.extend (vision2_object)
				user_event_widget.change_actions.force_extend (agent start_timer)
			end
		end

	has_user_events: BOOLEAN is True
		-- Does `Current' have user events which must be set?
	
	start_timer is
			-- Start a timer, which is used as a delay between an event begin
			-- received by `user_event_widget' and `check_state'.
		local
			timer: EV_TIMEOUT
		do
			create timer.make_with_interval (10)
			timer.actions.extend (agent check_state)
			timer.actions.extend (agent timer.destroy)
		end
		
	check_state is
			-- Update the display window representation of
			-- the gauge, to reflect change from user.
		do
			if user_event_widget.has_focus and then not user_event_widget.text.is_equal (objects.first.text) then
				for_first_object (agent {EV_TEXTABLE}.set_text (user_event_widget.text))
				update_editors
				enable_project_modified
			end
		end
		
	user_event_widget: EV_TEXT_COMPONENT
		-- Used to handle the events on the builder window.

	set_text (a_text: STRING) is
			-- Assign `text' of `text_entry' to all objects.
		do
			for_all_objects (agent {EV_TEXTABLE}.set_text (a_text))
			update_editors
		end
		
	text_entry: GB_STRING_INPUT_FIELD
		-- Input field for text.

	Text_string: STRING is "Text";
	
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


end -- class GB_EV_TEXTABLE_EDITOR_CONSTRUCTOR
