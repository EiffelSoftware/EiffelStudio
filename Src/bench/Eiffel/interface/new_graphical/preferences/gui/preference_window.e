indexing
	description: "Editor which edits a class"
	author: "Pascal Freund and Christophe Bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_WINDOW

inherit
	EV_TITLED_WINDOW

	SHARED_RESOURCES
		undefine
			default_create
		end

creation
	make, make_then_direct_to

feature -- Initialization

	make is
			-- Initialize
		local
			edit_box: EV_HORIZONTAL_BOX
			v0, v1, v2: EV_VERTICAL_BOX
			split: EV_HORIZONTAL_SPLIT_AREA
--			sbar: EV_STATUS_BAR
		do
			default_create
			set_title ("Preference tool")
			set_size (400, 300)

			create menu
			set_menu_bar (menu)

			create v0
			extend (v0)
			v0.disable_homogeneous

 			create split
			v0.extend (split)
			create v1
			split.extend (v1)
			create v2
			split.extend (v2)

			create left_list
			v1.extend (left_list)

			create right_list
			right_list.set_column_titles (<<"Short Name","Litteral Value">>)
			v2.extend (right_list)
			right_list.select_actions.extend (~right_select)
--			right_list.disable_multiple_selection

			create edit_box
			v2.extend (edit_box)
			edit_box.set_minimum_height (60)
			v2.disable_item_expand (edit_box)

			create boolean_selec.make (edit_box, Current)
			create text_selec.make (edit_box, Current)
			create color_selec.make (edit_box, Current)
			create font_selec.make (edit_box, Current)
			
--			create sbar
--			set_status_bar (sbar)
--			create info_bar
--			sbar.extend (info_bar)
			
			fill_list
			fill_menu
			show
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
					if not it.empty then
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

--	set_file (s: STRING) is
--			-- Set file name where the preferences come from.
--		require
--			consistent: s /= Void and then not s.empty
--		do
--			file_name := s
--		ensure
--			set: file_name = s
--		end

feature -- Update

	update is
			-- Update Current.
		do
			fill_right_list (left_list.selected_item)
			clear
		end

	clear is
			-- Clear the editor.
		do
			boolean_selec.hide
			text_selec.hide
			color_selec.hide
			font_selec.hide
--			info_bar.remove_text
		end

feature -- Implementation

--	file_name: STRING 
		-- File name where the preferences may be saved.

feature -- Graphical Components.

	boolean_selec: BOOLEAN_SELECTION_BOX
		-- Box in which the user may choose whether the value is True or False.

	text_selec: TEXT_SELECTION_BOX
		-- Box in which the user may change the value representable with a string.

	color_selec: COLOR_SELECTION_BOX
		-- Box in which the user may change the value associated to a color.

	font_selec: FONT_SELECTION_BOX
			-- Box in which the user may change the value associated to a font.

--	save_preferences: SAVE_PREFERENCES is
--		once
--			create Result
--		end	

feature -- Widgets.

	menu: EV_MENU_BAR 
		-- menu of Current.

	left_list: EV_TREE
		-- List of fields.

	right_list: EV_MULTI_COLUMN_LIST
		-- List of values attached to field selected in the left list 'left_list'.

	info_bar: EV_LABEL
		-- Message that we display.

	progression: EV_HORIZONTAL_PROGRESS_BAR

feature -- Execution

--	left_select (it: EV_LIST_ITEM) is
--			-- Update right list.
--| FIXME
--| Christophe, 8 feb 2000
--| Maybe a more explicit name/comment would be useful.
--		do
--			fill_right_list (it)
--		end

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

feature --Menu

	fill_menu is
			-- Fill the menu.
		require
			menu_exists: menu /= Void
		local
			it: EV_MENU_ITEM
			itt: EV_MENU
		do	
			create itt.make_with_text ("File")
			menu.extend (itt)

			create it.make_with_text ("Save%TCTRL+S")
			itt.extend (it)
			it.select_actions.extend (~save)

			create it.make_with_text ("OK")
			itt.extend (it)
			it.select_actions.extend (~ok)

			create it.make_with_text ("Apply")
			itt.extend (it)
			it.select_actions.extend (~apply)

			create it.make_with_text ("Exit Tool")
			itt.extend (it)
			it.select_actions.extend (~destroy)

 			create itt.make_with_text ("Help")
			menu.extend (itt)
		end

	save is
			-- Save Current Selection.
		do
--			save_preferences.initialize (Current)
			resources.save
		end 

	apply is
		do
--			resources.reinitialize
		end

	ok is
			-- Apply then popdown the Preferences Tool.
		do
--			resources.reinitialize
			destroy
		end 


feature -- Fill Lists

	fill_list is
			-- Fill Left tree.
		local
 			it: EV_TREE_ITEM
			l: LINKED_LIST [RESOURCE_FOLDER]
		do
			from
				l := resources.child_list ("")
				l.start
			until
				l.after
			loop
				it := folder_item (l.item)
				left_list.extend (it)
				l.forth
			end
		end

	folder_item (folder: RESOURCE_FOLDER): EV_TREE_ITEM is
			-- Fill Left branch.
		require
			folder_exists: folder /= Void
		local
 			it, it_child: EV_TREE_ITEM
 			l: LINKED_LIST [RESOURCE_FOLDER]
		do
			create it
			it.set_text (folder.name)
			it.set_tooltip (folder.description)
			it.set_data (folder)
			it.select_actions.extend (~fill_right_list (it))
			l := folder.child_list
			from
				l.start
			until
				l.after
			loop
				it_child := folder_item (l.item)
				it.extend (it_child)
				l.forth
			end
			Result := it
		end

	fill_right_list (t_item: EV_TREE_NODE) is
			-- Fill right list
		local
			it: RESOURCE_LIST_ITEM
			r: RESOURCE_FOLDER
		do
			r ?= t_item.data
			if r /= Void then
				right_list.wipe_out
				from
					r.resource_list.start
				until
					r.resource_list.after
				loop
					create it.make_resource (r.resource_list.item)
					right_list.extend (it)
					r.resource_list.forth
				end
			end
		end

feature -- savable parameters

	get_height_name	: STRING	is "class_tool_height"
	
	get_width_name	: STRING	is "class_tool_width"

end -- class CLASS_WINDOW
