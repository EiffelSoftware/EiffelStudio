note
	description: "Summary description for {ES_CENTER_WIDGET}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CENTER_WIDGET

inherit
	EV_VERTICAL_BOX

create
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget (w: EV_WIDGET)
		local
			hb: EV_HORIZONTAL_BOX
		do
			default_create
			create hb
			extend (new_space (1))
			extend (hb)
			extend (new_space (3))

			hb.extend (new_space(4))
			hb.extend (w)
			hb.extend (new_space (2))
		end

	new_space (pos: INTEGER): EV_CELL
			-- Pos: top:1 right:2 bottom:3 left: 4
		do
			create Result
			--Debug: Result.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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
