indexing
	description: "Factory for all of the pixmapped graphics"
	author: "king"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SHARED_PIXMAP_FACTORY

feature

	pixmap_file_content (fn: STRING): EV_PIXMAP is
			-- Load a pixmap with name `fn'
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
			a_coord: TUPLE [INTEGER, INTEGER]
			a_row, a_column, a_x_offset, a_y_offset: INTEGER
			a_icon_matrix: EV_PIXMAP_I
		do
			if not retried then
				a_coord := pixmap_lookup @ fn
				if a_coord /= Void then
						-- We are looking up an icon with dimension `pixmap_width' by `pixmap_height'
					a_column := a_coord.integer_32_item (2)
					a_row := a_coord.integer_32_item (1)
					a_icon_matrix ?= image_matrix.implementation
					a_x_offset := (a_column - 1) * (1 + pixmap_width) + 1
					a_y_offset := (a_row - 1) * (1 + pixmap_height) + 1
					Result := a_icon_matrix.sub_pixmap (create {EV_RECTANGLE}.make (a_x_offset, a_y_offset, pixmap_width, pixmap_height))
				else
						-- Initialize the pathname & load the file
					create Result
					create full_path.make_from_string (pixmap_path)
					full_path.set_file_name (fn)
					full_path.add_extension (Pixmap_suffix)
					Result.set_with_named_file (full_path)
				end
			else
				create warning_dialog.make_with_text (
					"Cannot read pixmap file:%N" + full_path + ".%N%
					%Please make sure the installation is not corrupted.")
				warning_dialog.show
				create Result.make_with_size (pixmap_width, pixmap_height) -- Default pixmap size
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER is
			-- Width in pixels of the created factory image
		deferred
		end

	pixmap_height: INTEGER is
			-- Height in pixels of the created factory image
		deferred
		end	

	Pixmap_suffix: STRING is
			-- Suffix for pixmaps.
		do
			Result := "png"
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the Studio pixmaps
		deferred
		end

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the present icons
		deferred
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for Studio pixmapped images
		deferred
		end

end -- class EB_SHARED_PIXMAP_FACTORY
