indexing
	description: "[
		Base class for all EiffelStudio pixmap matrix accessor classes.
	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_PIXMAPS

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

--inherit {NONE}
	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_name: !STRING)
			-- Initialize matrix from a moniker.
			--
			-- `a_name': An identifier/moniker used to load a pixmap image.
		require
			not_a_name_is_empty: not a_name.is_empty
		local
			l_buffer: !EV_PIXEL_BUFFER
		do
			if {l_loaded_buffer: EV_PIXEL_BUFFER} resource_handler.retrieve_matrix (a_name) then
				l_buffer := l_loaded_buffer
			else
				if logger.is_service_available then
					logger.service.put_message_with_severity (
						locale_formatter.formatted_translation (w_could_not_load_matrix, [a_name]),
						{ENVIRONMENT_CATEGORIES}.none,
						{PRIORITY_LEVELS}.high
					)
				end

					-- Fail safe, use blank pixmap
				create l_buffer.make_with_size (matrix_pixel_width.to_integer_32,
					matrix_pixel_height.to_integer_32)
			end
			make_from_buffer (l_buffer)
		end

	make_from_path (a_path: !STRING)
			-- Initialize matrix from a path.
			--
			-- `a_path': The path to a matrix pixmap file to load.
		require
			not_a_path_is_empty: not a_path.is_empty
		local
			l_buffer: !EV_PIXEL_BUFFER
		do
			if {l_loaded_buffer: EV_PIXEL_BUFFER} resource_handler.matrix_file_name (a_path) then
				l_buffer := l_loaded_buffer
			else
				if logger.is_service_available then
					logger.service.put_message_with_severity (
						locale_formatter.formatted_translation (w_could_not_load_matrix, [a_path]),
						{ENVIRONMENT_CATEGORIES}.none,
						{PRIORITY_LEVELS}.high
					)
				end

					-- Fail safe, use blank pixmap
				create l_buffer.make_with_size (matrix_pixel_width.to_integer_32,
					matrix_pixel_height.to_integer_32)
			end
			make_from_buffer (l_buffer)
		end

	make_from_buffer (a_buffer: !like matrix_buffer)
			-- Initializes the tool pixmaps with a loaded raw pixel buffer.
			-- Note: the set buffer may not be the same as the supplied buffer, if the supplied buffer is
			--       smaller than the required dimensions.
			--
			-- `a_buffer': An existing pixel buffer.
		require
			not_a_buffer_is_destroyed: not a_buffer.is_destroyed
		do
			matrix_buffer := expand_buffer (a_buffer)
		end

feature -- Access

	icon_width: NATURAL_8
			-- Icon pixel width
		deferred
		end

	icon_height: NATURAL_8
			-- Icon pixel height
		deferred
		end

	width: NATURAL_8
			-- Matrix width
		deferred
		end

	height: NATURAL_8
			-- Matrix height
		deferred
		end

feature {NONE} -- Access

	matrix_pixel_width: NATURAL_16
			-- Full matix pixel width.
		local
			l_border: NATURAL_16
		do
			l_border := matrix_pixel_border
			Result := (width.to_natural_16 * (icon_width.to_natural_16 + l_border)) + l_border
		end

	matrix_pixel_height: NATURAL_16
			-- Full matix pixel width.
		local
			l_border: NATURAL_16
		do
			l_border := matrix_pixel_border
			Result := (height.to_natural_16 * (icon_height.to_natural_16 + l_border)) + l_border
		end

	matrix_pixel_border: NATURAL_8
			-- Matrix icon pxiel border size.
		deferred
		end

	frozen icon_coordinates_table: !DS_HASH_TABLE [!TUPLE [x: NATURAL_8; y: NATURAL_8], STRING]
			-- Table of icon coordinates.
			--
			-- Key: An icon name.
			-- Value: Icon matrix coordinates.
		do
			if {l_result: like icon_coordinates_table} internal_icon_coordinates_table then
				Result := l_result
			else
				create Result.make_default
				Result.set_key_equality_tester (create {KL_STRING_EQUALITY_TESTER})
				populate_coordinates_table (Result)
				internal_icon_coordinates_table := Result
			end
		ensure
			result_consistent: Result = icon_coordinates_table
		end

	matrix_buffer: !EV_PIXEL_BUFFER
			-- Raw matrix pixel buffer

feature -- Status report

	has_named_icon (a_name: !STRING): BOOLEAN
			-- Indicates if a name icon if availalbe.
			--
			-- `a_name': The icon name. (See section Access: Icon name constants)
			-- `Result': True if the named icon exists for Current; False otherwise.
		require
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := icon_coordinates_table.has (a_name)
		ensure
			icon_coordinates_table_has_a_name: Result implies icon_coordinates_table.has (a_name)
		end

feature {NONE} -- Helpers

	resource_handler: !ES_PIXMAP_RESOURCE_HANDLER
			-- Access to an icon resource handler, for unified access to icon resources
		once
			create Result.make
		end

	frozen logger: !SERVICE_CONSUMER [LOGGER_S]
			-- Access to the EiffelStudio logger service.
		once
			create Result
		end

feature -- Query

	named_icon_buffer (a_name: !STRING): !EV_PIXEL_BUFFER
			-- Retrieves a icon buffer given a known icon name
			--
			-- `a_name':
			-- `Result':
		require
			not_a_name_is_empty: not a_name.is_empty
			has_named_icon_a_name: has_named_icon (a_name)
		local
			l_coords: !TUPLE [x: NATURAL_8; y: NATURAL_8]
		do
			l_coords := icon_coordinates_table.item (a_name)
			Result ?= matrix_buffer.sub_pixel_buffer (pixel_rectangle (l_coords.x, l_coords.y))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	named_icon (a_name: !STRING): !EV_PIXMAP
			-- Retrieves a icon buffer given a known icon name
			--
			-- `a_name':
			-- `Result':
		require
			not_a_name_is_empty: not a_name.is_empty
			has_named_icon_a_name: has_named_icon (a_name)
		local
			l_coords: !TUPLE [x: NATURAL_8; y: NATURAL_8]
		do
			l_coords := icon_coordinates_table.item (a_name)
			Result ?= matrix_buffer.sub_pixmap (pixel_rectangle (l_coords.x, l_coords.y))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_buffer_with_overlay (a_icon: EV_PIXEL_BUFFER; a_overlay: EV_PIXEL_BUFFER; a_x_offset: NATURAL_8; a_y_offset: NATURAL_8): !EV_PIXEL_BUFFER
			-- Creates a new icon with a supplied overlay.
			--
			-- `a_icon': The original icon to draw an overlay on top of.
			-- `a_overlay': An overlay icon.
			-- `a_x_offset': X positional offset on the icon to start drawing the overlay at.
			-- `a_y_offset': Y positional offset on the icon to start drawing the overlay at.
			-- `Result': A buffer result of the overlay.
		require
			a_icon_attached: a_icon /= Void
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			a_overlay_attached: a_overlay /= Void
			not_a_overlay_is_destoryed: not a_overlay.is_destroyed
			a_icon_big_enough: a_icon.width > 0 and a_icon.height > 0
			a_overlay_big_enough: a_overlay.width > 0 and a_overlay.height > 0
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := a_icon.width.max (a_overlay.width + a_x_offset)
			l_height := a_icon.height.max (a_overlay.height + a_y_offset)
			create Result.make_with_size (l_width, l_height)
			Result.draw_pixel_buffer_with_x_y (0, 0, a_icon)
			Result.draw_pixel_buffer_with_x_y (a_x_offset, a_y_offset, a_overlay)
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	icon_with_overlay (a_icon: EV_PIXMAP; a_overlay: EV_PIXEL_BUFFER; a_x_offset: NATURAL_8; a_y_offset: NATURAL_8): !EV_PIXMAP
			-- Creates a new icon with a supplied overlay.
			--
			-- `a_icon': The original icon to draw an overlay on top of.
			-- `a_overlay': An overlay icon.
			-- `a_x_offset': X positional offset on the icon to start drawing the overlay at.
			-- `a_y_offset': Y positional offset on the icon to start drawing the overlay at.
			-- `Result': A buffer result of the overlay.
		require
			a_icon_attached: a_icon /= Void
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			a_overlay_attached: a_overlay /= Void
			not_a_overlay_is_destoryed: not a_overlay.is_destroyed
			a_icon_big_enough: a_icon.width > 0 and a_icon.height > 0
			a_overlay_big_enough: a_overlay.width > 0 and a_overlay.height > 0
		local
			l_width: INTEGER
			l_height: INTEGER
		do
			l_width := a_icon.width.max (a_overlay.width + a_x_offset)
			l_height := a_icon.height.max (a_overlay.height + a_y_offset)
			create Result.make_with_size (l_width, l_height)
			Result.draw_sub_pixmap (0, 0, a_icon, create {EV_RECTANGLE}.make (0, 0, a_icon.width, a_icon.height))
			Result.draw_sub_pixel_buffer (a_x_offset, a_y_offset, a_overlay, create {EV_RECTANGLE}.make (0, 0, a_overlay.width, a_overlay.height))
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

feature {NONE} -- Query

	frozen pixel_rectangle (a_x: NATURAL_8; a_y: NATURAL_8): !EV_RECTANGLE
			-- Retrieves a rectangle from an icon matrix coordinates.
			--
			-- `a_x': Icon x coordinate.
			-- `a_y': Icon y coordinate.
			-- `Result': A rectangle representing the icon at the supplied coordinates.
		require
			a_x_positive: a_x > 0
			a_x_small_enough: a_x <= width
			a_y_positive: a_y > 0
			a_y_small_enough: a_y <= height
		local
			l_x_offset: NATURAL_16
			l_y_offset: NATURAL_16
			l_border: like matrix_pixel_border
		do
			l_border := matrix_pixel_border
			l_x_offset := ((a_x.to_natural_16 - 1) * (icon_width + l_border)) + l_border
			l_y_offset := ((a_y.to_natural_16 - 1) * (icon_height + l_border)) + l_border

			Result := rectangle
			Result.set_x (l_x_offset)
			Result.set_y (l_y_offset)
			Result.set_width (icon_width)
			Result.set_height (icon_height)
		end

