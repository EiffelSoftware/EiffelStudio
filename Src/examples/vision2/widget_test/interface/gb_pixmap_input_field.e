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
	EV_VERTICAL_BOX

	EV_BUILDER

	GB_GENERAL_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	INTERNAL
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_EV_PIXMAP_HANDLER
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	GB_INTERFACE_CONSTANTS_IMP
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

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
			label_text_not_void_or_empty: label_text /= Void and not label_text.is_empty
			an_agent_not_void: an_execution_agent /= Void
			a_validate_agent_not_void: a_validate_agent /= Void
		local
			vertical_box: EV_VERTICAL_BOX
		do
			call_default_create (any)

			create frame.make_with_text (label_text)
			create vertical_box
			frame.extend (vertical_box)
			create horizontal_box
			vertical_box.extend (horizontal_box)
			horizontal_box.set_padding_width (object_editor_padding_width)
			horizontal_box.set_border_width (Object_editor_padding_width)

			create modify_button.make_with_text ("select")
			modify_button.select_actions.extend (agent modify_pixmap)
			modify_button.select_actions.extend (agent update_editors)
			horizontal_box.extend (modify_button)
			create filler_label
			horizontal_box.extend (filler_label)
			horizontal_box.disable_item_expand (modify_button)
			create pixmap_container
			Current.extend (frame)
			vertical_box.extend (pixmap_container)
			a_parent.extend (Current)

			execution_agent := an_execution_agent
			validate_agent := a_validate_agent
			return_pixmap_agent := a_pixmap_agent
			pixmap_path_agent := a_pixmap_path_agent
		ensure
			execution_agent_not_void: execution_agent /= Void
			validate_agent_not_void: validate_agent /= Void
		end

feature {GB_EV_EDITOR_CONSTRUCTOR} -- Implementation

	update_constant_display (a_value: EV_PIXMAP) is
			-- Update widgets and display based on state of current constant selected.
		local
			has_pixmap: BOOLEAN
			pixmap: EV_PIXMAP
			l_pixmap_path: STRING
			error_label: EV_LABEL
		do
			pixmap_path_agent.call (Void)
			l_pixmap_path := pixmap_path_agent.last_result
			return_pixmap_agent.call (Void)
			pixmap := return_pixmap_agent.last_result
			has_pixmap := pixmap /= Void

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

	hide_frame is
			-- Ensure no frame is applied to `Current' and remove border from top level box.
		local
			container: EV_CONTAINER
			widget: EV_WIDGET
		do
			container := frame.parent
			container.prune (frame)
			widget := frame.item
			frame.wipe_out
			horizontal_box.set_border_width (0)
			container.extend (widget)
		ensure
			 frame_not_used: frame.parent = Void and frame.is_empty
		end

feature {NONE} -- Implementation

	call_default_create (any: ANY) is
			-- Call `default_create' and assign `any' to `internal_gb_ev_any'.
		require
			gb_ev_any_not_void: any /= Void
		do
			default_create
		end

	modify_button: EV_BUTTON
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

	frame: EV_FRAME
		-- Frame used for displaying title around `Current'.

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
			if must_add_pixmap then
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

	update_editors is
			-- Update all editors. Nothing to perform here, as required by EiffelBuild classes.
		do
		end

	filler_label: EV_CELL

	environment: EV_ENVIRONMENT is
			-- Once access to instance of EV_ENVIRONMENT.
		once
			create Result
		end

	minimum_width_of_object_editor: INTEGER is 165

	remove_button_text: STRING is "Remove"

	select_button_text: STRING is "Select"

	set_with_named_file_tooltip: STRING is "Set pixmap image with named file"

	pixmap_missing_string: STRING is "Error - named pixmap missing."

	clear_text: STRING is "Clear"

	clear_tooltip: STRING is "Clear pixmap image"

	object_editor_padding_width: INTEGER is 3

invariant
	invariant_clause: True -- Your invariant here

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_PIXMAP_INPUT_FIELD
