indexing
	description: "Objects that provide attributes for all examples."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMMON_TEST
	
inherit
	INSTALLATION_LOCATOR
		
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
			file_location: STRING
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

end -- class COMMON_TEST