feature {NONE} -- Basic operation

	frozen expand_buffer (a_buffer: !like matrix_buffer): !like matrix_buffer
			-- Expands a pixel buffer to ensure it will fit the hard-coded dimensions set in the matrix configuration file.
			--
			-- `a_buffer': The pixel buffer to expand to fix the coded matrix dimensions.
			-- `Result': The same a `a_buffer' if no expansion is needed or a new pixel buffer to fit the dimensions.
		require
			not_a_buffer_is_destroyed: not a_buffer.is_destroyed
		do
			if a_buffer.width.to_natural_32 < matrix_pixel_width or else a_buffer.height.to_natural_32 < matrix_pixel_height then
					-- The matrix is not big enough so we need to draw it onto a bigger buffer.
				create Result.make_with_size (matrix_pixel_width.to_integer_32, matrix_pixel_height.to_integer_32)
				Result.draw_pixel_buffer_with_x_y (0, 0, a_buffer)
			else
				Result := a_buffer
			end
		ensure
			not_result_is_destroyed: not Result.is_destroyed
			result_width_big_enough: Result.width.to_natural_32 >= matrix_pixel_width
			result_height_big_enough: Result.height.to_natural_32 >= matrix_pixel_height
		end

	populate_coordinates_table (a_table: !DS_HASH_TABLE [!TUPLE [x: NATURAL_8; y: NATURAL_8], STRING])
			-- Populates a coordinates table with the coordinates for the implemented icons
		deferred
		end

feature {NONE} -- Implementation: cache

	frozen rectangle: !EV_RECTANGLE
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

	internal_icon_coordinates_table: ?like icon_coordinates_table
			-- Cached version of `icon_coordinates_table'
			-- Note: Do not use directly!

feature {NONE} -- Internationalization

	w_could_not_load_matrix: !STRING = "Cannot read pixmap file:%N$1.%N%NPlease make sure the installation is not corrupted."

invariant
	width_positive: width > 0
	height_positive: height > 0
	icon_width_positive: icon_width > 0
	icon_height_positive: icon_height > 0
	matrix_pixel_border_non_negative: matrix_pixel_border >= 0
	matrix_buffer_width_big_enough: matrix_buffer.width.to_natural_32 >= matrix_pixel_width
	matrix_buffer_height_big_enough: matrix_buffer.height.to_natural_32 >= matrix_pixel_height

;indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
