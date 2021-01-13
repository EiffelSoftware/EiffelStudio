note
	description: "Object used to cache the DPI value, and provide scaled_size function."
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_DPI_SCALER

create
	make,
	make_with_dpi

feature {NONE} -- Initialization

	make
		do
			make_with_dpi ({EV_MONITOR_DPI_DETECTOR_IMP}.dpi)
		end

	make_with_dpi (a_dpi: like dpi)
		require
			a_dpi > 0
		do
			update_dpi (a_dpi)
		end

feature -- DPI handling

	dpi: NATURAL
			-- Return the dots per inch (dpi) of the monitor
			-- DPI sizes 96, 120, 144, 192, etc.
		do
			Result := dpi_cache
		end

	scaled_size (a_size: INTEGER): INTEGER
			-- Scaled size of `a_size`.
		local
			l_dpi: like dpi
		do
			Result := a_size
			l_dpi := dpi
			if l_dpi > 0 then
				Result := (Result * (l_dpi / 96)).rounded
			end
		end

feature -- Element change		

	update_dpi (a_dpi: NATURAL)
		require
			a_dpi > 0
		do
			dpi_cache := a_dpi
		ensure
			dpi_cache_updated: dpi_cache = a_dpi.to_natural_32 or else dpi_cache /= 0
		end

feature {NONE} -- Implementation

	dpi_cache: like dpi

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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
