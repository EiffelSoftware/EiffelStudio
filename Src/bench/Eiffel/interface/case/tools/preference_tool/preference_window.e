indexing
	description: "Editor which edits a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PREFERENCE_WINDOW

inherit
	ECASE_WINDOW
		redefine
			make
		end

creation
	make

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
			set_title(widget_names.preference_tool)
			set_size(300,300)

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
			left_list.add_selection_command(com,Void)

			!! com.make(~right_select)
			!! right_list.make_with_text(v2,<<"Short Name","Litteral Value">>)
			right_list.add_selection_command(com, Void)
			right_list.set_single_selection

			!! edit_box.make(v2)
			edit_box.set_minimum_height(60)
			v2.set_child_expandable(edit_box,FALSE)
			!! boolean_selec.make(edit_box,Current)
			!! text_selec.make(edit_box,Current)
			!! color_selec.make(edit_box, Current)
			!! font_selec.make(edit_box, Current)

			fill_list
			fill_menu
			show
		end

feature -- Update

	update is
			-- Update Current.
		do
			fill_right_list 
			clear
		end

	clear is
		do
			boolean_selec.hide
			text_selec.hide
			color_selec.hide
			font_selec.hide
		end

feature -- Widgets

	boolean_selec: BOOLEAN_SELECTION_BOX
		-- Box in which the user may choose whether the value is TRUE or FALSE.

	text_selec: TEXT_SELECTION_BOX
		-- Box in which the user may change the value representable with a string.

	color_selec: COLOR_SELECTION_BOX
		-- Box in which the user may change the value associated to a color.

	font_selec: FONT_SELECTION_BOX
			-- Box in which the user may change the value associated to a font.

	menu: EDITOR_WINDOW_MENU
		-- menu of Current.

	left_list: EV_LIST
		-- List of fields.

	right_list: EV_MULTI_COLUMN_LIST
		-- List of values attached to field selected in the left list 'left_list'.

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

feature --Implementation

	fill_menu is
		local
		do
			if menu /= Void then	

			end
		end
 
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
				l.forth
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

invariant
	PREFERENCES_WINDOW_value_editors_exist: boolean_selec /= Void and text_selec/= Void and color_selec/=Void and font_selec/=Void
	PREFERENCES_WINDOW_lists_exist: left_list /= Void and right_list /= Void
end -- class CLASS_WINDOW
