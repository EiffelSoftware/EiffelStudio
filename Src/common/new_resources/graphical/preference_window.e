indexing
	description: "Editor which edits a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_WINDOW

inherit
	EV_WINDOW
		redefine 
			make
		end
	SHARED_RESOURCES

creation
	make,make_then_direct_to

feature -- Initialization

	make(par: EV_WINDOW) is
			-- Initialize
		local
			h1,edit_box: EV_HORIZONTAL_BOX
			v0,v1,v2: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
			fix: EV_FIXED
		do
			precursor(par)
			set_title("Preference tool")
			set_size(400,300)

			!! menu.make (Current)
			!! v0.make(Current)
			v0.set_homogeneous(FALSE)
 			!! h1.make( v0 )
			!! v1.make(h1)
			!! fix.make(h1)
			fix.set_minimum_width(20)
			h1.set_child_expandable(fix,FALSE)
			!! v2.make(h1)
			
			!! com.make(~left_select)
			!! left_list.make(v1)
			left_list.add_select_command(com,Void)

			!! com.make(~right_select)
			!! right_list.make_with_text(v2,<<"Short Name","Litteral Value">>)
			right_list.add_select_command(com, Void)
			right_list.set_single_selection

			!! edit_box.make(v2)
			edit_box.set_minimum_height(60)
			v2.set_child_expandable(edit_box,FALSE)
			!! boolean_selec.make(edit_box,Current)
			!! text_selec.make(edit_box,Current)
			!! color_selec.make(edit_box, Current)
			!! font_selec.make(edit_box, Current)
			
			!! status_bar.make(Current)
			!! info_bar.make(status_bar)
			
			fill_list
			fill_menu
			show
		end

	make_then_direct_to(par: EV_WINDOW; category_name: STRING) is
			-- Popup the Preference Window with category corresponding to 'category_name'.
		require
			parent_exists: par /= Void
			name_possible: category_name /= Void and then resources.resource_structure.has_category(category_name)
		local
			category: RESOURCE_CATEGORY
			it : EV_TREE_ITEM
		do
			make(par)
			category := resources.resource_structure.find_category_with_name(category_name,
							resources.resource_structure.categories)
			if category /= Void then
				it := left_list.find_item_by_data(category)
				check
					not_void: it /= Void 
				end
				if it /= Void then
					if it.is_parent then
						it.set_expand(TRUE)
					else
						it.set_selected(TRUE)
					end
				else
					-- Popup warning => Category not reachable.
				end
			else
				-- Popup warning => Category not found !
			end
		end

	set_file(s: STRING) is
			-- Set file name where the preferences come from.
		require
			consistent: s /= Void and then not s.empty
		do
			file_name := s
		ensure
			set: file_name = s
		end

feature -- Update

	update is
			-- Update Current.
		do
			fill_right_list 
			clear
		end

	clear is
			-- Clear the editor.
		do
			boolean_selec.hide
			text_selec.hide
			color_selec.hide
			font_selec.hide
			info_bar.set_text("")
		end

feature -- Implementation

	file_name: STRING 
		-- File name where the preferences may be saved.

feature -- Graphical Components.

	boolean_selec: BOOLEAN_SELECTION_BOX
		-- Box in which the user may choose whether the value is TRUE or FALSE.

	text_selec: TEXT_SELECTION_BOX
		-- Box in which the user may change the value representable with a string.

	color_selec: COLOR_SELECTION_BOX
		-- Box in which the user may change the value associated to a color.

	font_selec: FONT_SELECTION_BOX
			-- Box in which the user may change the value associated to a font.

	save_preferences: SAVE_PREFERENCES is
		once
			create Result
		end	

feature -- Widgets.

	menu: EV_STATIC_MENU_BAR 
		-- menu of Current.

	left_list: EV_TREE
		-- List of fields.

	right_list: EV_MULTI_COLUMN_LIST
		-- List of values attached to field selected in the left list 'left_list'.

	status_bar: EV_STATUS_BAR
		-- Status Bar

	info_bar: EV_STATUS_BAR_ITEM
		-- Message that we display.

	progression: EV_STATUS_BAR_ITEM

feature -- Execution

	left_select (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Update right list.
		do
			fill_right_list
		end

	right_select (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Allows change to a value.
		require
			an_item_selected: right_list.selected
		local
			it: RESOURCE_LIST_ITEM
			col: COLOR_RESOURCE
			font: FONT_RESOURCE
			bool: BOOLEAN_RESOURCE
			int: INTEGER_RESOURCE
			str: STRING_RESOURCE
		do
			it ?= right_list.selected_item
			clear
			check
				correct_type: it /= Void
			end
			col ?= it.resource.value
			font ?= it.resource.value
			bool ?= it.resource.value
			int ?= it.resource.value
			str ?= it.resource.value
			if col /= Void then
				color_selec.display(col)
			elseif font /= Void then
				font_selec.display(font)
			elseif bool /= Void then
				boolean_selec.display(bool)
			elseif int/=Void or str /= Void then
				text_selec.display(it.resource.value)
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
			com: EV_ROUTINE_COMMAND
		do	
			!! itt.make_with_text(menu,"File")

			!! it.make_with_text(itt,"Save%TCTRL+S")
			!! com.make(~save)
			it.add_select_command(com,Void)

			!! it.make_with_text(itt,"OK")
			!! com.make(~ok)
			it.add_select_command(com,Void)

			!! it.make_with_text(itt,"Apply")
			!! com.make(~apply)
			it.add_select_command(com,Void)
		
			!! it.make_with_text(itt,"Exit Tool")
			!! com.make(~exit)
			it.add_select_command(com,Void)

 			!! itt.make_with_text(menu,"Help")
		end

	exit (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Exit the Tool.
		require
			not_destroyed: not destroyed
		do
			destroy
		ensure
			destroyed: destroyed
		end 

	save (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Save Current Selection.
		do
			save_preferences.initialize(Current)
			save_preferences.save
		end 

	apply (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			resources.reinitialize
		end 

	ok (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Apply then popdown the Preferences Tool.
		do
			resources.reinitialize
			destroy
		end 


feature -- Fill Lists

	fill_list is
			-- Fill Left list.
		local
 			it: PREFERENCE_LIST_ITEM
			l: LINKED_LIST [RESOURCE_CATEGORY]
		do
			from
				l := resources.resource_structure.categories
				l.start
			until
				l.after
			loop
				!! it.make_with_element(left_list,l.item)
				fill_left_branch(l.item.categories,it)
				l.forth
			end
		end

	fill_left_branch (categories: LINKED_LIST [RESOURCE_CATEGORY];holder: EV_TREE_ITEM_HOLDER) is
			-- Fill Left branch.
		require
			list_exists: categories /= Void
		local
 			it: PREFERENCE_LIST_ITEM
		do
			from
				categories.start
			until
				categories.after
			loop
				!! it.make_with_element(holder,categories.item)
				fill_left_branch (categories.item.categories,it)
				categories.forth
			end

		end

	fill_right_list is
			-- Fill right list
		local
			it: RESOURCE_LIST_ITEM
			itt: PREFERENCE_LIST_ITEM
			r: RESOURCE_CATEGORY
		do
			itt ?= left_list.selected_item
			if itt /= Void then
				r := itt.category
				right_list.clear_items
				from
					r.resources.start
				until
					r.resources.after
				loop
					!! it.make_resource(right_list,r.resources.item)
					r.resources.forth
				end
			end
		end

feature -- savable parameters

	get_height_name	: STRING	is "class_tool_height"
	
	get_width_name	: STRING	is "class_tool_width"

end -- class CLASS_WINDOW
