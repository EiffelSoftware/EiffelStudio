indexing
	description:
		"EiffelVision container. Allows only one children.%
		% Deferred class, parent of all the containers.%
		% Mswindows implementation."
	note: "This class would be the equivalent of a wel_composite_window%
		% in the wel hierarchy."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I

	EV_WIDGET_IMP
		redefine
			widget_make
		end

feature {NONE} -- Initialization

	widget_make (an_interface: EV_WIDGET) is
			-- Creation of the widget.
		do
			{EV_WIDGET_IMP} Precursor (an_interface)
			!! menu_items.make (1)
		end

feature -- Access

	client_width: INTEGER is
			-- Width of the client area of container
		do
			Result := client_rect.width
		end

	client_height: INTEGER is
			-- Height of the client area of container
		do
			Result := client_rect.height
		end

	already_displayed: BOOLEAN
			-- The behavior before and after displaying
			-- the container is different to gain some
			-- speed before the first displaying of the
			-- container.

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
		local
			par_imp: EV_CONTAINER_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				if parent_imp /= Void then
					parent_imp.remove_child (Current)
				end
				ww ?= par.implementation
				wel_set_parent (ww)
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
				par_imp.add_child (Current)
				if par_imp.already_displayed then
					on_first_display
				else
					already_displayed := False
				end
			elseif parent_imp /= Void then
				parent_imp.remove_child (Current)
				wel_set_parent (default_parent.item)
			end
		end

feature -- Assertion test

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := is_child (a_child)
		end

feature {EV_SIZEABLE_IMP} -- Implementation for automatic size compute

	child_minwidth_changed (value: INTEGER; the_child: EV_SIZEABLE_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
		do
			set_minimum_width (value)
		end

	child_minheight_changed (value: INTEGER; the_child: EV_SIZEABLE_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
		do
			set_minimum_height (value)
		end

feature {EV_MENU_HOLDER_IMP, EV_MENU_ITEM_HOLDER_IMP} -- Implementation

	menu_items: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- It can be only one list by container because
			-- all the ids must be different

feature {NONE} -- WEL Implementation

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			pixcon: EV_PIXMAPABLE_IMP
			itemcon: EV_ITEM_HOLDER_IMP
		do
			pixcon ?= draw_item.window_item
			if pixcon /= Void then
				pixcon.on_draw (draw_item)
			else
				itemcon ?= draw_item.window_item
				if itemcon /= Void then
					itemcon.on_draw (draw_item)
				end
			end
		end

	on_menu_command (menu_id: INTEGER) is
			-- The `menu_id' has been choosen from the menu.
			-- If this feature is called, it means that the 
			-- child is a menu.
		do
			menu_items.item(menu_id).on_activate
		end

   	background_brush: WEL_BRUSH is
   			-- Current window background color used to refresh the window when
   			-- requested by the WM_ERASEBKGND windows message.
   			-- By default there is no background  
		do
 			if exists and background_color_imp /= void then
 				!! Result.make_solid (background_color_imp)
 			end
 		end

feature {NONE} -- Implementation : deferred features

	client_rect: WEL_RECT is
		deferred
		end

end -- class EV_CONTAINER_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
