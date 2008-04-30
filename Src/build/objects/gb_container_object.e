indexing
	description: "GB_OBJECT representing an EV_CONTAINER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_CONTAINER_OBJECT

inherit
	GB_PARENT_OBJECT
		export
			{ANY} dynamic_type, dynamic_type_from_string,
				type_conforms_to, is_valid_type_string
		redefine
			object, display_object, is_full,
			build_display_object, delete,
			accepts_child, connect_display_object_events,
			unconnect_display_object_pick_events,
			unconnect_display_object_drop_events,
			update_representations_for_name_or_type_change,
			real_display_object
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Access

	object: EV_CONTAINER
		-- A representation of `Current' used
		-- in the display_window.

	display_object: GB_DISPLAY_OBJECT
		-- A representation of `Current' used
		-- in the builder_window

feature -- Basic operation

	is_full: BOOLEAN is
			-- Is `Current' full?
		do
			Result := object.full
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_COMMAND_ADD_OBJECT} -- Basic operation

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
			-- This is redefined in descendents as insertion at position `position'
			-- is different for each type of container.
		require else
			position_valid: not type_conforms_to (dynamic_type (Current), dynamic_type_from_string ("GB_SPLIT_AREA_OBJECT")) implies position >=1 and position <= object.count + 1
		do
		ensure then
				-- For an EV_TABLE, Count is not the the number of widgets, `widget_count' is the correct measure of this.
			one_item_added_to_object: not type_conforms_to (dynamic_type (object), dynamic_type_from_string (Ev_table_string)) and
			not type_conforms_to (dynamic_type (an_object), dynamic_type_from_string ("GB_MENU_BAR_OBJECT")) implies object.count = old object.count + 1
			one_item_added_to_display_object: not type_conforms_to (dynamic_type (object), dynamic_type_from_string (Ev_table_string)) and
			not type_conforms_to (dynamic_type (an_object), dynamic_type_from_string ("GB_MENU_BAR_OBJECT")) implies display_object.child.count = old display_object.child.count + 1
--FIXME			one_item_added_to_layout_item: not old layout_item.has (an_object.layout_item) implies layout_item.count = old layout_item.count + 1
		end

feature {GB_OBJECT} -- Delete

	delete is
			-- Perform any necessary processing for
			-- a deletion of `Current' from the system.
			-- We must unmerge any radio button groups
			-- that are being deleted.
		local
			list: ARRAYED_LIST [EV_CONTAINER]
		do
			-- We must unmerge any radio groupings of the current container.
			list := object.merged_radio_button_groups
			if list /= Void then
				from
					list.start
				until
					list.off
				loop
					(list.item).unmerge_radio_button_groups (object)
					list.forth
				end
			end
			list := display_object.child.merged_radio_button_groups
			if list /= Void then
				from
					list.start
				until
					list.off
				loop
					(list.item).unmerge_radio_button_groups (display_object.child)
					list.forth
				end
			end
		end

feature {GB_OBJECT_HANDLER, GB_OBJECT, GB_TYPE_SELECTOR_ITEM, GB_COMMAND_ADD_OBJECT, GB_PASTE_OBJECT_COMMAND} -- Access

	accepts_child (a_type: STRING): BOOLEAN is
			-- Does `Current' accept `an_object'?
			-- Only widgets are accepted.
		do
			if type_conforms_to (dynamic_type_from_string (a_type), dynamic_type_from_string (Ev_widget_string))
				and not type_conforms_to (dynamic_type_from_string (a_type), dynamic_type_from_string (Ev_window_string)) then
				Result := True
			end
		end

feature {NONE} -- Implementation

	build_display_object is
			-- Build `display_object' from type of `Current'
			-- and hence `object'.
		local
			widget: like object
		do
			widget ?= vision2_object_from_type (type)
			check
				widget_not_void: widget /= Void
			end
			create display_object.make_with_name_and_child (type, widget)
			connect_display_object_events
		end

	connect_display_object_events is
			-- Connect events to `display_object' to permit interactive building.
		do
			Precursor {GB_PARENT_OBJECT}
				-- Firstly remove any previous events as if the widget changes
				-- between a representation and flat, `connect_display_object_events' may be called
				-- multiple times.
			display_object.child.drop_actions.wipe_out

				-- Now connect all events.
			display_object.child.set_pebble_function (agent retrieve_pebble)
			display_object.child.drop_actions.extend (agent handle_object_drop (?))
			display_object.child.drop_actions.set_veto_pebble_function (agent can_add_child (?))
			display_object.child.drop_actions.extend (agent set_color)
		end

	unconnect_display_object_pick_events is
			-- Unconnect pick events from `display_object' to restrict interactive building.
			-- For example we do not permit a user to modify the structure if the object is
			-- part of a representation of a top level object.
		do
			Precursor {GB_PARENT_OBJECT}
			display_object.child.remove_pebble
		end

	unconnect_display_object_drop_events is
			-- Unconnect drop events from `display_object' to restrict interactive building.
			-- For example we do not permit a user to modify the structure if the object is
			-- part of a representation of a top level object.
		do
			Precursor {GB_PARENT_OBJECT}
			display_object.child.drop_actions.wipe_out
			display_object.child.drop_actions.set_veto_pebble_function (Void)
		end

feature {GB_COMMAND_NAME_CHANGE, GB_OBJECT_HANDLER, GB_OBJECT, GB_COMMAND_CHANGE_TYPE, GB_COMMAND_CONVERT_TO_TOP_LEVEL} -- Basic operation

	update_representations_for_name_or_type_change is
			-- Update all representations of `Current' to reflect a change
			-- of name or type.
		do
			Precursor {GB_PARENT_OBJECT}
			if is_instance_of_top_level_object then
				display_object.set_text (components.object_handler.deep_object_from_id (associated_top_level_object).name.as_upper)
			else
				display_object.set_text (type)
			end
		end

feature {GB_EV_EDITOR_CONSTRUCTOR} -- Implementation

	real_display_object: EV_ANY is
			-- `Result' is widget associated with `display_object'.
		do
			Result := display_object.child
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


end -- class GB_CONTAINER_OBJECT
