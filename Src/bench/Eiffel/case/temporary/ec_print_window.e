indexing
	description: "Editor which edits a class"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EC_PRINT_WINDOW

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
			select_page_menu: SELECT_PAGE_MENU
			ok_horizontal_box: EV_HORIZONTAL_BOX
			space: EV_LABEL

			print_command: PRINT_COMMAND
		do
			precursor(par)
			set_title("Print")

			!! menu.make (Current)
			!! global_container.make ( Current )

			!! notebook.make (global_container)

			!! select_page_menu.make (notebook, Current)
			notebook.add_switch_command (select_page_menu, Void)
	--		!! printer_page.make(notebook, Current)

		--	!! file_page.make(notebook, Current)

			!! ok_horizontal_box.make (global_container)
			ok_horizontal_box.set_expand (false)

			!! ok_button.make_with_text (ok_horizontal_box, widget_names.ok)
			caller ?= par
			!! print_command.make (caller, Current, notebook)
			ok_button.add_click_command (print_command, Void)

			!! space.make (ok_horizontal_box)
			!! cancel_button.make_with_text (ok_horizontal_box, widget_names.cancel)

			fill_menu
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

--	printer_page: PRINTER_PAGE
--	file_page: FILE_PAGE

	print_i: EV_MENU_ITEM
	import_indexing_i: EV_MENU_ITEM
	default_i: EV_MENU_ITEM
	browse_i: EV_MENU_ITEM

	printer_i: EV_RADIO_MENU_ITEM
	file_i: EV_RADIO_MENU_ITEM

	ok_button: EV_BUTTON
	cancel_button: EV_BUTTON

feature --Implementation

	fill_menu is
		local
			select_page_notebook: SELECT_PAGE_NOTEBOOK
			argument: EV_ARGUMENT1 [INTEGER]
		do
			if menu /= Void then	
				!! select_page_notebook.make (notebook)

				!! printer_i.make_with_text (menu.format_m, widget_names.printer)
				!! argument.make (1)
				printer_i.add_select_command (select_page_notebook, clone (argument))

				!! file_i.make_peer_with_text (menu.format_m, widget_names.file, printer_i)
				!! argument.make (2)
				file_i.add_select_command (select_page_notebook, clone (argument))
			end
		end
 
feature -- savable parameters

	get_height_name	: STRING	is "class_tool_height"
	
	get_width_name	: STRING	is "class_tool_width"

end -- class CLASS_WINDOW
