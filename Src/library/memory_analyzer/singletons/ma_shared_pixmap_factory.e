indexing
	description: "Factory for all of the pixmapped graphics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "king"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MA_SHARED_PIXMAP_FACTORY

feature

	pixmap_file_content (fn: STRING): EV_PIXMAP is
			-- Load a pixmap with name `fn'
		local
			full_path: FILE_NAME
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
			a_coord: TUPLE [x: INTEGER; y: INTEGER]
			a_row, a_column, a_x_offset, a_y_offset: INTEGER
		do
			if not retried then
				a_coord := pixmap_lookup @ fn
				if a_coord /= Void then
						-- We are looking up an icon with dimension `pixmap_width' by `pixmap_height'
					a_column := a_coord.y
					a_row := a_coord.x
					a_x_offset := (a_column - 1) * (1 + pixmap_width) + 1
					a_y_offset := (a_row - 1) * (1 + pixmap_height) + 1
					Result := image_matrix.sub_pixmap (
						create {EV_RECTANGLE}.make (a_x_offset, a_y_offset, pixmap_width, pixmap_height))
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
		ensure
			result_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER is
			-- Width in pixels of the created factory image
		deferred
		ensure
			result_positive: Result > 0
		end

	pixmap_height: INTEGER is
			-- Height in pixels of the created factory image
		deferred
		ensure
			result_positive: Result > 0
		end

	Pixmap_suffix: STRING is
			-- Suffix for pixmaps.
		do
			Result := "png"
		ensure
			result_not_void: Result /= Void
		end

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the Studio pixmaps
		deferred
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	image_matrix: EV_PIXMAP is
			-- Matrix pixmap containing all of the present icons
		deferred
		ensure
			result_not_void: Result /= Void
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- Lookup hash table for Studio pixmapped images
		deferred
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
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




end -- class EB_SHARED_PIXMAP_FACTORY
