indexing
	description	: "Simple drawing program."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_LIST_EXAMPLE

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			an_item: EV_LIST_ITEM
			i: INTEGER
			a_menu_bar: EV_MENU_BAR
			a_menu: EV_MENU
			a_menu_item: EV_MENU_ITEM
			a_menu_separator: EV_MENU_SEPARATOR
		do
				-- create Menus & menu items
			create a_menu_bar
			create a_menu.make_with_text ("Actions")
			create a_menu_item.make_with_text ("Get Selected Item(s)")
			a_menu_item.select_actions.extend (~get_selected_items)
			a_menu.extend (a_menu_item)
			create a_menu_item.make_with_text ("Select All Items")
			a_menu_item.select_actions.extend (~select_all_items)
			a_menu.extend (a_menu_item)
			create a_menu_item.make_with_text ("Enable Multiple Selection")
			a_menu_item.select_actions.extend (~enable_multiple_selection)
			a_menu.extend (a_menu_item)
			create a_menu_item.make_with_text ("Disable Multiple Selection")
			a_menu_item.select_actions.extend (~disable_multiple_selection)
			a_menu.extend (a_menu_item)
			create a_menu_separator
			a_menu.extend (a_menu_separator)
			create a_menu_item.make_with_text ("Exit")
			a_menu_item.select_actions.extend (~exit_application)
			a_menu.extend (a_menu_item)
			a_menu_bar.extend (a_menu)
			first_window.set_menu_bar (a_menu_bar)

				-- Create the container
			create my_container

			create my_label

			create my_list
			my_list.enable_multiple_selection

			create an_item.make_with_text ("Item "+i.out)
			an_item.pointer_motion_actions.extend (~toto)
			my_list.extend (an_item)

			from
				i := 1
			until
				i > 50
			loop
				create an_item.make_with_text ("Item "+i.out)
				my_list.extend (an_item)
				i := i + 1
			end

			my_list.select_actions.extend (~report_selected)
			my_list.deselect_actions.extend (~report_selected)

			my_container.extend (my_list)
			my_container.extend (my_label)

				-- Add widgets to our window
			first_window.extend(my_container)

		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 EV_LIST example")
			Result.set_size (800, 400)
		end

feature {NONE} -- Graphical interface

	my_list: EV_LIST
	my_label: EV_LABEL

	my_combo: EV_COMBO_BOX
	
	my_menu: EV_MENU
 
	my_container: EV_HORIZONTAL_BOX
			-- Container that groups the da.

feature {NONE} -- Implementation
	
	exit_application is
			-- Quit the program
		do
			first_window.destroy
		end

	toto (a_x, a_y: INTEGER; a_x_tilt, a_y_title, a_pressure: DOUBLE; a_sx, a_sy: INTEGER) is
			-- Display the selected items
		local
			label_string: STRING
		do
			create label_string.make (40)
			label_string.append ("Mouse Move !!")
		end

	report_selected (an_item: EV_LIST_ITEM) is
			-- Display the selected items
		local
			selected_items: LINEAR [EV_LIST_ITEM]
			label_string: STRING
			i: INTEGER
		do
			create label_string.make (40)
			label_string.append ("Selected items: %N")
			selected_items := my_list.selected_items
			from
				selected_items.start
				i := 0
			until
				selected_items.after
			loop
				label_string.append (selected_items.item.text)
				label_string.append (", ")
				if (i \\ 8) = 7 then 
					label_string.append ("%N")
				end
				selected_items.forth
				i := i + 1
			end
			label_string := label_string.substring (1, label_string.count - 2)

			my_label.set_text(label_string)
		end

	get_selected_items is
			-- Display the selected items
		local
			selected_items: LINEAR [EV_LIST_ITEM]
		do
			selected_items := my_list.selected_items
			from
				selected_items.start
			until
				selected_items.after
			loop
				io.putstring (selected_items.item.text)
				io.new_line
				selected_items.forth
			end
		end

	select_all_items is
			-- Select all items
		do
			from
				my_list.start
			until
				my_list.after
			loop
				my_list.item.enable_select
				my_list.forth
			end
		end

	enable_multiple_selection is
			-- Enable multiple selection 
		do
			my_list.enable_multiple_selection
		end

	disable_multiple_selection is
			-- Disable multiple selection 
		do
			my_list.disable_multiple_selection
		end

end -- class EV_LIST_EXAMPLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

