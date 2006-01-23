indexing
	description: "Builds an attribute editor for modification of objects of type EV_BOX."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_BOX_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	INTERNAL
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_BOX
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_BOX"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			second: like ev_type
			check_button: EV_CHECK_BUTTON
			counter: INTEGER
			first_item, second_item: EV_WIDGET
			label: EV_LABEL
		do
			create check_buttons.make (0)
			create Result.make_with_components (components)
			initialize_attribute_editor (result)
				-- We need the child of the display objects here,
				-- not the actual object itself.
			second := objects @ (2).item
			
			create is_homogeneous_check.make_with_text ("Is_homogeneous?")
			Result.extend (is_homogeneous_check)
			is_homogeneous_check.select_actions.extend (agent update_homogeneous)
			is_homogeneous_check.select_actions.extend (agent update_editors)
			
			create padding_entry.make (Current, Result, padding_string, gb_ev_box_padding_width, gb_ev_box_padding_width_tooltip,
				agent set_padding (?), agent valid_input (?), components)
			create border_entry.make (Current, Result, border_string, gb_ev_box_border_width, gb_ev_box_border_width_tooltip,
				agent set_border (?), agent valid_input (?), components)

				-- We only add the is_expandable label if there are children
			if not first.is_empty then
				create label.make_with_text ("Is_item_expanded?")
				Result.extend (label)
				Result.disable_item_expand (label)
				from
					counter := 1
				until
					counter > first.count
				loop
					first_item := first.i_th (counter)
					if second /= Void then
						second_item := second.i_th (counter)	
					end
					create check_button.make_with_text (class_name (first_item))
					check_button.set_pebble_function (agent retrieve_pebble (first_item))
					check_buttons.force (check_button)
					check_button.select_actions.extend (agent update_widget_expanded (check_button, counter))
					check_button.select_actions.extend (agent update_editors)
					Result.extend (check_button)
					Result.disable_item_expand (check_button)
					counter := counter + 1
				end
			end
			
			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check
				counts_match: first.count = check_buttons.count
			end
			is_homogeneous_check.select_actions.block

			if first.is_homogeneous then
				is_homogeneous_check.enable_select
			else
				is_homogeneous_check.disable_select
			end
			border_entry.update_constant_display (first.border_width.out)
			padding_entry.update_constant_display (first.padding_width.out)
			
			from
				check_buttons.start
			until
				check_buttons.off
			loop
				check_buttons.item.select_actions.block
				if first.is_item_expanded (first @ check_buttons.index) then
					check_buttons.item.enable_select
				else
					check_buttons.item.disable_select
				end
				check_buttons.item.select_actions.resume
				check_buttons.forth
			end			
			is_homogeneous_check.select_actions.resume
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			execution_agents.put (agent set_padding (?), Padding_string)
			validate_agents.put (agent valid_input (?), Padding_string)
			execution_agents.put (agent set_border (?), Border_string)
			validate_agents.put (agent valid_input (?), Border_string)
		end
		
	update_widget_expanded (check_button: EV_CHECK_BUTTON; index: INTEGER) is
			-- Change the expanded status of `index' item based on status of `check_button'.
		require
			check_button_not_void: check_button /= Void
			index_valid: object.children /= Void implies index >= 1 and index <= object.children.count
		do
			actual_update_widget_expanded (object, check_button.is_selected, index)
			for_all_instance_referers (object, agent actual_update_widget_expanded (?, check_button.is_selected, index))
			enable_project_modified
		end
		
	actual_update_widget_expanded (an_object: GB_OBJECT; is_expanded: BOOLEAN; index: INTEGER) is
			-- Updated expanded state of item` index' within `an_object' to reflect `is_expanded'.
		require
			an_object_not_void: an_object /= Void
			valid_index : an_object.children /= Void implies index >= 1 and index <= an_object.children.count
		local
			box: EV_BOX
		do
			box ?= an_object.object
			check
				object_was_box: box /= Void
			end
			if is_expanded then
				box.enable_item_expand (box.i_th (index))
			else
				box.disable_item_expand (box.i_th (index))
			end
			box ?= an_object.real_display_object
			if box /= Void then
				if is_expanded then
					box.enable_item_expand (box.i_th (index))
				else
					box.disable_item_expand (box.i_th (index))
				end
			end
			if an_object.children /= Void then
				update_object_expansion (an_object.children.i_th (index), is_expanded)
			end
		end

	update_object_expansion (child_object: GB_OBJECT is_expanded: BOOLEAN) is
			-- Modify expanded state of `index' child of `object', based on
			-- `is_expanded'.
		do
			if is_expanded then
				child_object.enable_expanded_in_box
			else
				child_object.disable_expanded_in_box
			end
		end

	update_homogeneous is
			-- Update homogeneous state of items in `objects' depending on
			-- state of `is_homogeneous_check'.
		do
			if is_homogeneous_check.is_selected then
				for_all_objects (agent {EV_BOX}.enable_homogeneous)
			else
				for_all_objects (agent {EV_BOX}.disable_homogeneous)
			end
		end

	set_padding (value: INTEGER) is
			-- Update property `padding' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_all_objects (agent {EV_BOX}.set_padding_width (value))
			update_editors
		end
		
	valid_input (value: INTEGER): BOOLEAN is
			-- Is `value' a valid padding?
		do
			Result := value >= 0
		end
		
	set_border (value: INTEGER) is
			-- Update property `border' on all items in `objects'.
		require
			first_not_void: first /= Void
		do
			for_all_objects (agent {EV_BOX}.set_border_width (value))
			update_editors
		end

	is_homogeneous_check: EV_CHECK_BUTTON

	border_entry, padding_entry: GB_INTEGER_INPUT_FIELD
	
	Is_homogeneous_string: STRING is "Is_homogeneous"
	Padding_string: STRING is "Padding"
	Border_string: STRING is "Border"
	Is_item_expanded_string: STRING is "Is_item_expanded"
	
	check_buttons: ARRAYED_LIST [EV_CHECK_BUTTON];
		-- All check buttons created to handle `disable_item_expand'.
		
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


end -- class GB_EV_BOX_EDITOR_CONSTRUCTOR
