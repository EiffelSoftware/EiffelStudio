note
	description: "Window that show orignal image."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PICTURE_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize
			-- Initialization
		do
			Precursor {EV_TITLED_WINDOW}
			set_icon_pixmap ((create {SUN_ICON}.make).to_pixmap)
			create picture_container
			extend (picture_container)
			picture_container.set_minimum_size (100, 100)
			close_request_actions.extend (agent request_close_window)
			picture_container.wipe_out
			create drawing_area
			picture_container.extend (drawing_area)
			drawing_area.expose_actions.extend (agent on_expose)
		end

feature -- Access

	drawing_area: EV_DRAWING_AREA
			-- Place to show the pixmap.

	picture_container: EV_HORIZONTAL_BOX
			-- Container for the image

	pixmap: EV_PIXMAP
			-- Showing pixmap

feature -- Change element

	update_size
			--
		local
			p: like pixmap
		do
			p := pixmap
			if p /= Void then
				set_size (p.width + (width - client_width), p.height + (height - client_height))
			end
		end

	set_pixmap (a_pixmap: like pixmap)
			--Set `pixmap' with `a_pixmap'.
		require
			a_pixmap_attached: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			set: pixmap = a_pixmap
		end

feature {NONE} -- Implementation

	on_expose (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
			-- Handle `drawing_area' expose actions.
		do
			drawing_area.clear
			if pixmap /= Void then
				drawing_area.draw_pixmap (0, 0, pixmap)
			end
		end

	request_close_window
			-- When closing.
		do
			hide
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
