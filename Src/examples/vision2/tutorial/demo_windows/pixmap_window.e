indexing
	description:
		"The demo that goes with the pixmap demo";
	date: "$Date$";
	revision: "$Revision$"

class
	PIXMAP_WINDOW

inherit
	DEMO_WINDOW

	EV_VERTICAL_BOX
		redefine
			make
		end

	EV_COMMAND

	PIXMAP_PATH

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		local
			arg: EV_ARGUMENT1 [INTEGER]
		do
			{EV_VERTICAL_BOX} Precursor (Void)

			set_spacing (5)
			set_border_width (10)

			-- a button
			create button.make_with_text (Current, "Press me!")
			set_child_expandable (button, False)

			-- a toggle button
			create toggle_button.make_with_text (Current, "A toggle button")
			set_child_expandable (toggle_button, False)

			-- a check button
			create check_button.make (Current)
			check_button.set_text ("A check button")
			set_child_expandable (check_button, False)

			-- a radio button
			create radio_button.make_with_text (Current, "A first radio button")
			set_child_expandable (radio_button, False)
			create radio_button.make_with_text (Current, "A second radio button")
			set_child_expandable (radio_button, False)

			-- a combo box
			create combo.make (Current)
			create comboListItem.make_with_text (combo, "Combo item 1")
			create comboListItem.make_with_text (combo, "Combo item 2")
			set_child_expandable (combo, False)

			-- a Tree
			create tree.make (Current)
			create treeItem1.make_with_text (tree, "A tree Root")
			create treeItem2.make (treeItem1)
			treeItem2.set_text ("A tree item")
			create treeItem3.make (treeItem2)
			treeItem3.set_text ("A second tree item")
			treeItem2.set_text ("A first tree item")

			-- an option button
			create option.make (Current)
			create optionMenu.make_with_text (option, "An option button")
			create optionMenuItem.make_with_text (optionMenu, "option menu item 1")
			create optionMenuItem.make_with_text (optionMenu, "option menu item 2")
			set_child_expandable (option, False)

			-- a multi column list
			create mc.make_with_text (Current, <<"1st column", "2nd column", "3rd column">>)
			create mcrow1.make_with_text (mc, <<"I am", "row", "one">>)
			create mcrow2.make_with_text (mc, <<"I am", "row", "two">>)

			-- Catch some events
--			create arg.make (2)
--			button.add_click_command (Current, arg)

			-- create the pixmaps
			create buttonPix.make_from_file (pixmap_path ("open"))
			create checkPix.make_from_file (pixmap_path ("open"))
			create pix.make_from_file (pixmap_path ("open"))

			create pixArray.make (1,3)
			pixArray.force (pix, 1)
			pixArray.force (pix, 2)
			pixArray.force (pix, 3)
			mcrow1.set_pixmap (pixArray)

			-- atttach them to the widgets
			button.set_pixmap (buttonPix)
			treeItem3.set_pixmap (pix)
			check_button.set_pixmap (checkPix)
	--		optionMenuItem.set_pixmap (pix)
			radio_button.set_pixmap (pix)
			comboListItem.set_pixmap (pix)

			-- colors
			create color.make_rgb (0, 255, 0)		
			mc.set_foreground_color (color)
			create color.make_rgb (255, 0, 0)
			mc.set_background_color (color)

			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end

feature -- Test functions

	execute (arg: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
		-- function to test the resizing options
		local
		do
			inspect
				arg.first
			when 1 then
				if (button.pixmap = void) then
					button.set_pixmap (buttonPix)
					button.set_text ("Here is the pixmap.")
				else
					-- 1st passage here
					button.unset_pixmap
					button.set_text ("Where is the pixmap?")
				end
			when 2 then
				if (treeItem3.pixmap = void) then
					toggle_button.unset_pixmap
--					statitem2.unset_pixmap
--					statitem2.set_text ("lend me your pixmap!")
					treeItem2.unset_pixmap
					treeItem2.set_text ("I want my pixmap back")

--					mcrow1.set_cell_pixmap (3, pix)
					check_button.set_pixmap (checkPix)
--					menuitem.set_pixmap (pix)
--					menuitem.set_text ("Thank you!")
--					statitem1.set_pixmap (pix)
--					statitem1.set_text ("This is my pixmap!")
					treeItem3.set_pixmap (pix)
					treeItem3.set_text ("Thanks for your pixmap!")
				else
					-- 1st passage here
--					menuitem.unset_pixmap
--					menuitem.set_text ("Give me a pixmap.")
--					statitem1.unset_pixmap
--					statitem1.set_text ("Give me back my pixmap!")
					check_button.set_pixmap (pix)


				--	mcrow1.unset_cell_pixmap (3)

					treeItem3.unset_pixmap
					treeItem3.set_text ("Can I borrow your pixmap?")

					toggle_button.set_pixmap (pix)
					treeItem2.set_pixmap (pix)
					treeItem2.set_text ("I have my pixmap!")
--					statitem2.set_pixmap (pix)
--					statitem2.set_text ("I have your Pixmap!")
				end
			end
		end	

feature -- Access

	button: EV_BUTTON

	toggle_button: EV_TOGGLE_BUTTON

	check_button: EV_CHECK_BUTTON

	radio_button: EV_RADIO_BUTTON
	radioMenu: EV_MENU
	radioMenuItem: EV_MENU_ITEM

	option: EV_OPTION_BUTTON
	optionMenu: EV_MENU
	optionMenuItem: EV_MENU_ITEM

	tree: EV_TREE
	treeItem1, treeItem2, treeItem3: EV_TREE_ITEM

	statusbar: EV_STATUS_BAR
	statitem1, statitem2: EV_STATUS_BAR_ITEM

	menubar: EV_STATIC_MENU_BAR
	menu: EV_MENU
	menuitem: EV_MENU_ITEM
	menuRadioItem1, menuRadioItem2: EV_RADIO_MENU_ITEM

	mc: EV_MULTI_COLUMN_LIST
	mcrow1, mcrow2: EV_MULTI_COLUMN_LIST_ROW

	combo: EV_COMBO_BOX
	comboList: EV_LIST
	comboListItem: EV_LIST_ITEM

	list: EV_LIST
	listItem1, listItem2, listItem3: EV_LIST_ITEM

	buttonPix, checkPix: EV_PIXMAP
	pix: EV_PIXMAP

	color: EV_COLOR

	drawing: EV_DRAWING_AREA

	pixArray: ARRAY [EV_PIXMAP]

end -- class PIXMAP_WINDOW

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

