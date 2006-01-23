indexing
	description: "[
		Objects that provide loading facilities for pixmaps which are different
		between dotnet and classic versions. This is the Eiffel classic version.
		Be sure to exclude "ev_pixmap_imp_loader.e" instead of "ev_pixmap_imp.e" in your exclude list.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAP_IMP_LOADER

inherit
	ANY
	
	EXCEPTIONS
		rename
			raise as exception_raise,
			class_name as exception_class_name
		export
			{NONE} all
		end

feature -- Status report

	pixmap_filename: STRING is
			-- Filename for the pixmap. 
			--  * Void if no file is associated with Current.
			--  * Empty string for the default pixmap.
		deferred
		end
		
	disable_initialized is
			-- Set `is_initialized' to `False'.
		deferred
		end

feature {NONE} -- Implementation

	effective_load_file is
			-- Really load the file.
		require
			filename_exists: pixmap_filename /= Void
		local
			filename_ptr: ANY
		do
				-- Disable invariant checking.
			disable_initialized

			if pixmap_filename.is_empty then
				c_ev_load_pixmap ($Current, Default_pointer, $update_fields)
			else
				filename_ptr := pixmap_filename.to_c
				c_ev_load_pixmap ($Current, $filename_ptr, $update_fields)
			end
			if last_pixmap_loading_had_error then
					-- An error occurred while loading the file
				exception_raise ("Unable to load the file")
			end
		end
		
	update_fields(
		error_code		: INTEGER -- Loadpixmap_error_xxxx 
		data_type		: INTEGER -- Loadpixmap_hicon, ...
		pixmap_width	: INTEGER -- Height of the loaded pixmap
		pixmap_height	: INTEGER -- Width of the loaded pixmap
		rgb_data		: POINTER -- Pointer on a C memory zone
		alpha_data		: POINTER -- Pointer on a C memory zone
		)
		is
		deferred
		end
	
	last_pixmap_loading_had_error: BOOLEAN
			-- Did the last pixmap load result in an error?

feature {NONE} -- Externals

	c_ev_load_pixmap(
		curr_object: POINTER; 
		file_name: POINTER; 
		update_fields_routine: POINTER
		) is
		external
			"C signature (void *, char *, void *) use %"load_pixmap.h%""
		end

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




end -- class EV_PIXMAP_IMP_LOADER

