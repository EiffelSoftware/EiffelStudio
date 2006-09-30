indexing
	description: "[
		A generator for creating Eiffel classes from a matrix INI file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MATRIX_ICON_GENERATOR

inherit
	MATRIX_FILE_GENERATOR

create
	make

feature {NONE} -- Access

	png_location: STRING
			-- Location where PNGs are generated

	matrix: EV_PIXMAP
			-- Full matrix PNG

feature -- Basic Operations

	generate (a_doc: INI_DOCUMENT; a_output: STRING; a_matrix: EV_PIXMAP) is
			-- Generates a matrix file.
		require
			a_output_attached: a_output /= Void
			not_a_output_is_empty: not a_output.is_empty
			a_output_exists: (create {DIRECTORY}.make (a_output)).exists
		do
			reset
			png_location := a_output
			process (a_doc, agent (a_matrix2: EV_PIXMAP)
				local
					l_matrix: like matrix
				do
					if successful then
						create l_matrix.make_with_size (((pixel_width + 1) * (width + 1)).to_integer_32, ((pixel_height + 1) * (height + 1)).to_integer_32)
						l_matrix.draw_sub_pixmap (0, 0, a_matrix2, create {EV_RECTANGLE}.make (0, 0, a_matrix2.width, a_matrix2.height))
						matrix := l_matrix
					end
				end (a_matrix), Void)
		end

feature {NONE} -- Icon generation

	generate_icon (a_name: STRING; a_location: STRING; a_x, a_y, a_pw, a_ph: NATURAL; a_matrix: EV_PIXMAP) is
			-- Generates a single icon tile in `a_matrix'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_location_attached: a_location /= Void
			not_a_location_is_empty: not a_location.is_empty
			a_location_exists: (create {DIRECTORY}.make (a_location)).exists
			a_matrix_attached: a_matrix /= Void
			coords_in_bounds: (a_matrix.width.to_natural_32 >= (a_x* a_pw)) and  (a_matrix.height.to_natural_32 >= (a_y * a_ph))
		local
			l_pixmap: EV_PIXMAP
			l_fn: FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				create l_fn.make
				l_fn.set_directory (a_location)
				l_fn.set_file_name (a_name.as_lower + tile_suffix + ".png")
				l_pixmap := a_matrix.sub_pixmap (pixel_rectangle (a_x, a_y, a_pw, a_ph))
				retried := l_pixmap = Void
				if not retried then
					l_pixmap.save_to_named_file (create {EV_PNG_FORMAT}, l_fn)
				end
			end
			if retried then
				add_warning (create {WARNING_PNG_NOT_SAVED}.make_with_context ([l_fn]))
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Processing

	process_literal_item (a_item: INI_LITERAL; a_x: NATURAL_32; a_y: NATURAL_32) is
			-- Processes a literal from an INI matrix file.
		do
			generate_icon (a_item.name, png_location, a_x, a_y, pixel_width, pixel_height, matrix)
		end

feature {NONE} -- Implementation

	pixel_rectangle (a_x, a_y, a_pw, a_ph: NATURAL): EV_RECTANGLE is
			-- Retrieves a pixmap from matrix coordinates `a_x', `a_y'	
		require
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= width
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= height
		local
			l_x_offset: INTEGER
			l_y_offset: INTEGER
		do
			l_x_offset := ((a_x.to_integer_32 - 1) * (a_pw.to_integer_32 + 1)) + 1
			l_y_offset := ((a_y.to_integer_32 - 1) * (a_ph.to_integer_32 + 1)) + 1

			Result := rectangle
			Result.set_x (l_x_offset)
			Result.set_y (l_y_offset)
			Result.set_width (a_pw.to_integer_32)
			Result.set_height (a_pw.to_integer_32)
		ensure
			result_attached: Result /= Void
		end

	rectangle: EV_RECTANGLE is
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class {MATRIX_ICON_GENERATOR}
