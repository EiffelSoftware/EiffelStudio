indexing
	description	: "Pixmaps, Multi-Column List & Trees..."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	MULTICOLUMN_LIST_EXAMPLE

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
			-- Initialize world.
		local
			button_container: EV_HORIZONTAL_BOX
		do
			create my_icon
			my_icon.set_with_named_file ("eiffel.png")

			create my_icon2
			my_icon2.set_with_named_file ("eiffeldoc.png")


				-- Create the container
			create my_container

			create my_tree

			create tvitem1
			tvitem1.set_text ("Item1")
			create tvitem2
			tvitem2.set_text ("Item1-1")
			tvitem1.extend (tvitem2)
			create tvitem3
			tvitem3.set_text ("Item1-2")
			tvitem1.extend (tvitem3)

			create tvitem2
			tvitem2.set_text ("Item2")
			create tvitem3
			tvitem3.set_text ("Item2-1")
			tvitem2.extend (tvitem3)

			create tvitem3
			tvitem3.set_text ("Item3")

			my_tree.extend (tvitem1)
			my_tree.extend (tvitem2)
			my_tree.extend (tvitem3)

				-- create the List
			create my_mclist

			create mcrow1
			mcrow1.extend ("row1-1")
			mcrow1.extend ("row1-2")
			my_mclist.extend (mcrow1)

			create mcrow2
			mcrow2.extend ("row2-1")
			mcrow2.extend ("row2-2")
			my_mclist.extend (mcrow2)

			create mcrow3
			mcrow3.extend ("row3-1")
			mcrow3.extend ("row3-2")
			my_mclist.extend (mcrow3)

			mcrow1.extend ("row1-3")
			mcrow3.extend ("row3-3")
			mcrow2.extend ("row2-3")

			create add_pixmap_button
			add_pixmap_button.set_text ("Add pixmaps")
			add_pixmap_button.select_actions.extend (~add_pixmap_button_pushed)
			create remove_pixmap_button
			remove_pixmap_button.set_text ("Remove pixmaps")
			remove_pixmap_button.select_actions.extend (~remove_pixmap_button_pushed)
			create size_pixmap_button
			size_pixmap_button.set_text ("Pixmaps Size")
			size_pixmap_button.set_value (16)
			size_pixmap_button.change_actions.extend (~size_pixmap_button_pushed)
			create large_pixmap_button
			large_pixmap_button.set_text ("Large pixmaps")
			large_pixmap_button.select_actions.extend (~large_pixmap_button_pushed)
			create small_pixmap_button
			small_pixmap_button.set_text ("Small pixmaps")
			small_pixmap_button.select_actions.extend (~small_pixmap_button_pushed)


			create button_container
			button_container.set_padding (10)
			button_container.seT_border_width (5)
			button_container.extend(add_pixmap_button)
			button_container.extend(remove_pixmap_button)
			button_container.extend(size_pixmap_button)
			button_container.extend(small_pixmap_button)
			button_container.extend(large_pixmap_button)
			button_container.disable_item_expand (add_pixmap_button)
			button_container.disable_item_expand (remove_pixmap_button)
			button_container.disable_item_expand (small_pixmap_button)
			button_container.disable_item_expand (large_pixmap_button)

			small_pixmap_button.disable_sensitive
			large_pixmap_button.disable_sensitive
			size_pixmap_button.disable_sensitive

			my_container.extend(my_mclist)
			my_container.extend(my_tree)
			my_container.extend(button_container)
			my_container.disable_item_expand (button_container)

				-- Add widgets to our window
			first_window.extend(my_container)
		end

	first_window: EV_TITLED_WINDOW is
			-- The window with the drawable area.
		once
			create Result
			Result.set_title ("Vision2 MulticolumnList example")
			Result.set_size (500, 500)
		end

	add_pixmap_button_pushed is
		do
			mcrow1.set_pixmap (my_icon)
			tvitem1.set_pixmap (my_icon)

			mcrow2.set_pixmap (my_icon2)
			tvitem2.set_pixmap (my_icon2)

			small_pixmap_button.enable_sensitive
			large_pixmap_button.enable_sensitive
			size_pixmap_button.enable_sensitive
		end	

	remove_pixmap_button_pushed is
		do
			mcrow1.remove_pixmap
			mcrow2.remove_pixmap
			tvitem1.remove_pixmap
			tvitem2.remove_pixmap

			small_pixmap_button.disable_sensitive
			large_pixmap_button.disable_sensitive
			size_pixmap_button.disable_sensitive
		end	

	large_pixmap_button_pushed is
		do
			my_mclist.set_pixmaps_size (32, 32)
			my_tree.set_pixmaps_size (32, 32)
			size_pixmap_button.set_value (32)
		end	

	small_pixmap_button_pushed is
		do
			my_mclist.set_pixmaps_size (16, 16)
			my_tree.set_pixmaps_size (16, 16)
			size_pixmap_button.set_value (16)
		end	

	size_pixmap_button_pushed is
		local
			pix_size: INTEGER
		do
			pix_size := size_pixmap_button.value
			my_mclist.set_pixmaps_size (pix_size, pix_size)
			my_tree.set_pixmaps_size (pix_size, pix_size)
		end	

feature {NONE} -- Graphical interface

	add_pixmap_button: EV_BUTTON
	remove_pixmap_button: EV_BUTTON
	size_pixmap_button: EV_SPIN_BUTTON
	small_pixmap_button: EV_BUTTON
	large_pixmap_button: EV_BUTTON

	mcrow2: EV_MULTI_COLUMN_LIST_ROW
	mcrow1: EV_MULTI_COLUMN_LIST_ROW
	mcrow3: EV_MULTI_COLUMN_LIST_ROW
	tvitem1: EV_TREE_ITEM
	tvitem2: EV_TREE_ITEM
	tvitem3: EV_TREE_ITEM

	my_icon: EV_PIXMAP
	my_icon2: EV_PIXMAP

	my_tree: EV_TREE

	my_container: EV_VERTICAL_BOX
			-- Container that groups the pixmaps.

	my_mclist: EV_MULTI_COLUMN_LIST

feature -- Process Vision2 events
	
end -- class MULTICOLUMN_LIST_EXAMPLE

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

