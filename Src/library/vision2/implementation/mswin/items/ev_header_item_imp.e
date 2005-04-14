indexing
	description: "Objects that represent EiffelVision2 header items. Mswin Implementation."
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
			is_initialized := True
		end
		
feature -- Status report

	parent_imp: EV_HEADER_IMP
		-- Parent of `Current'

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

feature {NONE} -- implementation

	refresh is
			-- Refresh attributes of `Current' in `parent'.
		do
			if parent_imp /= Void then
				parent_imp.refresh_item (Current)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HEADER_ITEM

end -- class EV_HEADER_ITEM_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
