note
	description: "Factory for all of the pixmapped graphics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "king"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MA_SHARED_PIXMAP_FACTORY

feature

	pixmap_file_content (fn: STRING): EV_PIXMAP
			-- Load a pixmap with name `fn'
		local
			full_path: detachable PATH
			retried: BOOLEAN
			warning_dialog: EV_WARNING_DIALOG
			a_coord: detachable TUPLE [x: INTEGER; y: INTEGER]
			a_row, a_column, a_x_offset, a_y_offset: INTEGER
		do
			if not retried then
				a_coord := pixmap_lookup [fn]
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
					if attached pixmap_path as p then
						full_path := p.extended (fn + Pixmap_suffix)
					else
							-- Try with current directory ...
						create full_path.make_from_string (fn + Pixmap_suffix)
					end
					Result.set_with_named_path (full_path)
				end
			else
				if full_path = Void then
					create full_path.make_from_string ("<no file name available>")
				end
				create warning_dialog.make_with_text (
					{STRING_32} "Cannot read pixmap file:%N" + full_path.name + ".%N%
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

	pixmap_width: INTEGER
			-- Width in pixels of the created factory image
		deferred
		ensure
			result_positive: Result > 0
		end

	pixmap_height: INTEGER
			-- Height in pixels of the created factory image
		deferred
		ensure
			result_positive: Result > 0
		end

	Pixmap_suffix: STRING
			-- Suffix for pixmaps.
		do
			Result := ".png"
		ensure
			result_not_void: Result /= Void
		end

	pixmap_path: detachable PATH
			-- Path containing all of the Studio pixmaps.
		deferred
		end

	image_matrix: EV_PIXMAP
			-- Matrix pixmap containing all of the present icons
		deferred
		ensure
			result_not_void: Result /= Void
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING]
			-- Lookup hash table for Studio pixmapped images
		deferred
		ensure
			result_not_void: Result /= Void
			result_compares_objects: Result.object_comparison
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
