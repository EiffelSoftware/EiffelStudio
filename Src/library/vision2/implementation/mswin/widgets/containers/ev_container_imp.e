indexing
	description: "EiffelVision container. Allows only one children.%
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
			set_insensitive,
			on_first_display,
			plateform_build
		end

feature {NONE} -- Initialization

	plateform_build (par: EV_CONTAINER_I) is
			-- Plateform dependant initializations.
		do
			{EV_WIDGET_IMP} Precursor (par)
			!! menu_items.make (1)
			if parent_imp /= Void then
				already_displayed := parent_imp.already_displayed
			end	
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

feature -- Status report

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
   			-- `flag'.
		do
			if child /= Void then
				child.set_insensitive (flag)
			end
			{EV_WIDGET_IMP} Precursor (flag)
		end

feature -- Status setting

	destroy is
			-- Destroy the widget, but set the parent sensitive
			-- in case it was set insensitive by the child.
		do
			if parent_imp /= Void then
				parent_imp.set_insensitive (False)
			end
			wel_destroy
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite
		do
			child := child_imp
		end

feature {EV_MENU_CONTAINER_IMP} -- Implementation

	menu_items: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- It can be only one list by container because
			-- all the ids must be different

feature {EV_WIDGET_IMP} -- Implementation

	already_displayed: BOOLEAN
			-- The behavior before and after displaying
			-- the container is different to gain some
			-- speed before the first displaying of the
			-- container.

	update_display is
			-- Feature that update the actual container.
		do
			child.parent_ask_resize (client_width, client_height)
		end

	on_first_display is
		do
			if child /= Void then
				child.on_first_display
			end
			{EV_WIDGET_IMP} Precursor
			already_displayed := True
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

feature {NONE} -- WEL Implementation

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			pixcon: EV_PIXMAPABLE_IMP
			itemcon: EV_ITEM_CONTAINER_IMP
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
 			if background_color /= void then
 				!! Result.make_solid (background_color_imp)
 			end
 		end

feature -- Implementation : deferred features

	client_rect: WEL_RECT is
		deferred
		end

	wel_destroy is
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
