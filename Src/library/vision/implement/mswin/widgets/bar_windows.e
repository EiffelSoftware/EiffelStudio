indexing
	
	description: "This class represents a Windows bar menu."
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	BAR_WINDOWS

inherit
	ROOT_MENU_WINDOWS

	MENU_WINDOWS
		rename
			unrealize as menu_unrealize
		redefine
			realize,
			width,
			height,
			set_x, 
			set_y, 
			set_width, 
			set_height, 
			set_form_height, 
			set_form_width, 
			set_managed,
			set_size,
			x,y, 
			form_width, 
			form_height
		end	

	MENU_WINDOWS
		redefine
			realize,
			width,
			height,
			set_x, 
			set_y, 
			set_width, 
			set_height, 
			set_form_height, 
			set_form_width, 
			set_managed,
			set_size,
			x,y, 
			form_width, 
			form_height,
			unrealize
		select
			unrealize
		end	

	BAR_I

	SIZEABLE_WINDOWS

creation

	make

feature -- Initialization

	make (a_bar: BAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a bar.
		do
			parent ?= oui_parent.implementation
			!! private_attributes
			managed := man
			set_x (parent.x)
			set_y (parent.y)
			make_root
		end

	set_managed (flag: BOOLEAN) is
		do
			managed := flag
			if flag then
				if realized then
					if not exists then 
						realize
					end
					associated_shell.associate_bar (Current)
				elseif parent /= Void and then parent.realized then
					if not exists then
						realize
					end
					associated_shell.associate_bar (Current)
				end
			else
				if exists then
					associated_shell.remove_bar
					destroy_item
				end
			end
		end

	realize is
		local
			p: COMPOSITE_WINDOWS
			wm_shell: WM_SHELL_WINDOWS
		do
			if not exists then
				wel_make
			end
			reset
			realized := true
			associated_root ?= current
			realize_children
			associated_shell.associate_bar (Current)
			parent.child_has_resized
		end

	unrealize is
		do
			realized := false
			menu_unrealize
		end

feature -- Access

	help_button: MENU_B

	remove_popup (w: WIDGET_WINDOWS) is
			-- Remove a popup `w' from the menu.
		require
			realized: realized
		do
			delete_position (index_of (w) - unmanaged_count (w))
		end

feature -- Measurement

	form_height: INTEGER

	form_width: INTEGER

	width: INTEGER 

	height: INTEGER 

feature -- Status report

	x: INTEGER

	y: INTEGER

feature -- Status setting

	set_form_height (new_height: INTEGER) is
		do
			form_height := new_height
		end

	set_form_width (new_width: INTEGER) is
		do
			form_width := new_width
		end

	set_height (new_height: INTEGER) is
		do
			height := new_height
		end

	set_size (new_width, new_height: INTEGER) is
		do
			width := new_width
			height := new_height
		end

	set_width (new_width: INTEGER) is
		do
			width := new_width
		end

	set_x (new_x: INTEGER) is
		do
			x := new_x
		end

	set_y (new_y: INTEGER) is
		do
			y := new_y
		end

feature -- Element change

	set_help_button (button: MENU_B) is
		do
			help_button := button
		end

end -- class BAR_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
