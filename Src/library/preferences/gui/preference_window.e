indexing
	description	: "Window to edit the preferences"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PREFERENCE_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			destroy
		end

	SHARED_RESOURCES
		rename
			initialize as initialize_resources
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make, 
	make_then_direct_to

feature {NONE} -- Initialization

	delayed_resources: ARRAYED_LIST [STRING]
			-- Resources that will only be taken into account
			-- after the application is restarted.

	make is
			-- Initialize
		require
			all_types_are_graphical: all_types_are_graphical
		local
			main_box: EV_VERTICAL_BOX
			split: FLAT_HORIZONTAL_SPLIT_AREA
			hsep: EV_HORIZONTAL_SEPARATOR
			buttons_box: like build_buttons_box
		do
			default_create
			set_title (Interface_names.t_Preference_window)
			set_size (Layout_constants.Dialog_unit_to_pixels (640), Layout_constants.Dialog_unit_to_pixels (460))
			set_icon_pixmap (pixmap_file_contents (Interface_names.preference_window_icon))

			create left_list
			create right_list
			right_list.set_column_titles (<<Interface_names.l_Short_name, Interface_names.l_Literal_value>>)
			right_list.select_actions.extend (agent on_right_list_select)
			right_list.deselect_actions.extend (agent on_right_list_deselect)
			right_list.focus_out_actions.extend (agent on_right_list_focus_out)
			right_list.column_resize_actions.extend (agent on_right_list_column_resize)
			right_list.resize_actions.extend (agent on_window_move_and_resize)

