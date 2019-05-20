note
	description: "Helper class to detect the Monitor DPI"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MONITOR_DPI_DETECTOR

feature --Access

	dpi: NATURAL
			-- Return the dots per inch (dpi) of the monitor
			-- DPI sizes 96, 120, 144, 192, etc.
		deferred
		ensure
			instance_free: class
		end

	scaled_size (a_size: INTEGER): INTEGER
			-- Scaled size of `a_size`.
		local
			l_dpi: like dpi
		do
			Result := a_size
			l_dpi := dpi
			if l_dpi > 0 then
				Result := (Result * (dpi / 96)).rounded
			end
		ensure
			instance_free: class
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
