note
	description: "Summary description for {ES_DPI_PIXMAPS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_DPI_PIXMAPS

inherit
	ES_PIXMAPS
		rename
			make as make_pixmaps
		end

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL; a_icon_width: NATURAL_8; a_icon_height: NATURAL_8)
			-- Initialize matrix from a moniker.
			--
			-- `a_name': An identifier/moniker used to load a pixmap image.
			-- using `a_icon_width` and `a_icon_height` for width and height value.
		require
			not_a_name_is_empty: not a_name.is_empty
		do
			make_pixmaps (a_name)
			icon_width := a_icon_width
			icon_height := a_icon_height
		ensure
			icon_width_set: icon_width = a_icon_width
			icon_height_set: icon_height = a_icon_height
		end

feature -- Access

	icon_width: NATURAL_8
			-- <Precursor>

	icon_height: NATURAL_8
			-- <Precursor>		

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
