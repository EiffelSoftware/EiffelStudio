indexing
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

	make (an_interface: like interface) is
			-- Make `Current' with `interface' `an_interface'.
		do
			wel_make
			base_make (an_interface)
			align_text_left
		end
		
	initialize is
			-- Initialize `Current'.
		do
			set_width (80)
			set_text ("")
			set_is_initialized (True)
			user_can_resize := True
			maximum_width := 32000
		end
		
feature -- Status report

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'
		
	user_can_resize: BOOLEAN
			-- Can a user resize `Current'?
			
	minimum_width: INTEGER
			-- Minimum width permitted for `Current'.
			
	maximum_width: INTEGER
			-- Maximum width permitted for `Current'.

feature -- Status setting

	set_parent_imp (par_imp: like parent_imp) is
			-- Assign 'par_imp' to `parent_imp'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end
		
	wel_set_text (a_string: STRING) is
			-- Set the text of the item to `a_string'
		do
			Precursor {WEL_HD_ITEM} (a_string)
			refresh
		end
		
	set_width (value: INTEGER) is
			-- Sets width of item with `value'
			-- Also updates `mask'
		do
			Precursor {WEL_HD_ITEM} (value)
			refresh
		end
		
	set_minimum_width (a_minimum_width: INTEGER) is
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
		do
			minimum_width := a_minimum_width
			if width < minimum_width then
				set_width (minimum_width)
			end
		end
		
	set_maximum_width (a_maximum_width: INTEGER) is
			-- Assign `a_maximum_width' in pixels to `maximum_width'.
			-- If `width' is greater than `a_maximum_width', resize.
		do
			maximum_width := a_maximum_width
			if width > maximum_width then
				set_width (maximum_width)
			end
		end
		
	resize_to_content is
			-- Resize `Current' to fully display both `pixmap' and `text'.
			-- As size of `text' is dependent on `font' of `parent', `Current'
			-- must be parented.
		do
			parent_imp.resize_item_to_content (Current)
		end
		
	set_pixmap (p: EV_PIXMAP) is
			-- Assign `p' to the displayed pixmap.
		do
			if private_pixmap /= Void then
				private_pixmap.destroy
				private_pixmap := Void
			end
			private_pixmap := p.twin
			if parent_imp /= Void then
				set_pixmap_in_parent
			end
		end

	set_pixmap_in_parent is
			-- Make `pix' the new pixmap of `Current'.
		local
			image_list: EV_IMAGE_LIST_IMP
		do
			image_list := parent_imp.image_list
			if image_list = Void then
				parent_imp.setup_image_list
				image_list := parent_imp.image_list
			end
			if private_pixmap /= Void then
				image_list.add_pixmap (private_pixmap)
					-- Set the `iimage' to the index of the image to be used
					-- from the image list.
				set_iimage (image_list.last_position)
			else
				set_mask (clear_flag (mask, {WEL_HDI_CONSTANTS}.hdi_image))
				set_format (clear_flag (format, {WEL_HDF_CONSTANTS}.hdf_image))
			end
			parent_imp.refresh_item (Current)
		end
		
	remove_pixmap is
			-- Remove the pixmap from `Current'.
		do
			Precursor {EV_ITEM_IMP}
			if parent_imp /= Void then
				set_pixmap_in_parent
			end
		end
		
	align_text_center is
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

	align_text_right is
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
        
	align_text_left is
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
		
	enable_user_resize is
			-- Permit `Current' from being resized by users.
		do
			user_can_resize := True
		end

	disable_user_resize is
			-- Prevent `Current' from being resized by users.
		do
			user_can_resize := False
		end
		
feature {NONE} -- implementation

	refresh is
			-- Refresh attributes of `Current' in `parent'.
		do
			if parent_imp /= Void then
				parent_imp.refresh_item (Current)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HEADER_ITEM;

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




end -- class EV_HEADER_ITEM_IMP

