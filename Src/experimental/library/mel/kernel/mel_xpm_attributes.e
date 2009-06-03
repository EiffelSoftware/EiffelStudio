note

	description: 
		"Implementation of XpmAttribute structure"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XPM_ATTRIBUTES

inherit

	MEL_MEMORY

create
	make,
	make_from_existing

feature {NONE} -- Initialization

	make
			-- Allocate the associated C structure.
		do
			handle := c_malloc (xpm_attributes_size);
			if handle = default_pointer then
					-- No more memory
				c_enomem
			else
				set_xpm_attributes_valuemask (handle,0)
			end	
		end;

feature -- Access


	colormap: MEL_COLORMAP
			-- Colormap used for allocation of color pixels
		do
			create Result.make_from_existing (xpm_attributes_colormap (handle))
		end;

	number_of_colors: INTEGER
			-- Number of colors
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_ncolors (handle)
		end;

	alloc_close_colors: BOOLEAN
			-- Search for closest color to alloc
		do
			Result := xpm_attributes_alloc_close_colors (handle)
		end;

	red_closeness: INTEGER
			-- authorized red difference from wanted color while allocation
		do
			Result := xpm_attributes_red_closeness (handle)
		end;

	green_closeness: INTEGER
			-- authorized green difference from wanted color while allocation
		do
			Result := xpm_attributes_green_closeness (handle)
		end;

	blue_closeness: INTEGER
			-- authorized blue difference from wanted color while allocation
		do
			Result := xpm_attributes_blue_closeness (handle)
		end;

	x_hotspot: INTEGER
			-- X hotspot coordinate of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_x_hotspot (handle)
		end;

	y_hotspot: INTEGER
			-- Y hotspot coordinate of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_y_hotspot (handle)
		end;

	height: INTEGER
			-- Height of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_height (handle)
		end;

	width: INTEGER
			-- Height of created pixmap
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_width (handle)
		end;

feature -- Status report

	valuemask: INTEGER
			-- Valuemask to specify which attributes are defined
		require
			is_valid: is_valid
		do
			Result := xpm_attributes_value_mask (handle)
		end;

feature -- Status setting

	set_valuemask (masks: INTEGER)
			-- Set `valuemask' to `masks'.
		require
			is_valid: is_valid
		do
			set_xpm_attributes_valuemask (handle, masks)
		ensure
			set: valuemask = masks
		end;

	set_red_closeness (closeness : INTEGER)
		-- Set red_closeness to closeness
		-- Don't forget to put XpmRGBCloseness flag in valuemask
		require
			is_valid: is_valid
		do
			set_xpm_attributes_red_closeness (handle, closeness)
		ensure
			set: red_closeness = closeness
		end;

	set_green_closeness (closeness : INTEGER)
		-- Set green_closeness to closeness
		-- Don't forget to put XpmRGBCloseness flag in valuemask
		require
			is_valid: is_valid
		do
			set_xpm_attributes_green_closeness (handle, closeness)
		ensure
			set: green_closeness = closeness
		end;

	set_blue_closeness (closeness : INTEGER)
		-- Set blue_closeness to closeness
		-- Don't forget to put XpmRGBCloseness flag in valuemask
		require
			is_valid: is_valid
		do
			set_xpm_attributes_blue_closeness (handle, closeness)
		ensure
			set: blue_closeness = closeness
		end;

feature -- Removal

	destroy
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

	set_destroy_attributes
			-- Set `destroy_attributes' to True.
		do
			destroy_attributes := True
		ensure
			destroy_attributes: destroy_attributes
		end;

	unset_destroy_attributes
			-- Set `destroy_attributes' to False.
		do
			destroy_attributes := False
		ensure
			not_destroy_attributes: not destroy_attributes
		end;

feature {NONE} -- Externals

	c_malloc (a_size: INTEGER): POINTER
			-- C malloc
		external
			"C (unsigned int): EIF_POINTER | %"eif_eiffel.h%""
		alias
			"cmalloc"
		end;
	
	x_free (ptr: POINTER)
			-- C free
		external
			"C (char *) | %"eif_eiffel.h%""
		alias
			"xfree"
		end;

	c_enomem
			-- Eiffel run-time function to raise an
			-- "Out of memory" exception.
		external
			"C"
		alias
			"enomem"
		end;

	xpm_free_attributes (ptr: POINTER)
		external
			"C (XpmAttributes *) | %"xpm.h%""
		alias
			"XpmFreeAttributes"
		end;

	set_xpm_attributes_valuemask (ptr: POINTER; a_mask: INTEGER)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, unsigned long)"
		end;

	set_xpm_attributes_alloc_close_colors (ptr: POINTER; c_mode: BOOLEAN)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, EIF_BOOLEAN)"
		end;

	set_xpm_attributes_colors_closeness (ptr: POINTER; degree: INTEGER)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, unsigned long)"
		end;
	
	set_xpm_attributes_red_closeness (ptr: POINTER; degree: INTEGER)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, unsigned long)"
		end;
		
	set_xpm_attributes_green_closeness (ptr: POINTER; degree: INTEGER)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, unsigned long)"
		end;
		
	set_xpm_attributes_blue_closeness (ptr: POINTER; degree: INTEGER)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, unsigned long)"
		end;
	
	set_xpm_attributes_exactcolors (ptr: POINTER; c_mode: BOOLEAN)
		external
			"C [macro %"pixel.h%"] (XpmAttributes *, EIF_BOOLEAN)"
		end;

	xpm_attributes_size: INTEGER
		external
			"C (): int | %"xpm.h%""
		alias
			"XpmAttributesSize"
		end;

	xpm_attributes_colormap (h: POINTER): POINTER
			-- Colormap used
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_POINTER"
		alias
			"xpm_attributes_colormap"
		end;

	xpm_attributes_ncolors (h: POINTER): INTEGER
			-- Number of colors
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_red_closeness (h: POINTER): INTEGER
			-- RGB closeness authorized while allocating colors
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_blue_closeness (h: POINTER): INTEGER
			-- RGB closeness authorized while allocating colors
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_green_closeness (h: POINTER): INTEGER
			-- RGB closeness authorized while allocating colors
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_alloc_close_colors (h: POINTER): BOOLEAN
			-- Search for closest color while colormapping if no cell is available
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_BOOLEAN"
		end;

	xpm_attributes_x_hotspot (h: POINTER): INTEGER
			-- X hotspot coordinate of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_y_hotspot (h: POINTER): INTEGER
			-- Y hotspot coordinate of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_height (h: POINTER): INTEGER
			-- Height of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_width (h: POINTER): INTEGER
			-- Height of created pixmap
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		end;

	xpm_attributes_value_mask (h: POINTER): INTEGER
			-- Valuemask value of attribute structure
		require
			is_valid: is_valid
		external
			"C [macro %"pixel.h%"] (XpmAttributes *): EIF_INTEGER"
		alias
			"xpm_attributes_value_mask"
		end;

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




end -- class MEL_XPM_ATTRIBUTE


