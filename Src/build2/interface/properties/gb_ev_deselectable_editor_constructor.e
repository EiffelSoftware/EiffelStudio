indexing
	description: "Builds an attribute editor for modification of objects of type EV_DESELECTABLE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_DESELECTABLE_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_DESELECTABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_DESELECTABLE"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			first_object: EV_DESELECTABLE
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)
			first_object := objects.first
			create check_button.make_with_text (gb_ev_deselectable_is_selected)
			check_button.set_tooltip (gb_ev_deselectable_is_selected_tooltip)
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_selected)
			check_button.select_actions.extend (agent update_editors)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.is_selected then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end
		
	set_up_user_events (actual_object: GB_OBJECT; vision2_object, an_object: like ev_type) is
			-- Add events necessary for `vision2_object'.
		local
			widget: EV_WIDGET
		do
				--| For now, just deal with widgets. At some point items may be supported also.
			user_event_widget := vision2_object
			widget ?= vision2_object
			check
				we_are_dealing_with_a_widget: widget /= Void
			end
			set_object (actual_object)
			objects.extend (an_object)
			objects.extend (vision2_object)
			widget.pointer_button_release_actions.force_extend (agent start_timer)
			widget.key_release_actions.force_extend (agent start_timer)
		end
		
	has_user_events: BOOLEAN is True
		-- Does `Current' have user events which must be set?
		
	start_timer is
			-- Start a timer which is used to delay execution of `check_state'
			-- until after the staate has changed.
		local
			timer: EV_TIMEOUT
		do
			create timer.make_with_interval (10)
			timer.actions.extend (agent check_state)
			timer.actions.extend (agent timer.destroy)
		end
		
	check_state is
			--  Check state of `user_event_widget' and update first object in response.
		require
			widget_not_void: user_event_widget /= Void
		do
			if user_event_widget.is_selected then
				for_first_object (agent {EV_DESELECTABLE}.enable_select)
				update_editors
			else
				for_all_objects (agent {EV_DESELECTABLE}.disable_select)
				update_editors
			end
		end
			
	user_event_widget: like ev_type	

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to do here.
		end

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_selected is
			-- Update sensitive state.
		do
			if check_button.is_selected then
				for_all_objects (agent {EV_DESELECTABLE}.enable_select)
			else
				for_all_objects (agent {EV_DESELECTABLE}.disable_select)
			end
		end

	-- Constants for XML
	
	is_selected_string: STRING is "Is_selected";

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


end -- class GB_EV_DESELECTABLE_EDITOR_CONSTRUCTOR
