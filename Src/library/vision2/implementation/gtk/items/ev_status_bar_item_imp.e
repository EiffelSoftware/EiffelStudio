indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at the end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM_IMP

inherit
	EV_STATUS_BAR_ITEM_I

	EV_SIMPLE_ITEM_IMP
		rename
			set_width as widget_set_width
		export {NONE}
			box,
			label_widget,
			initialize,
			create_text_label
		redefine
			destroy,
			set_expand,
			make_with_text,
			set_text,
			text,
			set_pixmap,
			unset_pixmap
		end

creation
	make,
	make_with_text

feature -- Initialization

	make is
			-- Create the status bar item
		local
			a: ANY
		do
			widget := gtk_statusbar_new
			gtk_object_ref (widget)

			a := status_bar_description.to_c
			context_id := gtk_statusbar_get_context_id (widget, $a)
			message_id := 0
		end

	make_with_text (txt: STRING) is
			-- Create an item with `txt' as label
		do
			make
			set_text (txt)
		end

feature -- Access

	context_id: INTEGER

	message_id: INTEGER

	status_bar_description: STRING is "a status bar item"
		-- description string needed by gtk

feature -- Status report

	text: STRING

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item adapt its size to fit the space
			-- when the bar gets bigger.
		do
			gtk_widget_set_usize (widget, value, -1)
				-- set the minimum width but don't update `width'
			c_gtk_widget_set_size (widget, value, height)
				-- XX update `width'
			if (value = -1) then
				set_expand (True)
			else
				set_expand (False)
			end
		end

	set_expand (flag: BOOLEAN) is
			-- Make `flag' the new expand option.
			-- function redefines because older set_expand
			-- applies to widget_parent_imp intead
			-- of `parent_imp'
		do
			expandable := flag
			if parent_imp /= Void then
				c_gtk_box_set_child_options (parent_imp.widget, widget, expandable, True)
			end
		end

	destroy is
			-- Destroy the status bar item implementation.
			-- Feature redefined to set expand options for the
			-- last status bar item.
                do
			parent_imp.remove_status_bar_item (Current)
				-- we do not need to use 'gtk_widget_destroy'
				-- because the widget is automatically destroyed when
				-- no more affected to a parent.
			widget := default_pointer
				-- optionnal
		end
	
feature -- Element change

	set_text (txt: STRING) is
		-- set `text' to txt
		local
			a: ANY
		do
			-- first, check if there was already a message in the status bar
			-- if so, we remove it
			if message_id > 0 then
				gtk_statusbar_remove (widget, context_id, message_id)
			end

			-- set the message of the status bar
			a := txt.to_c
			message_id := gtk_statusbar_push (widget, context_id, $a)
			text := txt		
		end

	set_parent (par: EV_STATUS_BAR) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the screen.
			-- Before to remove the widget from the
			-- container, we increment the number of
			-- reference on the object otherwise gtk
			-- destroyed the object. And after having
			-- added the object to another container,
			-- we remove this supplementary reference.
		local
			par_imp: EV_STATUS_BAR_IMP
		do
			if parent_imp /= Void then
				gtk_object_ref (widget)
				parent_imp.remove_status_bar_item (Current)
				parent_imp := Void
			end
			if par /= Void then
				par_imp ?= par.implementation
				check
					parent_not_void: par_imp /= Void
				end
				parent_imp ?= par_imp
				par_imp.add_status_bar_item (Current)
				show
				gtk_object_unref (widget)
			end
		end
	
feature {NONE} -- Implementation

	set_pixmap (pix: EV_PIXMAP) is
			-- Add a pixmap in the status bar item
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pix.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end

			-- Create a GtkPixmap to put in the status bar and show it.
			if (pixmap = Void) then
				-- No pixmap, so create a GtkPixmap to put
				-- in the status bar and show it.
				pixmap_widget := c_gtk_statusbar_item_create_pixmap_place (widget)
			end

			-- We replace the former gdk_pixmap of the gtk_pixmap (in pixmap_widget)
			-- by the new one.
			c_gtk_pixmap_set_from_pixmap (pixmap_widget, pixmap_imp.widget) 

			-- updating status
			pixmap := pix
--			pixmap_imp.set_parent (Current)
		end

	unset_pixmap is
		local
			pixmap_imp: EV_PIXMAP_IMP
		do
			pixmap_imp ?= pixmap.implementation
			check
				pixmap_imp_not_void: pixmap_imp /= Void
			end

			-- Remove the pixmap from the status bar.
			-- `pixmap_widget' will be detroyed.
			c_gtk_statusbar_item_unset_pixmap (widget, pixmap_widget)

			-- updating status
			pixmap := Void
			set_pixmap_widget (default_pointer)
--			pixmap_imp.set_parent (Void)
		end

end -- class EV_STATUS_BAR_ITEM_IMP

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
