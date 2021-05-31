note
	description: "Factory for all of the pixmapped graphics"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SHARED_PIXMAP_FACTORY

feature {NONE} -- Implementation

	pixmap_from_constant (a_pixmap_constant: INTEGER): EV_PIXMAP
			-- Return pixmap in matrix associated with `a_pixmap_constant'.
		local
			a_coord: INTEGER
			a_row, a_column: INTEGER
			l_columns, a_x_offset, a_y_offset, l_pix_width, l_pix_height: INTEGER
			l_table: like pixmap_lookup_table
			l_rectangle: like reusable_rectangle
		do
			l_table := pixmap_lookup_table
			a_coord := l_table [a_pixmap_constant]
			l_columns := l_table.columns
			a_column := (a_coord - 1) \\ l_columns
			a_row := (a_coord - a_column) // l_columns
				-- Both column and row are off by -1 as this is what is needed by the offset calculation.
			l_pix_width := pixmap_width
			l_pix_height := pixmap_height

				-- Work out offsets, taking pixmap border in to account.
			a_x_offset := (a_column) * (1 + l_pix_width) + 1
			a_y_offset := (a_row) * (1 + l_pix_height) + 1

			l_rectangle := reusable_rectangle
			l_rectangle.set_x (a_x_offset)
			l_rectangle.set_y (a_y_offset)
			l_rectangle.set_width (l_pix_width)
			l_rectangle.set_height (l_pix_height)
			Result := image_matrix.sub_pixmap (l_rectangle)
		end

	load_pixmap_from_repository (fn: STRING): EV_PIXMAP
			-- Load a pixmap with name `fn' located in `pixmap_path'.
		local
			full_path: PATH
			retried: BOOLEAN
		do
			if not retried then
					-- Initialize the pathname & load the file
				create Result
				full_path := pixmap_path.extended (fn).appended (pixmap_suffix)
				Result.set_with_named_path (full_path)
			else
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt ({STRING_32} "Cannot read pixmap file:%N" + full_path.name + ".%N%
					%Please make sure the installation is not corrupted.", Void, Void)
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

	Pixmap_suffix: STRING = ".png"
			-- Suffix for pixmaps.

	pixmap_path: PATH
			-- Path containing all of the Studio pixmaps
		deferred
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	image_matrix: EV_PIXMAP
			-- Matrix pixmap containing all of the present icons
		deferred
		ensure
			result_not_void: Result /= Void
		end

	pixmap_lookup_table: ES_PIXMAP_LOOKUP_TABLE
			-- Lookup hash table for Studio pixmaps.
		deferred
		ensure
			result_not_void: Result /= Void
		end

	reusable_rectangle: EV_RECTANGLE
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
