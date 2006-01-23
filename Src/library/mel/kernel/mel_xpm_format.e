indexing

	description: 
		"Implementation of the XPM Pixmap format."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_XPM_FORMAT

inherit

	MEL_XPM_CONSTANTS
		export
			{NONE} all
		end

create
	make_from_file,
	write_to_file

feature {NONE} -- Initialization

	make_from_file (a_drawable: MEL_DRAWABLE; path: STRING; 
			attr: MEL_XPM_ATTRIBUTES) is
			-- Create color `pixmap' from file `path' and if `attr' is
			-- not void then it will use the attribtes `colormap', `depth',
			-- and then set the `width', `height' and if possible `x_hotspot'
			-- and `y_hotspot'.  
		require
			path_not_void: path /= Void;
			valid_drawable: a_drawable /= Void and then a_drawable.is_valid
		local
			path_ptr: ANY;
			id, mask: POINTER;
			att_ptr: POINTER;
			disp: MEL_DISPLAY
		do
			disp := a_drawable.display;
			path_ptr := path.to_c;
			if attr /= Void then
				att_ptr := attr.handle;
				attr.set_destroy_attributes
			end;
			error := xpm_read_file_to_pixmap 
					(disp.handle, 
					a_drawable.identifier, $path_ptr, 
					$id, $mask, att_ptr);
			if error = XpmSuccess then
				create pixmap.make_from_existing (disp, id, a_drawable.depth)
				if mask /= default_pointer then
					create shape_mask.make_from_existing (disp, mask, 
							a_drawable.depth);
				end;
			elseif attr /= Void and then error = XpmOpenFailed then
					-- If it wasn't able to find the file then	
					-- the attribute contents was not initialized.
				attr.unset_destroy_attributes	
			end
		ensure
			success_means_pix_is_create: is_valid implies pixmap /= Void and then
				pixmap.is_valid
		end;

	write_to_file (a_display: MEL_DISPLAY; path: STRING;
			a_pixmap: MEL_PIXMAP;
			a_shape_mask: MEL_PIXMAP; 
			attr: MEL_XPM_ATTRIBUTES) is
			-- Write an XPM format file from `a_pixmap' using the shape mask
			-- pixmap from `a_shape_mask'. If `attr' is not Void then it
			-- will use the height and width. Otheriwize, the width and
			-- height of `a_pixmap' is retreive fromt the XGetGeometry function.
		require
			path_not_void: path /= Void;
			valid_display: a_display /= Void and then a_display.is_valid;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid
		local
			path_ptr: ANY;
			mask: POINTER;
			att_ptr: POINTER;
		do
			path_ptr := path.to_c;
			if attr /= Void then
				att_ptr := attr.handle;
				attr.set_destroy_attributes
			end;
			if a_shape_mask /= Void then
				mask := a_shape_mask.identifier
			end;
			error := xpm_write_file_from_pixmap 
					(a_display.handle, 
					$path_ptr, a_pixmap.identifier, mask, att_ptr);
		end;

feature -- Access

	attributes: MEL_XPM_ATTRIBUTES;
			-- Xmp attributes structure

	pixmap: MEL_PIXMAP;
			-- Pixmap created from the file

	shape_mask: MEL_PIXMAP;
			-- Shape mask image

	error: INTEGER;
			-- Error status (Set to XpmColorError,
			-- XpmSuccess, XpmOpenFailed, XpmFileInvalid,	
			-- XpmNoMemory, XpmColorFailed)

	is_valid: BOOLEAN is
			-- Is the XPM `pixmap' valid after retrieving
			-- it from file?
		do
			Result := error = XpmSuccess
		ensure
			is_valid_implies_success: Result implies error = XpmSuccess
		end;
			
feature {NONE} -- Implementation

	xpm_read_file_to_pixmap (display_ptr: POINTER; 
			root, path: POINTER; 
			pixmap_return, shapemask_return: POINTER; 
			atts: POINTER): INTEGER is
		external
			"C (Display *, Drawable, char *, %
				%Pixmap *, Pixmap *, XpmAttributes *): EIF_INTEGER | %"xpm.h%""
		alias
			"XpmReadFileToPixmap"
		end;

	xpm_write_file_from_pixmap (display_ptr: POINTER; 
			path: POINTER; pixmap_return, shapemask_return: POINTER; 
			atts: POINTER): INTEGER is
		external
			"C (Display *, char *, %
				%Pixmap, Pixmap, XpmAttributes *): EIF_INTEGER | %"xpm.h%""
		alias
			"XpmWriteFileFromPixmap"
		end;

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




end -- class MEL_XPM_FORMAT


