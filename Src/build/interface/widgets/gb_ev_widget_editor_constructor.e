indexing
	description: "Objects that provide a new attribute editor for EV_WIDGET properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Access

	components: GB_INTERNAL_COMPONENTS is
			-- Access to a set of internal components for an EiffelBuild instance.
		deferred
		end

	ev_type: EV_WIDGET

	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		once
			Result := Ev_widget_string
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `first'.
		do
			if first.is_show_requested and not is_show_requested_check_button.is_selected then
				is_show_requested_check_button.select_actions.block
				is_show_requested_check_button.enable_select
				is_show_requested_check_button.select_actions.resume
			end

			minimum_width_entry.update_constant_display (first.minimum_width.out)
			if first.minimum_width_set_by_user then
				reset_width_button.enable_sensitive
			else
				reset_width_button.disable_sensitive
			end
			minimum_height_entry.update_constant_display (first.minimum_height.out)
			if first.minimum_height_set_by_user then
				reset_height_button.enable_sensitive
			else
				reset_height_button.disable_sensitive
			end
		end

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			reset_pixmap: EV_PIXMAP
			tool_bar: EV_TOOL_BAR
		do
			create Result.make_with_components (components)
			initialize_attribute_editor (Result)

			create is_show_requested_check_button.make_with_text (gb_ev_widget_is_show_requested)
			is_show_requested_check_button.set_tooltip (gb_ev_widget_is_show_requested_tooltip)
			is_show_requested_check_button.select_actions.extend (agent toggle_visibility)
			is_show_requested_check_button.select_actions.extend (agent update_editors)
			if not is_instance_of (first, dynamic_type_from_string ("EV_WINDOW")) then
					-- Only show the show requested control if we are not a window.
				Result.extend (is_show_requested_check_button)
				Result.disable_item_expand (is_show_requested_check_button)
			end

			reset_pixmap := (create {GB_SHARED_PIXMAPS}).pixmap_by_name ("icon_recycle_bin_color")

			create label.make_with_text (Gb_ev_widget_minimum_width)
			Result.extend (label)
			Result.disable_item_expand (label)
			create horizontal_box
			horizontal_box.set_padding_width (object_editor_padding_width)
			create minimum_width_entry.make (Current, horizontal_box, minimum_width_string, "", gb_ev_widget_minimum_width_tooltip,
				agent set_minimum_width (?), agent valid_minimum_dimension (?), components)
			create reset_width_button
			create tool_bar
			tool_bar.extend (reset_width_button)
			reset_width_button.set_pixmap (reset_pixmap)
			reset_width_button.set_tooltip (reset_minimum_width_tooltip)
			reset_width_button.select_actions.extend (agent reset_width)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			Result.extend (horizontal_box)

			create label.make_with_text (Gb_ev_widget_minimum_height)
			Result.extend (label)
			Result.disable_item_expand (label)
			create horizontal_box
			horizontal_box.set_padding_width (object_editor_padding_width)
			create minimum_height_entry.make (Current, horizontal_box, minimum_height_string, "", gb_ev_widget_minimum_height_tooltip,
				agent set_minimum_height (?), agent valid_minimum_dimension (?), components)
			create reset_height_button
			create tool_bar
			tool_bar.extend (reset_height_button)
			reset_height_button.set_pixmap (reset_pixmap)
			reset_height_button.set_tooltip (reset_minimum_height_tooltip)
			reset_height_button.select_actions.extend (agent reset_height)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			Result.extend (horizontal_box)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do

			execution_agents.put (agent set_minimum_height (?), Minimum_height_string)
			validate_agents.put (agent valid_minimum_dimension (?), Minimum_height_string)
			execution_agents.put (agent set_minimum_width (?), Minimum_width_string)
			validate_agents.put (agent valid_minimum_dimension (?), Minimum_width_string)
		end

	toggle_visibility is
			-- Update is_displayed state.
		do
			if is_show_requested_check_button.is_selected then
				for_first_object (agent {EV_WIDGET}.show)
			else
				for_first_object (agent {EV_WIDGET}.hide)
			end
		end

	reset_width is
			-- Reset minimum width of object referenced by `Current'.
		local
			original_id: INTEGER
			constant_context: GB_CONSTANT_CONTEXT
		do
				-- Firsty remove the constant if one exists, as we are resetting
				-- the width and if we leave the constant it cannot be reset.
			constant_context := object.constants.item (type + minimum_width_string)
			if constant_context /= Void then
				constant_context.destroy
			end
			reset_width_button.disable_sensitive
				-- Although the editor will be rebuilt, doing this gives the
				-- impression of instant feedback, even if there is a small delay
				-- before rebuilding.
			original_id := components.object_handler.object_from_display_widget (first).id
				-- Store the original id so that we can restore the object afterwards.
			actual_reset_width (object)
			for_all_instance_referers (object, agent actual_reset_width)

			parent_editor.set_object (components.object_handler.object_from_id (original_id))
				-- Update `parent_editor' to reflect the change.
		end

	actual_reset_width (an_object: GB_OBJECT) is
			-- Reset `minimum_width' of `object' of `an_object'.
		require
			object_not_void: an_object /= Void
		local
			widget: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_was_widget: widget /= Void
			end
			widget.reset_minimum_width
			components.object_handler.reset_object (an_object)
		end

	reset_height is
			-- Reset minimum width of object referenced by `Current'.
		local
			original_id: INTEGER
			constant_context: GB_CONSTANT_CONTEXT
		do
				-- Firsty remove the constant if one exists, as we are resetting
				-- the height and if we leave the constant it cannot be reset.
			constant_context := object.constants.item (type + minimum_height_string)
			if constant_context /= Void then
				constant_context.destroy
			end
			reset_height_button.disable_sensitive
				-- Although the editor will be rebuilt, doing this gives the
				-- impression of instant feedback, even if there is a small delay
				-- before rebuilding.


			original_id := components.object_handler.object_from_display_widget (first).id
				-- Store the original id so that we can restore the object afterwards.

			actual_reset_height (object)
			for_all_instance_referers (object, agent actual_reset_height)
			parent_editor.set_object (components.object_handler.object_from_id (original_id))
				-- Update `parent_editor' to reflect the change.
		end

	actual_reset_height (an_object: GB_OBJECT) is
			-- Reset `minimum_height' of `object' of `an_object'.
		require
			object_not_void: an_object /= Void
		local
			widget: EV_WIDGET
		do
			widget ?= an_object.object
			check
				object_was_widget: widget /= Void
			end
			widget.reset_minimum_height
			components.object_handler.reset_object (an_object)
		end

	minimum_width_entry, minimum_height_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `minimum_width' and `minimum_height'.

	set_minimum_width (integer: INTEGER) is
			-- Update property `minimum_width' on the first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_width (integer))
			update_editors
		end

	valid_minimum_dimension (value: INTEGER): BOOLEAN is
			-- Is `value' a valid minimum_width or minimum_height?
		do
			Result := value >= 0
		end

	set_minimum_height (integer: INTEGER) is
			-- Update property `minimum_height' on first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_height (integer))
			update_editors
		end

	Minimum_width_string: STRING is "Minimum_width"
	Minimum_height_string: STRING is "Minimum_height"

	Is_show_requested_string: STRING is "Is_show_requested"

	reset_width_button, reset_height_button: EV_TOOL_BAR_BUTTON
		-- Buttons that allow you to reset the minimum sizes on objects.

	is_show_requested_check_button: EV_CHECK_BUTTON
		-- Button allowing control of a widgets visible state.

invariant
	--first.minimum_width_set_by_user implies not reset_width_button.is_sensitive else reset_button.is_sensitive
	--And other

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


end -- class GB_EV_WIDGET_EDITOR
