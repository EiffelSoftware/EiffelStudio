indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at the end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM_IMP

inherit
	EV_STATUS_BAR_ITEM_I
		rename
		export
		undefine
		redefine
		select
		end

	EV_ITEM_IMP
		rename
			set_width as widget_set_width
		redefine
			destroy,
			make_with_text,
			set_expand,
			set_text,
			text
		end

creation
	make,
	make_with_text,
	make_with_pixmap,
	make_with_all


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
		local
			a1, a2: ANY
		do
			widget := gtk_statusbar_new
			gtk_object_ref (widget)

			a1 := status_bar_description.to_c
			a2 := txt.to_c
			context_id := gtk_statusbar_get_context_id (widget, $a1)
			message_id := gtk_statusbar_push (widget, context_id, $a2)

			text := txt
		ensure then
			text_set: text.is_equal (txt)
		end

	make_with_pixmap (pix: EV_PIXMAP) is
			-- Create an item with `par' as parent and `pix'
			-- as pixmap.
		do
--			make
--			-- Not implemented
		end

	make_with_all (txt: STRING; pix: EV_PIXMAP) is
			-- Create an item with `par' as parent, `txt' as text
			-- and `pix' as pixmap.
		do
--			make_with_text (txt)
			-- Not implemented
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
			-- Feature redefined to set expand options
                do
			parent_imp.remove_status_bar_item (Current)
			if not destroyed then
	                        gtk_widget_destroy (widget)
			end
			widget := Default_pointer
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

invariant
	invariant_clause: -- Your invariant here

end -- class EV_STATUS_BAR_ITEM_IMP
