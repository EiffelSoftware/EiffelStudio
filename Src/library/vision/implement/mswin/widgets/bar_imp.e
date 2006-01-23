indexing
	
	description: "This class represents a Windows bar menu."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	BAR_IMP

inherit
	ROOT_MENU_WINDOWS

	MENU_IMP
		redefine
			unrealize,
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
			real_x, real_y,
			form_width, 
			form_height,
			set_insensitive,
			invalidate
		end	

	BAR_I

	SIZEABLE_WINDOWS

create

	make

feature -- Initialization

	make (a_bar: BAR; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Make a bar.
		do
			parent ?= oui_parent.implementation
			create private_attributes
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
		do
			if not exists then
				wel_make
			end
			reset
			realized := true
			associated_root ?= Current
			realize_children
			associated_shell.associate_bar (Current)
			parent.child_has_resized
 				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end
		end

	unrealize is
		do
			realized := false
			Precursor
		end

feature -- Access

	help_button: MENU_B

	remove_popup (w: WIDGET_IMP) is
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
 
	height: INTEGER is
		local
			system_font: WEL_SYSTEM_FONT
		do
			create system_font.make
			Result := system_font.log_font.height
		end
	
feature -- Status report

 	x: INTEGER

	y: INTEGER
 
 	real_x: INTEGER is
 		require else
 			parent: parent /= Void
 		do
 			Result := parent.real_x
 		end

	real_y: INTEGER is
		require else
			parent: parent /= Void
		do
			Result := parent.real_y - height
		end

feature -- Status setting

	set_form_height (new_height: INTEGER) is
		do
			form_height := new_height
		end

	set_form_width (new_width: INTEGER) is
		do
			form_width := new_width
		end

 	set_size (new_width, new_height: INTEGER) is
 		do
 			width := new_width
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

	set_insensitive (flag: BOOLEAN) is
		local
			i: INTEGER
		do
			from
				i := 1
			until 
				i > children.count
			loop
				set_insensitive_widget (children.item (i), flag)
				i := i + 1
			end
			private_attributes.set_insensitive (flag)
			invalidate
		end

	invalidate is
		do
			associated_shell.associate_bar (Current)
		end
feature -- Inapplicable

 	set_height (new_height: INTEGER) is
		do
		end

feature -- Element change

	set_help_button (button: MENU_B) is
		do
			help_button := button
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class BAR_IMP

