indexing

	description: 
		"Implementation of XpmAttribute structure";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XPM_ATTRIBUTES

inherit

	MEL_MEMORY

creation
	make,
	make_from_existing

feature {NONE} -- Initialization

	make is
			-- Allocate the associated C structure.
		do
			handle := c_malloc (xpm_attributes_size);
			if handle = default_pointer then
					-- No more memory
				c_enomem
			else
				set_xpm_attributes_valuemask (handle, 0)
			end	
		end;

feature -- Access

	colormap: MEL_COLORMAP is
			-- Colormap used for allocation of color pixels
		do
			!! Result.make_from_existing (xpm_attributes_colormap (handle))
		end;

	number_of_colors: INTEGER is
			-- Number of colors
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_ncolors (handle)
		end;

	x_hotspot: INTEGER is
			-- X hotspot coordinate of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_x_hotspot (handle)
		end;

	y_hotspot: INTEGER is
			-- Y hotspot coordinate of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_y_hotspot (handle)
		end;

	height: INTEGER is
			-- Height of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_height (handle)
		end;

	width: INTEGER is
			-- Height of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_width (handle)
		end;

feature -- Status report

	valuemask: INTEGER is
			-- Valuemask to specify which attributes are defined
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_value_mask (handle)
		end;

feature -- Status setting

	set_valuemask (masks: INTEGER) is
			-- Set `valuemask' to `masks'.
		require
			is_valid: is_valid
		do
			set_xpm_attributes_valuemask (handle, masks)
		ensure
			set: valuemask = masks
		end;

feature -- Removal

	destroy is
			-- Destroy the color allocated for the structure
			-- and the XpmStructure itself.
		do
			if destroy_attributes then
				xpm_free_attributes (handle);
			end;
			x_free (handle);
			handle := default_pointer
		end;

feature {MEL_XPM_FORMAT} -- Implementation

	destroy_attributes: BOOLEAN;
			-- Destroy the attribute content?
			--| Can only be destroyed if it is initialized

	set_destroy_attributes is
			-- Set `destroy_attributes' to True.
		do
			destroy_attributes := True
		ensure
			destroy_attributes: destroy_attributes
		end;

	unset_destroy_attributes is
			-- Set `destroy_attributes' to False.
		do
			destroy_attributes := False
		ensure
			not_destroy_attributes: not destroy_attributes
		end;

feature {NONE} -- Externals

	c_malloc (a_size: INTEGER): POINTER is
			-- C malloc
		external
			"C (unsigned int): EIF_POINTER | %"eiffel.h%""
		alias
			"cmalloc"
		end;
	
	x_free (ptr: POINTER) is
			-- C free
		external
			"C (char *) | %"eiffel.h%""
		alias
			"xfree"
		end;

	c_enomem is
			-- Eiffel run-time function to raise an
			-- "Out of memory" exception.
		external
			"C"
		alias
			"enomem"
		end;

	xpm_free_attributes (ptr: POINTER) is
		external
			"C (XpmAttributes *) | %"xpm.h%""
		alias
			"XpmFreeAttributes"
		end;

	set_xpm_attributes_valuemask (ptr: POINTER; a_mask: INTEGER) is
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, unsigned long)"
		end;

	xpm_attributes_size: INTEGER is
		external
			"C"
		alias
			"XpmAttributesSize"
		end;

	xpm_attributes_colormap (h: POINTER): POINTER is
			-- Colormap used
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_POINTER"
		alias
			"xpm_attributes_colormap"
		end;

	xpm_attributes_ncolors (h: POINTER): INTEGER is
			-- Number of colors
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_x_hotspot (h: POINTER): INTEGER is
			-- X hotspot coordinate of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_y_hotspot (h: POINTER): INTEGER is
			-- Y hotspot coordinate of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_height (h: POINTER): INTEGER is
			-- Height of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_width (h: POINTER): INTEGER is
			-- Height of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_value_mask (h: POINTER): INTEGER is
			-- Valuemask value of attribute structure
		require
			is_valid: is_valid
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		alias
			"xpm_attributes_value_mask"
		end;

end -- class MEL_XPM_ATTRIBUTE
