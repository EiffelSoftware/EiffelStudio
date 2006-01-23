indexing
	description: "Objects that allow user input of a pixmap value."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PIXMAP_INPUT_FIELD
	
inherit
	GB_INPUT_FIELD
		
create
	make
	
feature {NONE} -- Initialization

	make (any: ANY; a_parent: EV_CONTAINER; a_type, label_text, tooltip: STRING; an_execution_agent: PROCEDURE [ANY, TUPLE [EV_PIXMAP, STRING]];
		a_validate_agent: FUNCTION [ANY, TUPLE [EV_PIXMAP], BOOLEAN]; a_pixmap_agent: FUNCTION [ANY, TUPLE [], EV_PIXMAP];
		a_pixmap_path_agent: FUNCTION [ANY, TUPLE [], STRING]; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `gb_ev_any' as the client of `Current', we need this to call `update_atribute_editors'.
			-- Build widget structure into `a_parent'. Use `label_text' as the text of the label next to the text field for entry.
			-- `an_execution_agent' is to execute the setting of the attribute.
			-- `a_validate_agent' is used to query whether the current value is valid as an argument for `execution_agent'.
			-- `tooltip' is tooltip to be displayed on visible parts of control.
		require
			gb_ev_any_not_void: any /= Void
			a_parent_not_void: a_parent /= Void
			label_text_not_void_or_empty: label_text /= Void
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			tool_bar: EV_TOOL_BAR
		do
			components := a_components
			call_default_create (any)
			internal_type := a_type
			object ?= internal_gb_ev_any.object
			check
				object_not_void: object /= Void
			end
			set_padding_width (object_editor_vertical_padding_width)	
			if not label_text.is_empty then
				create label.make_with_text (label_text)
				label.align_text_left
				extend (label)
			end
			create horizontal_box
			extend (horizontal_box)
			horizontal_box.set_padding_width (object_editor_padding_width)

			create modify_button.make_with_text (select_button_text)
			create tool_bar
			tool_bar.extend (modify_button)
			modify_button.select_actions.extend (agent modify_pixmap)
			modify_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			create filler_label
			horizontal_box.extend (filler_label)
			create constants_combo_box
			horizontal_box.extend (constants_combo_box)
			constants_combo_box.hide
			create_constants_button
			create tool_bar
			tool_bar.extend (constants_button)
			constants_button.select_actions.extend (agent remove_constant)
			constants_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			create pixmap_container
			extend (pixmap_container)
			a_parent.extend (Current)

			execution_agent := an_execution_agent
			validate_agent := a_validate_agent
			return_pixmap_agent := a_pixmap_agent
			pixmap_path_agent := a_pixmap_path_agent
			populate_constants

		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
			internal_gb_ev_any_not_void: internal_gb_ev_any /= Void
		end
		
feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := pixmap_constant_type
		end

feature {GB_EV_EDITOR_CONSTRUCTOR, GB_EV_ANY} -- Implementation

	update_constant_display (a_value: EV_PIXMAP) is
			-- Update widgets and display based on state of current constant selected.
		local
			constant_context: GB_CONSTANT_CONTEXT
			list_item: EV_LIST_ITEM
			has_pixmap: BOOLEAN
			pixmap: EV_PIXMAP
			l_pixmap_path: STRING
			error_label: EV_LABEL
			blocked_list_item: EV_LIST_ITEM
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
			if constant_context /= Void then
				constants_button.select_actions.block
				constants_button.enable_select
				constants_button.select_actions.resume
				list_item := constants_combo_box.selected_item
				if list_item /= Void then
					list_item.deselect_actions.block
					blocked_list_item := list_item
				end
				enable_constant_mode

				list_item := list_item_with_matching_text (constants_combo_box, constant_context.constant.name)
				check
					list_item_not_void: list_item /= Void
				end
				list_item.select_actions.block
				list_item.enable_select
				list_item.select_actions.resume
				if blocked_list_item /= Void then
					blocked_list_item.deselect_actions.resume
				end
			else
				pixmap_path_agent.call (Void)
				l_pixmap_path := pixmap_path_agent.last_result
				return_pixmap_agent.call (Void)
				pixmap := return_pixmap_agent.last_result
				has_pixmap := pixmap /= Void
			
				constants_button.select_actions.block
				constants_button.disable_select
				disable_constant_mode
				constants_button.select_actions.resume
				if has_select_item then
					remove_select_item
				end
				if has_pixmap then
					add_pixmap_to_pixmap_container (pixmap)
					modify_button.set_text (Remove_button_text)
					modify_button.set_tooltip (remove_tooltip)
				else
					pixmap_container.wipe_out
					filler_label.wipe_out
					modify_button.set_text (Select_button_text)
					modify_button.set_tooltip (Select_tooltip)
					if l_pixmap_path /= Void then
						create error_label.make_with_text (Pixmap_missing_string)
						error_label.set_tooltip (l_pixmap_path)
						pixmap_container.extend (error_label)
						modify_button.set_text (clear_text)
						modify_button.set_tooltip (clear_tooltip)
					end
				end
			end
		end

feature {NONE} -- Implementation

	enable_constant_mode is
			-- Ensure constant entry fields are displayed.
		do
			if pixmap_container.full then
				modify_pixmap
			end
			filler_label.hide
			modify_button.parent.hide
			constants_combo_box.show
			pixmap_container.wipe_out
			filler_label.wipe_out
			if object.constants.item (internal_gb_ev_any.type + internal_type) = Void then
				if not has_select_item then
					add_select_item
				end
				constants_combo_box.first.enable_select
			end
		end
		

	disable_constant_mode is
			-- Ensure constant entry fields are hidden.
		do
			filler_label.show
			modify_button.parent.show
			constants_combo_box.hide
			constants_combo_box.remove_selection
		end
		
	modify_button: EV_TOOL_BAR_BUTTON
		-- Is either "Select" or "Remove"
		-- depending on current context.
		
	pixmap_path_string: STRING is "Pixmap_path"
	
	Remove_tooltip: STRING is "Remove pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	Select_tooltip: STRING is "Select pixmap"
		-- Tooltip on `modify_button' when able to remove pixmap.
		
	pixmap_container: EV_CELL
		-- Holds a representation of the loaded pixmap.
		
	execution_agent: PROCEDURE [ANY, TUPLE [EV_PIXMAP]]
		-- Agent to execute command associated with value entered into `Current'.
		
	validate_agent: FUNCTION [ANY, TUPLE [EV_PIXMAP], BOOLEAN]
		-- Is integer a valid integer for `execution_agent'.
		
	return_pixmap_agent: FUNCTION [ANY, TUPLE [], EV_PIXMAP]
	
	pixmap_path_agent: FUNCTION [ANY, TUPLE [], STRING]
		
	horizontal_box: EV_HORIZONTAL_BOX
		-- Main horizontal box used in construction of `Current'.
		
	add_pixmap_to_pixmap_container (pixmap: EV_PIXMAP) is
			-- Add `pixmap' to `pixmap_container'.
		local
			x_ratio, y_ratio: REAL
			new_x, new_y: INTEGER
			biggest_ratio: REAL
			a_pixmap: EV_PIXMAP
			a_pixmapable: EV_PIXMAPABLE
			a_path: STRING
		do
			a_pixmap ?= first
			if a_pixmap /= Void then
				a_path := a_pixmap.pixmap_path
			else
				a_pixmapable ?= first
				if a_pixmapable /= Void then
					a_path := a_pixmapable.internal_pixmap_path
				end
			end
			if a_path /= Void then
				pixmap.set_tooltip (a_path)
			end
			x_ratio := pixmap.width / minimum_width_of_object_editor
			y_ratio := pixmap.height / minimum_width_of_object_editor
			if x_ratio > 1 and y_ratio < 1 then 
				new_x := minimum_width_of_object_editor
				new_y := (pixmap.height / x_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio < 1 then
				new_y := minimum_width_of_object_editor
				new_x := (pixmap.width / y_ratio).truncated_to_integer
			end
			if y_ratio > 1 and x_ratio > 1 then
				biggest_ratio := x_ratio.max (y_ratio)
				new_x := (pixmap.width / biggest_ratio).truncated_to_integer
				new_y := (pixmap.height / biggest_ratio).truncated_to_integer
			end
			if new_x /= 0 and new_y /= 0 then
				pixmap.stretch (new_x, new_y)	
			end
			if pixmap.width < 32 then
				filler_label.wipe_out
				filler_label.extend (pixmap)
			else
				pixmap_container.wipe_out
				pixmap_container.extend (pixmap)
			end
			pixmap.set_minimum_size (pixmap.width, pixmap.height)
		end

	populate_constants is
			-- Fill `constants_combo_box' with representations
			-- of all pixmap constants for selection.
		local
			pixmap_constants: ARRAYED_LIST [GB_CONSTANT]
			pixmap_constant: GB_PIXMAP_CONSTANT
			list_item: EV_LIST_ITEM
			lookup_string: STRING
		do
			constants_combo_box.wipe_out
			lookup_string := internal_gb_ev_any.type + internal_type
			pixmap_constants := components.constants.pixmap_constants
			from
				pixmap_constants.start
			until
				pixmap_constants.off
			loop
				pixmap_constant ?= pixmap_constants.item
				create list_item.make_with_text (pixmap_constant.name)
				list_item.set_data (pixmap_constant)
				list_item.set_pixmap (pixmap_constant.small_pixmap)
				add_to_list_alphabetically (constants_combo_box, list_item)
				
				list_item.deselect_actions.block
				list_item.disable_select
				list_item.deselect_actions.resume
				
				if object.constants.has (lookup_string) and
					pixmap_constant = object.constants.item (lookup_string).constant then
					constants_button.select_actions.block
					constants_button.enable_select
					constants_button.select_actions.resume
					list_item.enable_select
				end
				list_item.select_actions.extend (agent list_item_selected (list_item))
				list_item.deselect_actions.extend (agent list_item_deselected (list_item))
				pixmap_constants.forth
			end
			if internal_gb_ev_any.object.constants.item (lookup_string) = Void then
				add_select_item
			end
		end
		
feature {NONE} -- Implementation

	modify_pixmap is
			-- Display a dialog allowing user input for
			-- selected pixmap.
		local
			dialog: EV_FILE_OPEN_DIALOG
			new_pixmap: EV_PIXMAP
			shown_once, opened_file: BOOLEAN
			error_dialog: EV_WARNING_DIALOG
			must_add_pixmap: BOOLEAN
		do
			pixmap_path_agent.call (Void)
			must_add_pixmap := pixmap_path_agent.last_result = Void
			if not constants_button.is_selected and then must_add_pixmap then
				from
					create dialog
				until
					(dialog.file_name.is_empty and shown_once) or opened_file
				loop
					shown_once := True
					dialog.show_modal_to_window (parent_window (Current))
					if not dialog.file_name.is_empty and then valid_file_extension (dialog.file_name.substring (dialog.file_name.count -2, dialog.file_name.count)) then
						create new_pixmap
						new_pixmap.set_with_named_file (dialog.file_name)
						execute_agent (new_pixmap, dialog.file_name)
							-- Must set the pixmap before the stretch takes place.
						add_pixmap_to_pixmap_container (new_pixmap.twin)
						modify_button.set_text (Remove_button_text)
						modify_button.set_tooltip (Remove_tooltip)
						opened_file := True
					elseif not dialog.file_name.is_empty then
						create error_dialog
						error_dialog.set_text (invalid_type_warning)
						error_dialog.show_modal_to_window (parent_window (Current))
					end
				end
			else
				execute_agent (Void, Void)
				pixmap_container.wipe_out
				filler_label.wipe_out
				modify_button.set_text (select_button_text)
				modify_button.set_tooltip (set_with_named_file_tooltip)
			end	
		end
		
	execute_agent (new_value: EV_PIXMAP; new_path: STRING) is
			-- call `execution_agent'. `new_value' may be Void
			-- in the case where we must remove the pixmap.
		do
			execution_agent.call ([new_value, new_path])
		end
		
	remove_constant is
			-- Remove constant represented within `Current' from associated properties.
		do
			execute_agent (Void, Void)
		end	
		
	filler_label: EV_CELL

		
	list_item_deselected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been deselected from `constants_combo_box'.
		local
			constant_context: GB_CONSTANT_CONTEXT
		do
			constant_context := object.constants.item (internal_gb_ev_any.type + internal_type)
			if constant_context /= Void then
				constant_context.destroy
			end
		end
		
	list_item_selected (list_item: EV_LIST_ITEM) is
			-- `list_item' has been selected from `constants_combo_box'.
--		require
--			list_item_not_void: list_item /= Void
--			list_item_has_data: list_item.data /= Void
		local
			constant: GB_PIXMAP_CONSTANT
			constant_context: GB_CONSTANT_CONTEXT
		do
			if list_item.data /= Void then
				constant ?= list_item.data
				check
					data_was_constant: constant /= Void
				end
--				FIXME No need to perform validation for pixamps.
--				validate_agent.call ([constant.pixmap])
--				if validate_agent.last_result then
					create constant_context.make_with_context (constant, object, internal_gb_ev_any.type, internal_type)
					constant.add_referer (constant_context)
					object.add_constant_context (constant_context)
					execute_agent (constant.pixmap, constant.pixmap.pixmap_path)
					update_editors
					if has_select_item then
						remove_select_item
					end
--				else
--					constants_combo_box.first.enable_select
--				end
			end
		end
		

invariant
	invariant_clause: True -- Your invariant here

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


end -- class GB_PIXMAP_INPUT_FIELD
