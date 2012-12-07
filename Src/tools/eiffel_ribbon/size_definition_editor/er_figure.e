note
	description: "[
					Ribbon figure used by Size Definition Editor tool
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_FIGURE

inherit
	COMPARABLE
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			is_valid_position := True
			update_pixmap
		end

feature -- Command

	id: INTEGER
			-- FIXME: use Object id instead?

	set_highlight (a_bool: BOOLEAN)
			-- Set `is_highlight' with `a_bool'
		do
			is_highlight := a_bool
			update_pixmap
		ensure
			set: is_highlight = a_bool
		end

	set_is_valid_position (a_bool: BOOLEAN)
			-- Set `is_valid_position' with `a_bool'
		do
			is_valid_position := a_bool
			update_pixmap
		ensure
			set: is_valid_position = a_bool
		end

	set_x (a_x: INTEGER)
			-- Set `x' with `a_x'
		do
			x := a_x
		ensure
			set: x = a_x
		end

	set_y (a_y: INTEGER)
			-- Set `y' with `a_y'
		do
			y := a_y
		ensure
			set: y = a_y
		end

	set_label_visible (a_bool: BOOLEAN)
			-- Set `is_label_visible' with `a_bool'
		do
			is_label_visible := a_bool
			update_pixmap
		ensure
			set: is_label_visible = a_bool
		end

	set_is_large_image_size (a_large: BOOLEAN)
			-- Set `is_large_image_size' with `a_large'
		do
			is_large_image_size := a_large
			update_pixmap
		ensure
			set: is_large_image_size = a_large
		end

feature -- Query

	is_valid_position: BOOLEAN
			-- If figer position valid? eg, it can be used for Size Definition

	pixmap: EV_PIXMAP
			-- Pixmap represent current

	is_highlight: BOOLEAN
			-- Is current highlighted?

	x: INTEGER
			-- X position

	y: INTEGER
			-- Y position

	width: INTEGER
			-- Width of current
		do
			Result := pixmap.width
		end

	height: INTEGER
			-- Height of current
		do
			Result := pixmap.height
		end

	is_label_visible: BOOLEAN
			-- Is text label visible?

	is_large_image_size: BOOLEAN
			-- True means large
			-- False means small

	has_point (a_x, a_y: INTEGER): BOOLEAN
			-- Does current area contain `a_x' and `a_y' ?
		do
			Result := x <= a_x and y <= a_y and a_x <= (x + width) and a_y <= (y + height)
		end

feature -- Compare

	is_less alias "<" (a_other: ER_FIGURE): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		do
			Result := x < a_other.x
		end

	is_equal (a_other: ER_FIGURE): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		do
			Result := x = a_other.x
		end

feature {NONE} -- Implementation

	constants: ER_MISC_CONSTANTS
			-- Constants
		once
			create Result
		end

	update_pixmap
			-- Update current's pixmap
		do
			pixmap := calculate_pixmap
		end

	calculate_pixmap: EV_PIXMAP
			-- Calculate pixmap base on current statues
		local
			l_path: PATH
			l_retried: BOOLEAN
			l_shared: ER_SHARED_TOOLS
			l_error: EV_ERROR_DIALOG
			l_interface_names: ER_INTERFACE_NAMES
			l_misc_constants: ER_MISC_CONSTANTS
		do
			if not l_retried then
				l_path := constants.images
				create Result
				if is_large_image_size then
					if is_highlight then
						check is_valid_position end
						if is_label_visible then
							l_path := l_path.extended ("button_with_text_large_highlight.png")
						else
							l_path := l_path.extended ("button_without_text_large_highlight.png")
						end
					else
						if not is_valid_position then
							if is_label_visible then
								l_path := l_path.extended ("button_with_text_large_invalid.png")
							else
								l_path := l_path.extended ("button_without_text_large_invalid.png")
							end
						else
							if is_label_visible then
								l_path := l_path.extended ("button_with_text_large.png")
							else
								l_path := l_path.extended ("button_without_text_large.png")
							end
						end

					end
				else
					if is_highlight then
						check is_valid_position end
						if is_label_visible then
							l_path := l_path.extended ("button_with_text_highlight.png")
						else
							l_path := l_path.extended ("button_without_text_highlight.png")
						end
					else
						if not is_valid_position then
							if is_label_visible then
								l_path := l_path.extended ("button_with_text_invalid.png")
							else
								l_path := l_path.extended ("button_without_text_invalid.png")
							end
						else
							if is_label_visible then
								l_path := l_path.extended ("button_with_text.png")
							else
								l_path := l_path.extended ("button_without_text.png")
							end
						end

					end
				end
				Result.set_with_named_path (l_path)
			else
				create Result.make_with_size (10, 10)
			end
		rescue
			l_retried := True
			create l_shared
			create l_interface_names
			create l_misc_constants
			if attached l_misc_constants.ise_eiffel as l_ise_eiffel then
				create l_error.make_with_text (l_interface_names.cannot_find_templates (l_ise_eiffel))
			else
				create l_error.make_with_text (l_interface_names.ise_eiffel_not_defined)
			end
			l_error.set_buttons (<<l_interface_names.ok>>)
			if attached l_shared.main_window_cell.item as l_win then
				l_error.show_modal_to_window (l_win)
			else
				l_error.show
			end
			retry
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
