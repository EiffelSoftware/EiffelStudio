indexing
	description	: "Window to edit the preferences"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	PREFERENCE_WINDOW

inherit
	EV_TITLED_WINDOW

	SHARED_RESOURCES
		undefine
			default_create
		end

	EB_CONSTANTS
		undefine
			default_create,
			Layout_constants
		end
	
	EB_SHARED_PIXMAPS
		undefine
			default_create
		end

create
	make, 
	make_then_direct_to

feature -- Initialization

	make is
			-- Initialize
		local
			edit_box: EV_HORIZONTAL_BOX
			main_box: EV_VERTICAL_BOX
			right_panel: EV_VERTICAL_BOX
			split: EB_HORIZONTAL_SPLIT_AREA
			hsep: EV_HORIZONTAL_SEPARATOR
			buttons_box: like build_buttons_box
		do
			default_create

			create left_list
			create right_list
			right_list.set_column_titles (<<"Short Name","Literal Value">>)
			right_list.set_column_widths (<<Layout_constants.Dialog_unit_to_pixels(219), Layout_constants.Dialog_unit_to_pixels(149)>>)
			right_list.select_actions.extend (~right_select)
			right_list.deselect_actions.extend (~clear_on_unselect)

			create edit_box
			edit_box.set_minimum_height (Layout_constants.Dialog_unit_to_pixels(40))
			create boolean_selec.make (edit_box, Current)
			create text_selec.make (edit_box, Current)
			create color_selec.make (edit_box, Current)
			create font_selec.make (edit_box, Current)

				-- Right panel
			create right_panel
			right_panel.extend (right_list)
			right_panel.extend (edit_box)
			right_panel.disable_item_expand (edit_box)
		
				-- Split area
 			create split
			split.enable_flat_separator
			split.extend (left_list)
			split.extend (right_panel)

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
			close_actions.extend (~destroy)

			set_title ("Preferences")
			set_size (Layout_constants.Dialog_unit_to_pixels(640), Layout_constants.Dialog_unit_to_pixels(460))
			split.set_split_position (Layout_constants.Dialog_unit_to_pixels(250))
			show
		end

	build_buttons_box: EV_BOX is
			-- Create and return the box containing the buttons
		local
			ok_button: EV_BUTTON
			cancel_button: EV_BUTTON
			apply_button: EV_BUTTON
			restore_defaults_button: EV_BUTTON
		do
			create ok_button.make_with_text ("OK")
			ok_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height) 
			ok_button.select_actions.extend (~ok)

			create cancel_button.make_with_text ("Cancel")
			cancel_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height) 
			cancel_button.select_actions.extend (~destroy)

			create apply_button.make_with_text ("Apply")
			apply_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height) 
			apply_button.select_actions.extend (~apply)

			create restore_defaults_button.make_with_text ("Restore Defaults")
			restore_defaults_button.set_minimum_height (Layout_constants.Default_button_height)
			restore_defaults_button.select_actions.extend (~reinitialize)


			create {EV_HORIZONTAL_BOX} Result
			Result.set_padding (Layout_constants.Small_padding_size)
			Result.extend (restore_defaults_button)
			Result.disable_item_expand (restore_defaults_button)
			Result.extend (create {EV_CELL})
			Result.extend (ok_button)
			Result.disable_item_expand (ok_button)
			Result.extend (cancel_button)
			Result.disable_item_expand (cancel_button)
			Result.extend (apply_button)
			Result.disable_item_expand (apply_button)
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

feature -- Update

	update is
			-- Update Current.
		do
			fill_right_list (left_list.selected_item)
		end

	clear is
			-- Clear the editor.
		do
			boolean_selec.hide
			text_selec.hide
			color_selec.hide
			font_selec.hide
		end

feature -- Graphical Components.

	boolean_selec: BOOLEAN_SELECTION_BOX
			-- Box in which the user may choose whether the value is True or False.

	text_selec: TEXT_SELECTION_BOX
			-- Box in which the user may change the value representable with a string.

	color_selec: COLOR_SELECTION_BOX
			-- Box in which the user may change the value associated to a color.

	font_selec: FONT_SELECTION_BOX
			-- Box in which the user may change the value associated to a font.

feature -- Widgets.

	menu: EV_MENU_BAR 
			-- menu of Current.

	left_list: EV_TREE
			-- List of fields.

	right_list: EV_MULTI_COLUMN_LIST
			-- List of values attached to field selected in the left list 'left_list'.

	info_bar: EV_LABEL
			-- Message that we display.

feature -- Execution

	clear_on_unselect (l_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Unselected value
		do
			clear
		end

	right_select (l_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Allows change to a value.
		require
			an_item_selected: right_list.selected_item /= Void
		local
			it: RESOURCE_LIST_ITEM
			col: COLOR_RESOURCE
			font: FONT_RESOURCE
			bool: BOOLEAN_RESOURCE
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
		do
			it ?= l_item
			clear
			check
				correct_type: it /= Void
			end
			col ?= it.resource
			font ?= it.resource
			bool ?= it.resource
			int ?= it.resource
			str ?= it.resource
			if col /= Void then
				color_selec.display (col)
			elseif font /= Void then
				font_selec.display (font)
			elseif bool /= Void then
				boolean_selec.display (bool)
			elseif int/=Void or str /= Void then
				text_selec.display (it.resource)
			end
		end

feature -- Menu

	apply is
		do
			resources.save
		end

	reinitialize is
			-- Load the defaults.
		do
			resources.load_defaults
			
				-- Reload the dialog
			destroy
			make
		end

	ok is
			-- Apply then popdown the Preferences Tool.
		do
			apply
			destroy
		end 


feature -- Fill Lists

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
			l: LINKED_LIST [RESOURCE_FOLDER]
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
 			l: LINKED_LIST [RESOURCE_FOLDER]
			curr_item: RESOURCE_FOLDER
		do
			create it
			if folder.description /= Void and then not folder.description.is_empty then
				it.set_text (folder.description)
			else
				it.set_text (folder.name)
			end

			if folder.icon /= Void then
				it.set_pixmap (pixmap_file_content(folder.icon))
			end

			it.set_data (folder)
			it.select_actions.extend (~fill_right_list (it))
			it.select_actions.extend (~clear)
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
		do
			implementation.lock_update

			r ?= t_item.data
			if r /= Void then
				selected_item ?= right_list.selected_item
				right_list.wipe_out
				from
					r.resource_list.start
				until
					r.resource_list.after
				loop
					create it.make_resource (r.resource_list.item)
					right_list.extend (it)
					r.resource_list.forth
					if selected_item /= Void and then selected_item.resource = it.resource then
						it.enable_select						
					end
				end
			end

			implementation.unlock_update
		end

feature {NONE} -- Private constants

	Layout_constants: EV_LAYOUT_CONSTANTS is
			-- Vision2 layout constants
		once
			create Result
		end

end -- class PREFERENCE_WINDOW
