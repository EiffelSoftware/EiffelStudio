note
	description: "Object that represents a pixmap trailer displayed in a grid editor token item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_PIXMAP_COMPONENT

inherit
	ES_GRID_ITEM_COMPONENT

create
	make

feature{NONE} -- Initialization

	make (a_pixmap: like pixmap)
			-- Initialize `pixmap' with `a_pixmap'.
		do
			set_pixmap (a_pixmap)
		ensure
			pixmap_set: pixmap = a_pixmap
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Pixmap associated with Current

	required_width: INTEGER
			-- Required width in pixel
		do
			Result := pixmap.width
		ensure then
			good_result: Result = pixmap.width
		end

	required_height: INTEGER
			-- Required height in pixel
		do
			Result := pixmap.height
		ensure then
			good_result: Result = pixmap.height
		end

	pebble_at_position (a_x, a_y: INTEGER): detachable ANY
			-- Pebble at position (`a_x', `a_y') which is related to Current component
			-- Void if no pebble is found.
		do
		end

feature -- Drawing

	display (a_drawable: EV_DRAWABLE; a_start_x, a_start_y: INTEGER; a_width, a_height: INTEGER)
			-- Draw current trailer in `a_drawable' starting from (`a_start_x', `a_start_y').
			-- `a_start_x' and `a_start_y' are 0-based.
		do
			a_drawable.draw_pixmap (a_start_x, a_start_y, pixmap)
		end

feature -- Setting

	set_pixmap (a_pixmap: like pixmap)
			-- Set `pixmap' with `a_pixmap'.
		require
			a_pixmap_attached: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			pixmap_set: pixmap = a_pixmap
		end

feature -- Actions

	on_pick (a_x, a_y: INTEGER)
			-- Action to be performed when pick occurs at position (`a_x', `a_y') relative to top-left corner of current item
		do
		end

	on_pick_ended
			-- Action to be performed when pick-and-drop process ended
		do
		end

invariant
	pixmap_attached: pixmap /= Void

note
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
