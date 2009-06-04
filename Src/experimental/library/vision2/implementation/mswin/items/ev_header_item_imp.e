note
	description: "Objects that represent EiffelVision2 header items. Mswin Implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_ITEM_IMP

inherit
	EV_HEADER_ITEM_I
		undefine
			pixmap_equal_to,
			parent
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			set_pixmap,
			remove_pixmap
		end

	EV_TEXT_ALIGNABLE_IMP
		redefine
			interface,
			align_text_left,
			align_text_center,
			align_text_right
		end

	WEL_HD_ITEM
		rename
			make as wel_make,
			set_text as wel_set_text,
			text as wel_text,
			initialize as wel_initialize,
			text_count as text_length
		undefine
			copy, is_equal
		redefine
			wel_set_text, set_width
		end

	WEL_HDF_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Make `Current' with `interface' `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			wel_make
			align_text_left
			set_width (80)
			set_text ("")
			set_is_initialized (True)
			user_can_resize := True
			maximum_width := 32000
		end

feature -- Status report

	parent_imp: detachable EV_HEADER_IMP
		-- Parent of `Current'

	user_can_resize: BOOLEAN
			-- Can a user resize `Current'?

	minimum_width: INTEGER
			-- Minimum width permitted for `Current'.

	maximum_width: INTEGER
			-- Maximum width permitted for `Current'.

feature -- Status setting

	set_parent_imp (par_imp: like parent_imp)
			-- Assign 'par_imp' to `parent_imp'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end

	wel_set_text (a_string: STRING_GENERAL)
			-- Set the text of the item to `a_string'
		do
			Precursor {WEL_HD_ITEM} (a_string)
			refresh
		end

	set_width (value: INTEGER)
			-- Sets width of item with `value'
			-- Also updates `mask'
		do
			Precursor {WEL_HD_ITEM} (value)
			refresh
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			minimum_width := a_minimum_width
			if width < minimum_width then
				set_width (minimum_width)
			end
		end

	set_maximum_width (a_maximum_width: INTEGER)
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			maximum_width := a_maximum_width
			if width > maximum_width then
				set_width (maximum_width)
			end
		end

	resize_to_content
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.resize_item_to_content (Current)
			end
		end

	set_pixmap (p: EV_PIXMAP)
			-- Assign `p' to the displayed pixmap.
		do
			if attached private_pixmap as l_private_pixmap then
				l_private_pixmap.destroy
			end
			private_pixmap := p.twin
			if parent_imp /= Void then
				set_pixmap_in_parent
			end
		end

	set_pixmap_in_parent
			-- Make `pix' the new pixmap of `Current'.
		local
			image_list: detachable EV_IMAGE_LIST_IMP
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			check l_parent_imp /= Void end
			image_list := l_parent_imp.image_list
			if image_list = Void then
				l_parent_imp.setup_image_list
				image_list := l_parent_imp.image_list
			end
			check image_list /= Void end
			if attached private_pixmap as l_private_pixmap then
				image_list.add_pixmap (l_private_pixmap)
					-- Set the `iimage' to the index of the image to be used
					-- from the image list.
				set_iimage (image_list.last_position)
			else
				set_mask (clear_flag (mask, {WEL_HDI_CONSTANTS}.hdi_image))
				set_format (clear_flag (format, {WEL_HDF_CONSTANTS}.hdf_image))
			end
			l_parent_imp.refresh_item (Current)
		end

	remove_pixmap
			-- Remove the pixmap from `Current'.
		do
			Precursor {EV_ITEM_IMP}
			if parent_imp /= Void then
				set_pixmap_in_parent
			end
		end

	align_text_center
			-- Display `text' centered.
		local
			l_format: INTEGER
		do
			if flag_set (mask, {WEL_HDI_CONSTANTS}.hdi_format) then
				l_format := format
			else
				l_format := 0
			end
		 	l_format := l_format & hdf_left.bit_not
			l_format := l_format & hdf_right.bit_not
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			set_format (l_format | hdf_center)
			refresh
		end

	align_text_right
			-- Display `text' right aligned.
		local
			l_format: INTEGER
		do
		 	if flag_set (mask, {WEL_HDI_CONSTANTS}.hdi_format) then
				l_format := format
			else
				l_format := 0
			end
		 	l_format := l_format & hdf_left.bit_not
			l_format := l_format & hdf_center.bit_not
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			set_format (l_format | hdf_right)
			refresh
		end

	align_text_left
			-- Display `text' left aligned.
		local
			l_format: INTEGER
		do
		 	if flag_set (mask, {WEL_HDI_CONSTANTS}.hdi_format) then
				l_format := format
			else
				l_format := 0
			end
		 	l_format := l_format & hdf_center.bit_not
			l_format := l_format & hdf_right.bit_not
			Precursor {EV_TEXT_ALIGNABLE_IMP}
			set_format (l_format | hdf_left)
			refresh
		end

	enable_user_resize
			-- Permit `Current' from being resized by users.
		do
			user_can_resize := True
		end

	disable_user_resize
			-- Prevent `Current' from being resized by users.
		do
			user_can_resize := False
		end

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
		end

feature {NONE} -- implementation

	refresh
			-- Refresh attributes of `Current' in `parent'.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.refresh_item (Current)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_HEADER_ITEM note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_HEADER_ITEM_IMP











