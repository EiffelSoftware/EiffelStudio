indexing
	description: "EiffelVision container. Allows only one children.%
				 % Deferred class, parent of all the containers.   %
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
			on_first_display
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

feature {EV_WIDGET_IMP} -- Implementation

	child_minwidth_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
		do
			set_minimum_width (value)
		end

	child_minheight_changed (value: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the minimum width of the container because
			-- the child changed his own minimum width.
		do
			set_minimum_height (value)
		end

	on_first_display is
		do
			if child /= Void then
				child.on_first_display
			end
			{EV_WIDGET_IMP} Precursor
		end

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			pixcon: EV_PIXMAP_CONTAINER_IMP
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


feature -- Implementation : deferred features of 
		-- WEL_COMPOSITE_WINDOW that are used here but not 
		-- defined

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