--			create boolean_selec.make (Current)
--			create text_selec.make (Current)
--			create color_selec.make (Current)
--			create font_selec.make (Current)

				-- Split area
 			create split
			split.enable_flat_separator
			split.extend (left_list)
			split.extend (right_list)

				-- Separator
			create hsep

				-- Buttons box
			buttons_box := build_buttons_box

				-- Main box
			create main_box
			main_box.set_border_width (Layout_constants.Default_border_size)
			main_box.set_padding (Layout_constants.Small_padding_size)
			main_box.extend (split)
			main_box.extend (hsep)
			main_box.disable_item_expand (hsep)
			main_box.extend (buttons_box)
			main_box.disable_item_expand (buttons_box)
			extend (main_box)

			fill_list
			close_request_actions.extend (agent destroy)
			move_actions.extend (agent on_window_move_and_resize)
			resize_actions.extend (agent on_window_move_and_resize)
			
			create delayed_resources.make (20)
			delayed_resources.compare_objects

			show
			split.set_split_position (Layout_constants.Dialog_unit_to_pixels(250))
			right_list.set_column_width (Layout_constants.Dialog_unit_to_pixels(250), 1)
			right_list.set_column_width (right_list.width - right_list.column_width (1) - 2, 2)
		end

	make_then_direct_to (folder_name: STRING) is
			-- Popup the Preference Window with category corresponding to `category_name'.
		require
			name_possible: folder_name /= Void and then resources.has_folder (folder_name)
		local
			folder: RESOURCE_FOLDER
			it: EV_TREE_NODE
		do
			default_create
			folder := resources.folder (folder_name)
			if folder /= Void then
				it := left_list.item_by_data (folder)
				check
					not_void: it /= Void
				end
				if it /= Void then
					if not it.is_empty then
						it.expand
					else
						it.enable_select
					end
				else
					-- Popup warning => Category not reachable.
				end
			else
				-- Popup warning => Category not found !
			end
		end

feature -- Command

	destroy is
			-- Destroy the window
		do
				-- Destroy the selection windows as well
--			boolean_selec.destroy
--			text_selec.destroy
--			color_selec.destroy
--			font_selec.destroy

			Precursor {EV_TITLED_WINDOW}
		end

feature -- Contract support

	all_types_are_graphical: BOOLEAN is
			-- Are all registered types graphical?
		local
			cv_grap: GRAPHICAL_RESOURCE_TYPE
		do
			from
				registered_types.start
				Result := True
			until
				registered_types.after or Result = False
			loop
				cv_grap ?= registered_types.item
				Result := cv_grap /= Void
				registered_types.forth
			end
		end

feature {SELECTION_BOX} -- Update

	update (a_resource: RESOURCE) is
			-- Update Current.
		do
			update_delayed_resources (a_resource)
			fill_right_list (left_list.selected_item)
		end

	update_selected (a_resource: RESOURCE) is
			-- Update the value of the selected right item.
		local
			sel: RESOURCE_LIST_ITEM
		do
			update_delayed_resources (a_resource)
			if right_list.selected_item /= Void then
				sel ?= right_list.selected_item
				check
					sel /= Void
				end
				sel.update
			end
		end

feature {NONE} -- Execution

	on_right_list_focus_out is
			-- Clear the edition window when the right list lose the focus.
		do
			if current_edition_window /= Void then
				if not current_edition_window.has_focus and then
					not right_list.has_focus
				then
					clear
					right_list.remove_selection
				end
			end
		end
		
	on_right_list_column_resize (a_column: INTEGER) is
			-- A column in the right list has been resized
		local
			column2_width: INTEGER
			column1_width: INTEGER
			list_width: INTEGER
		do
			if not inside_on_resize_right_list_column then
				inside_on_resize_right_list_column := True
				column1_width := right_list.column_width (1)
				column2_width := right_list.column_width (2)
				list_width := right_list.width
				resize_actions.block
				if column1_width > list_width then
					right_list.set_column_widths (<<list_width - 3, 1>>)
				else
					right_list.set_column_width ((list_width - column1_width - 2).max (1), 2)
				end
				resize_actions.resume
				clear
				right_list.remove_selection
				inside_on_resize_right_list_column := False
			end
		end
		
	on_right_list_deselect (l_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Unselected value
		do
			clear
		end
		
	on_right_list_select (l_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Allows change to a value.
		local
			it: RESOURCE_LIST_ITEM
			col: COLOR_RESOURCE
			font: FONT_RESOURCE
			bool: BOOLEAN_RESOURCE
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
			edition_window_x: INTEGER
			edition_window_y: INTEGER
			column2_width: INTEGER
			column1_width: INTEGER
			box: SELECTION_BOX
			gtype: GRAPHICAL_RESOURCE_TYPE
		do
			clear
			it ?= l_item
			check
				correct_type: it /= Void
			end
			gtype ?= it.resource.type
			check
				gtype /= Void
				-- Cf. precondition in `make'.
			end
			box := gtype.edition_box (Current)
			box.display (it.resource)
			current_edition_window := box.change_dialog
			
			column1_width := right_list.column_width (1)
			column2_width := right_list.column_width (2)
			edition_window_x := right_list.screen_x + column1_width + 3
			edition_window_y := right_list.screen_y + it.row_number * right_list.row_height + 1
			current_edition_window.set_position (edition_window_x, edition_window_y)
			current_edition_window.set_size (column2_width - 2, right_list.row_height - 5)
			current_edition_window.show_relative_to_window (Current)
		end
		
	on_window_move_and_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Window has moved, resized, ...
		local
			column2_width: INTEGER
		do
			if not inside_on_resize_right_list_column then
				clear
				column2_width := right_list.width - right_list.column_width (1) - 2
				column2_width := column2_width.max (1)
				right_list.set_column_width (column2_width, 2)
			end
		end
		
	apply_changes is
			-- Apply changes.
		local
			wd: STANDARD_DISCARDABLE_CONFIRMATION_DIALOG
			delayed_resources_msg: STRING
		do
			if not delayed_resources.is_empty then
				create delayed_resources_msg.make (255)
				delayed_resources_msg.append (Interface_names.w_Preferences_delayed_resources)
				from
					delayed_resources.start	
				until
					delayed_resources.after
				loop
					delayed_resources_msg.append ("- ")
					delayed_resources_msg.append (delayed_resources.item)
					delayed_resources_msg.append ("%N")
					delayed_resources.forth
				end
				create wd.make_initialized (1, "confirm_change_resource_need_restart", delayed_resources_msg, Interface_names.l_Do_not_show_again)
				wd.show_modal_to_window (Current)
				delayed_resources.wipe_out
			end
			resources.save
		end

	on_reinitialize is
			-- Load the defaults.
		do
			resources.load_defaults
			left_list.wipe_out
			right_list.wipe_out
			fill_list
		end

	on_close is
			-- Close button has been pushed: apply the changes then close
			-- the Preferences Window.
		do
			apply_changes
			destroy
		end 

