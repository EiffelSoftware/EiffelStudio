indexing
	description: "[
		Base class for all EiffelStudio pixmap matrix classes
	]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_PIXMAPS

inherit
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_name: STRING) is
			-- Initialize matrix
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		local
			l_file: FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				create l_file.make_from_string (eiffel_layout.bitmaps_path)
				l_file.set_subdirectory ("png")
				l_file.set_file_name (a_name)
			end

			if not retried and then (create {RAW_FILE}.make (l_file)).exists then
				create raw_buffer
				raw_buffer.set_with_named_file (l_file)
			else
				(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt ("Cannot read pixmap file:%N" + l_file + ".%N%NPlease make sure the installation is not corrupted.", Void, Void)

					-- Fail safe, use blank pixmap
				create raw_buffer.make_with_size ((width * pixel_width) + 1,(height * pixel_height) + 1)
			end
		rescue
			retried := True
			retry
		end

feature -- Access

	pixel_width: INTEGER
			-- Element width
		deferred
		end

	pixel_height: INTEGER
		deferred
		end

	width: INTEGER
			-- Matrix width
		deferred
		end

	height: INTEGER
			-- Matrix height
		deferred
		end

feature {NONE} -- Access

	raw_buffer: !EV_PIXEL_BUFFER
			-- raw matrix pixel buffer

feature {NONE} -- Query

	frozen pixel_rectangle (a_x: INTEGER; a_y: INTEGER): !EV_RECTANGLE
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
			l_x_offset := ((a_x - 1) * (pixel_width + 1)) + 1
			l_y_offset := ((a_y - 1) * (pixel_height + 1)) + 1

			Result := rectangle
			Result.set_x (l_x_offset)
			Result.set_y (l_y_offset)
			Result.set_width (pixel_width)
			Result.set_height (pixel_height)
		end

feature -- Utility

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

feature {NONE} -- Implementation

	frozen rectangle: !EV_RECTANGLE is
			-- Reusable rectangle for `pixmap_from_constant'.
		once
			create Result
		end

invariant
	width_positive: width > 0
	height_positive: height > 0
	pixel_width_positive: pixel_width > 0
	pixel_width_small_enough: pixel_width <= width
	pixel_height_positive: pixel_height > 0
	pixel_height_small_enough: pixel_height <= height

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
