indexing
	description: "Editor which edits a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ADVANCED_COLOR_WINDOW

inherit
	EC_TOOL
		redefine
			make,
			menu,
			global_container
		end

	
creation
	make

feature -- Initialization

	make(par: EV_WINDOW) is
			-- Initialize
		local
			ok_horizontal_box: EV_HORIZONTAL_BOX
			space: EV_LABEL

			print_command: PRINT_COMMAND
		do
			precursor(par)
			set_title(widget_names.advanced_color_tool)

			!! menu.make (Current)
			!! global_container.make ( Current )

			!! notebook.make (global_container)

			!! class_page.make(notebook, Current)
			!! color_page.make(notebook, Current)
			!! type_page.make(notebook, Current)

			fill_menu

			show
		end

feature -- Update

	update is
		do
		end

feature -- Properties

	caller: PRINT_WINDOW_CALLER

feature -- Widgets

	menu: EDITOR_WINDOW_MENU
	global_container: EV_VERTICAL_BOX
	notebook: EV_NOTEBOOK

	class_page: EC_CLASS_PAGE
	color_page: COLOR_PAGE
	type_page: TYPE_PAGE
	--depth_page: DEPTH_PAGE

	class_i: EV_MENU_ITEM
	color_i: EV_MENU_ITEM
	type_i: EV_MENU_ITEM

feature --Implementation

	fill_menu is
		local
			select_page_notebook: SELECT_PAGE_NOTEBOOK
			argument: EV_ARGUMENT1 [INTEGER]
		do
			if menu /= Void then	
				!! select_page_notebook.make (notebook)

				!! class_i.make_with_text (menu.format_m, widget_names.classes)
				!! argument.make (1)
				class_i.add_select_command (select_page_notebook, clone (argument))

				!! color_i.make_with_text (menu.format_m, widget_names.color)
				!! argument.make (2)
				color_i.add_select_command (select_page_notebook, clone (argument))

				!! type_i.make_with_text (menu.format_m, widget_names.type)
				!! argument.make (3)
				type_i.add_select_command (select_page_notebook, clone (argument))

			end
		end
 
feature -- savable parameters

	get_height_name	: STRING	is "class_tool_height"
	
	get_width_name	: STRING	is "class_tool_width"

end -- class CLASS_WINDOW
