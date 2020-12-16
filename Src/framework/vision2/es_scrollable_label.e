note
	description: "{EV_SCROLLABLE_AREA} with a label item that wraps text and shows vertical scrollbar if required."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SCROLLABLE_LABEL

inherit
	EV_SCROLLABLE_AREA
		redefine
			create_interface_objects,
			initialize
		end

feature {NONE} -- Initialization

	create_interface_objects
			-- <Precursor>
		do
			create label
			Precursor
		end

	initialize
			-- <Precursor>
		do
			Precursor
				-- Set default text alignment.
			label.align_text_left
			label.align_text_top
				-- Put `label' into the container.
			extend (label)
				-- Register an agent to recompute text area size and position.
			resize_actions.extend (agent (x, y, w, h: INTEGER_32)
				do
					update_size
				end)
			dpi_changed_actions.extend (agent (a_dpi:NATURAL_32; x, y, w, h: INTEGER_32)
				do
					update_size
				end)

				-- Text is wrapped automatically, so no horizontal scrollbar is required.
			hide_horizontal_scroll_bar
		end

feature -- Access

	label: ES_LABEL
			-- Text widget.

feature -- Basic operations

	set_text (t: READABLE_STRING_GENERAL)
			-- Replace current text with `t'.
		do
			if not label.is_destroyed then
					-- Update associated text.
				label.set_and_wrap_text (t)
			end
				-- Update text area size to remove any additional space from the previous text.
			update_size
				-- Position text at the top in case previous text was scrolled.
			set_y_offset (0)
		end

feature {NONE} -- Resizing

	update_size
			-- Update size and position of `label' to make sure its left side is stick to the left side of the area
			-- and its width and height match current widget width and height.
		do
				-- Stick left side of the text at left side of the scroll area.
				-- TODO: Remove next instruction after supporting horizontal alignment in scrollable area
				-- with possible values: left, center, right.
			set_x_offset (0)
				-- The previous instruction has the same effect as this one:
				--      label.set_minimum_width (client_width)
				-- that can also replace the next one. However it seems better to be explicit.
				-- Limit text area width with the client width.
			set_item_width (client_width)
				-- Recompute visible text using current width.
			label.refresh_wrapped_text
				-- Update text area size so that its width matches visible width
				-- and height is either computed label height or the client area height
				-- for short text.
				-- The height needs to be updated to remove any additional space from the previous text.
			set_item_size (client_width, label.minimum_height.max (client_height))
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
