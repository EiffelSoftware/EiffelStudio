indexing

	description: 
		"Motif implementation of a split window.";
	date: "$Date$";
	revision: "$Revision $"

class SPLIT_WINDOW_IMP

inherit
	SPLIT_WINDOW_I

	MANAGER_I;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			is_paned_window
		redefine
			set_background_color_from_imp,
			realize, set_size
		end;

	MEL_PANED_WINDOW
		rename
			make as mel_paned_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		redefine
			realize, set_size
		end

creation

	make

feature {NONE} -- Initialization

	make (a_window: SPLIT_WINDOW; oui_parent: COMPOSITE; vertical:BOOLEAN) is
			-- Create a motif frame.
		require
			a_window_not_void: a_window /= Void
			oui_parent_not_void: oui_parent /= Void
		do
			parent ?= oui_parent.implementation;
			is_vertical := vertical
			split_visible := True
			proportion := 50

			widget_index := widget_manager.last_inserted_position;
			mel_paned_make ("", parent, True);

			if is_vertical then
				-- the convention for VISION is the opposite of MOTIF
				set_horizontal
			else
				set_vertical
			end
			set_margin_height (0);
			set_margin_width (0);
			set_spacing (split_width);
--			enable_refigure_mode
--			enable_resize_requests
			manage
		end

feature -- Access

	first_child: SPLIT_WINDOW_CHILD
			-- Child above the top most split if not `is_vertical'
			-- Child next the left most split otherwise

	second_child: SPLIT_WINDOW_CHILD
			-- Child below the bottom most split if not `is_vertical'
			-- Child next the right most split otherwise

	split_position: INTEGER
			-- Position of the top split relative to Current

	split_size: INTEGER
			-- Size of the split window.
			--| Depending on the value of `is_vertical', it can be the
			--| height or the width

	split_width: INTEGER is 10
			-- width of either split

	split_visible: BOOLEAN

feature -- Element change

	set_proportion (p:INTEGER) is
			-- Set the split proportion from 0 to 100.
		do
			proportion := p
		end

	update_split, realize is
			-- Create the actual Windows window.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= parent

			set_height (mc.height)
			set_width (mc.width)

			if is_vertical then
				split_size := mc.width
			else
				split_size := mc.height
			end

			if split_visible then
				split_position := (split_size * proportion) // 100
			end
			resize_children
		end


	set_default_split_size is
			-- Set default split size after realization
		local
			mc: MEL_COMPOSITE
		do
			mc ?= parent
			set_height (mc.height)
			set_width (mc.width)
			if is_vertical then	
				split_size := mc.width
			else
				split_size := mc.height
			end

			if split_visible then
				split_position := (split_size * proportion) // 100
			end
			resize_children
		end

feature --Status setting

	set_size (new_width:INTEGER; new_height: INTEGER) is
		do
			{MEL_PANED_WINDOW} Precursor (new_width,new_height)
			if managed then
				if is_vertical then
					split_size := new_width
				else
					split_size := new_height
				end

				if split_visible then
					if split_position > split_size then
						split_position := split_size - split_width
					end
				else
					split_position := split_size
				end
	
				resize_children
			end
		end

feature -- Sizing policy

	child_has_resized is
		-- Respond to resizing from children
		do
io.put_string ("%NChild has resized%N")
			if first_child /= Void and then
			   first_child.managed
			then
				resize_first_child
			end

			if second_child /= Void and then
			   second_child.managed
			then
				resize_second_child
			end
		end

feature -- Element change

	set_first_child (a_child: SPLIT_WINDOW_CHILD) is
			-- set `first_child' to `a_child'
		require
			a_child_not_void: a_child /= Void
		do
			first_child := a_child
		ensure
			first_child_set: first_child = a_child
		end

	set_second_child (a_child: SPLIT_WINDOW_CHILD) is
			-- set `second_child' to `a_child'
		require
			a_child_not_void: a_child /= Void
		do
			second_child := a_child

		ensure
			second_child_set: second_child = a_child
		end

	remove_first_child is
			-- Remove `first_child' from the display
		do
		end

	remove_second_child is
			-- Remove `second_child' from the display
		do			
		end

feature -- Implementation

	add_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as currently lowest child.
		do
			if first_child = Void then
				set_first_child (a_child)
			else
				set_second_child (a_child)
			end
		end

	remove_child (a_child: SPLIT_WINDOW_CHILD) is
			-- Remove `a_child' from the display.
		do
			if first_child = Void then
				remove_first_child
			else
				remove_second_child
			end
		end

	add_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Add `a_window' as managed.
		do
			resize_children
		end

	remove_managed_child (a_window: SPLIT_WINDOW_CHILD) is
			-- Remove `a_window' as managed.
		do
			resize_children
		end

feature -- {NONE} -- Implementation

	resize_first_child is
			-- Resize the top child to the correct dimensions.
		require
			not_void: Current /= Void
		do
debug ("SPLIT")
	io.put_string ("%N FSW-width=")
	io.put_integer (width)
	io.put_string ("%T FSW-height=")
	io.put_integer (height)
	io.put_string ("%N")
end

			if is_vertical then
				first_child.set_size ((width * proportion) // 100, height)
			else
				first_child.set_size (width, (height * proportion) // 100 )
			end
		end

	resize_second_child is
			-- Resize the bottom child to the correct dimensions.
		require
			not_void: Current /= Void
		do
debug ("SPLIT")
	io.put_string ("%N SSW-width=")
	io.put_integer (width)
	io.put_string ("%T SSW-height=")
	io.put_integer (height)
	io.put_string ("%N")
end
			if is_vertical then
				second_child.set_size ( (width * ( 100 - proportion)) // 100 - split_width, height)
			else
				second_child.set_size ( width, (height * ( 100 - proportion)) // 100 - split_width)
			end
		end

	resize_children is
			-- Resize the two children if they are managed
		do
			if parent.realized then
				if second_child /= Void and then second_child.managed then
					resize_second_child
				end

				if first_child /= Void and then first_child.managed then
					resize_first_child
				end
			end
		end

feature -- Status setting

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		local
			list: like children;
			color_id: POINTER
		do
			mel_set_background_color (color_imp);
			color_id := color_imp.identifier;
			list := children;
			from
				list.start
			until
				list.after
			loop
				if xm_is_sash (list.item) then
					xm_change_color (list.item, color_id);
				end;
				list.forth
			end
		end;

end -- class SPLIT_WINDOW_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