feature {NONE} -- Implementation - Fill Lists

	recurse_expand (it: EV_TREE_NODE; a_depth: INTEGER) is
			-- Recursively expand `it'. if `a_depth' is set
			-- to zero, it only `it' but not its children.
		require
			depth_valid: a_depth >= 0
		do
			if not it.is_empty then
				if a_depth > 0 then
					from
						it.start
					until
						it.after
					loop
						recurse_expand (it.item, a_depth - 1)
						it.forth
					end
				end
				it.expand
			end
		end

	fill_list is
			-- Fill Left tree.
		local
 			it: EV_TREE_ITEM
			l: LIST [RESOURCE_FOLDER]
			curr_item: RESOURCE_FOLDER
		do
			from
				l := resources.child_list ("")
				l.start
			until
				l.after
			loop
				curr_item := l.item
				if curr_item.is_visible then
					it := folder_item (curr_item)
					left_list.extend (it)
				end
				l.forth
			end
	
			recurse_expand (it, 1)
		end

	folder_item (folder: RESOURCE_FOLDER): EV_TREE_ITEM is
			-- Fill Left branch.
		require
			folder_exists: folder /= Void
			folder_visible: folder.is_visible
		local
 			it, it_child: EV_TREE_ITEM
 			l: LIST [RESOURCE_FOLDER]
			curr_item: RESOURCE_FOLDER
		do
			create it
			if folder.description /= Void and then not folder.description.is_empty then
				it.set_text (folder.description)
			else
				it.set_text (folder.name)
			end

			if folder.icon /= Void then
				it.set_pixmap (pixmap_file_contents (folder.icon))
			end

			it.set_data (folder)
			it.select_actions.extend (agent fill_right_list (it))
			it.select_actions.extend (agent clear)
			l := folder.child_list
			from
				l.start
			until
				l.after
			loop
				curr_item := l.item
				if curr_item.is_visible then
					it_child := folder_item (curr_item)
					it.extend (it_child)
				end
				l.forth
			end
			Result := it
		ensure
			Result_exists: Result /= Void
		end

	fill_right_list (t_item: EV_TREE_NODE) is
			-- Fill right list
		local
			it: RESOURCE_LIST_ITEM
			r: RESOURCE_FOLDER
			selected_item: RESOURCE_LIST_ITEM
			row_number: INTEGER
			selected_row: INTEGER
			rl: LIST [RESOURCE]
			tmp_list: ARRAYED_LIST [RESOURCE_LIST_ITEM]
		do
			implementation.lock_update

			r ?= t_item.data
			if r /= Void then
				selected_item ?= right_list.selected_item
				right_list.wipe_out
				create tmp_list.make (r.resource_list.count)
				from
					rl := r.resource_list
					rl.start
					row_number := 1
				until
					rl.after
				loop
					if rl.item.description /= Void then
						create it.make_resource (rl.item)
						it.set_row_number (row_number)
						tmp_list.extend (it)
						if selected_item /= Void and then selected_item.resource = it.resource then
							selected_row := row_number
						end
						row_number := row_number + 1
					end
					rl.forth
				end
				right_list.append (tmp_list)
				if selected_row > 0 then
					right_list.i_th (selected_row).enable_select
				end
			end

			implementation.unlock_update
		end

feature {NONE} -- Implementation

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Constants used in the layout of GUIs.
		once
			create Result
		end

	Interface_names: RESOURCES_STRING_CONSTANTS is
			-- String constants used in the GUI.
		once
			create Result
		end

	pixmap_file_contents (pn: STRING): EV_PIXMAP is
			-- Load a pixmap in file named `pn'.
		require
			valid_file_name: pn /= Void
		local
			retried: BOOLEAN
			fullp: FILE_NAME
		do
			create Result
			if not retried then
				create fullp.make_from_string (Interface_names.pixmaps_path_cell.item)
				fullp.set_file_name (pn)
				fullp.add_extension (interface_names.pixmaps_extension_cell.item)
				Result.set_with_named_file (fullp)
			end
		rescue
			retried := True
			retry
		end

	update_delayed_resources (a_resource: RESOURCE) is
			-- Update `delayed_resources' with `a_resource'.
		local
			delayed_resource_name: STRING
		do
			if (a_resource.effect_is_delayed) then
				delayed_resource_name := a_resource.description
				if not delayed_resources.has (delayed_resource_name) then
					delayed_resources.extend (delayed_resource_name)
				end
			end
		end

	build_buttons_box: EV_HORIZONTAL_BOX is
			-- Create and return the box containing the buttons
		local
			close_button: EV_BUTTON
			restore_defaults_button: EV_BUTTON
		do
			create close_button.make_with_text_and_action (Interface_names.b_Close, agent on_close)
			Layout_constants.set_default_size_for_button (close_button)

			create restore_defaults_button.make_with_text_and_action (Interface_names.b_Restore_defaults, agent on_reinitialize)
			Layout_constants.set_default_size_for_button (restore_defaults_button)

			create Result
			Result.set_padding (Layout_constants.Small_padding_size)
			Result.extend (restore_defaults_button)
			Result.disable_item_expand (restore_defaults_button)
			Result.extend (create {EV_CELL}) -- Expandable item
			Result.extend (close_button)
			Result.disable_item_expand (close_button)
		end

	clear is
			-- Hide the edition window if displayed
		do
			if current_edition_window /= Void and then current_edition_window.is_displayed then
				current_edition_window.hide
				current_edition_window := Void
			end
		end
		
feature {NONE} -- Private widgets

	left_list: EV_TREE
			-- List of fields.

	right_list: EV_MULTI_COLUMN_LIST
			-- List of values attached to field selected in the left list 'left_list'.

--	boolean_selec: BOOLEAN_SELECTION_BOX
--			-- Box in which the user may choose whether the value is True or False.
--
--	text_selec: TEXT_SELECTION_BOX
--			-- Box in which the user may change the value representable with a string.
--
--	color_selec: COLOR_SELECTION_BOX
--			-- Box in which the user may change the value associated to a color.
--
--	font_selec: FONT_SELECTION_BOX
--			-- Box in which the user may change the value associated to a font.
--
	current_edition_window: EV_DIALOG
			-- Currently displayed edition window. Void if no window is
			-- displayed.

feature {NONE} -- Private attributes

	inside_on_resize_right_list_column: BOOLEAN
			-- Are we in the middle of `on_resize_right_list_column'?

end -- class PREFERENCE_WINDOW
