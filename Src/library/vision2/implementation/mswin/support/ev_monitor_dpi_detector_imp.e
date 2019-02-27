note
	description: "Helper class Monitor DPI windows Implementation "
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MONITOR_DPI_DETECTOR_IMP

inherit

	EV_MONITOR_DPI_DETECTOR

feature -- Access

	dpi: NATURAL
			-- <Precursor>
		local
			ev: EV_SCREEN_IMP
			scaling: WEL_SCALING_EXTERNALS
		do
			create ev.make
			create scaling
			if scaling.is_api_available then
				Result := scaling.dpi_for_monitor (ev.dc.item).to_natural_32
			end
		end


note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
