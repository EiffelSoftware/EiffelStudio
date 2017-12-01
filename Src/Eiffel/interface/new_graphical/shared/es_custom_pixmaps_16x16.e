note
	description: "Summary description for {ES_CUSTOM_PIXMAPS_16X16}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CUSTOM_PIXMAPS_16X16

inherit
	ES_PIXMAPS_16X16
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: attached STRING)
		do
			Precursor (a_name)
		end

feature -- Instance-free variants

	instance_free_icon (pix: EV_PIXMAP): EV_PIXMAP
		local
			l_cache: like instance_free_cache
		do
			l_cache := instance_free_cache
			across
				l_cache as ic
			until
				Result /= Void
			loop
				if ic.item.input = pix then
					Result := ic.item.output
				end
			end
			if Result = Void then
				Result := icon_with_overlay (pix, overlay_instance_free_icon, 0, 0)
				l_cache.force ([Result, pix])
			end
		end

	instance_free_icon_buffer (pix: EV_PIXEL_BUFFER): EV_PIXEL_BUFFER
		local
			l_cache: like instance_free_buffer_cache
		do
			l_cache := instance_free_buffer_cache
			across
				l_cache as ic
			until
				Result /= Void
			loop
				if ic.item.input = pix then
					Result := ic.item.output
				end
			end
			if Result = Void then
				Result := icon_buffer_with_overlay (pix, overlay_instance_free_icon_buffer, 0, 0)
				l_cache.force ([Result, pix])
			end
		end

feature {NONE} -- Implementation

	instance_free_cache: ARRAYED_LIST [TUPLE [output, input: EV_PIXMAP]]
		once
			create Result.make (1)
		end

	instance_free_buffer_cache: ARRAYED_LIST [TUPLE [output, input: EV_PIXEL_BUFFER]]
		once
			create Result.make (1)
		end

invariant

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
