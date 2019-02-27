note
	description: "Utility class to cache image pixamps"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CACHED_PIXMAPS


feature -- Access

	icon_by_dpi (a_dpi: NATURAL): ES_ICONS
			-- Retrieve icons by dpi `a_dpi`.
			--| If the icon is already in the cache return it,
			--| if not add it to the cache.
		local
			l_icons: like icons_cache
		do
			l_icons := icons_cache
			if l_icons = Void then
				create l_icons.make (4)
				Result := internal_icons (a_dpi)
				l_icons.force (internal_icons (a_dpi), a_dpi)
			elseif attached l_icons.item (a_dpi) as l_result then
				Result := l_result
			else
				Result := internal_icons (a_dpi)
				l_icons.force (internal_icons (a_dpi), a_dpi)
			end
			icons_cache := l_icons
		end

feature -- Implementation

	internal_icons (a_dpi: NATURAL): ES_ICONS
		do
			if a_dpi > 108 and then a_dpi <= 120 then
				create Result.make ("icons_20x20", 20, 20)
			elseif a_dpi > 132 and then a_dpi <= 144 then
				create Result.make ("icons_24x24", 24, 24)
			elseif a_dpi > 144 then
				create Result.make ("icons_32x32", 32, 32)
			else
				create Result.make ("16x16", 16, 16)
			end
		end

	icons_cache: detachable HASH_TABLE [ES_ICONS, NATURAL]
			-- Cache for icons per dpi.
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
