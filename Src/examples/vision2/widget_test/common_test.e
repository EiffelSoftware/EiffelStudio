indexing
	description: "Objects that provide attributes for all examples."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMON_TEST
	
inherit
	INSTALLATION_LOCATOR
		export
			{TEST_CONTROLLER} default_create
		end
		
	EV_UTILITIES
		export
			{NONE} all
		end
		
feature -- Access

	widget: EV_WIDGET
		-- Widget into which example is built.
		-- Simply insert into your Vision2 interface, for
		-- testing purposes.
		
feature {NONE} -- Implementation

	numbered_pixmap (a_number: INTEGER): EV_PIXMAP is
			-- `Result' is pixmap named "image" + a_number.out.
		local
			filename: FILE_NAME
		do
			if all_loaded_pixmaps = Void then
				create all_loaded_pixmaps.make (2)
			end
			if installation_location /= Void then
				create filename.make_from_string (installation_location)
				filename.extend ("bitmaps")
				filename.extend ("png")
				filename.extend ("image" + a_number.out + ".png")
				if all_loaded_pixmaps @ filename /= Void then
					Result := all_loaded_pixmaps @ filename
				else
					create Result
					Result.set_with_named_file (filename)	
					all_loaded_pixmaps.put (Result, filename)
				end
			else
				create Result
			end
		end
		
	all_loaded_pixmaps: HASH_TABLE [EV_PIXMAP, STRING]
			-- All pixmaps already loaded, referenced by their names.
			-- For quick access.

invariant
	widget_not_void: Widget /= Void

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


end -- class COMMON_TEST
