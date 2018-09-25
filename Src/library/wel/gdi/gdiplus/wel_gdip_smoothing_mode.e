note
	description: "A collection of constants specifiyng whether smoothing (antialiasing) is applied to lines and curves and the edges of filled areas in a GDI+ context."
	EIS: "protocol=URI", "src=https://docs.microsoft.com/en-us/windows/desktop/api/gdiplusenums/ne-gdiplusenums-smoothingmode"

class WEL_GDIP_SMOOTHING_MODE

feature -- Access

	smoothing_mode_invalid: INTEGER_32 = -1
			-- Invalid mode: reserved.

	smoothing_mode_default: INTEGER = 0
			-- Smoothing is not applied.

	smoothing_mode_high_speed: INTEGER = 1
			-- Best performance: smoothing is not applied.

	smoothing_mode_high_quality: INTEGER = 2
			-- Smoothing is applied using an 8x4 box filter.

	smoothing_mode_none: INTEGER = 3
			-- Smoothing is not applied.

	smoothing_mode_anti_alias, smoothing_mode_anti_alias_8x4: INTEGER = 4
			-- Smoothing is applied using an 8x4 box filter.

	smoothing_mode_anti_alias_8x8: INTEGER = 5
			-- Smoothing is applied using an 8x8 box filter.

feature -- Status report

	is_valid (mode: INTEGER): BOOLEAN
			-- Is value `mode` a valid smoothing mode?
		do
			inspect mode
			when
				smoothing_mode_invalid,
				smoothing_mode_default,
				smoothing_mode_high_speed,
				smoothing_mode_high_quality,
				smoothing_mode_none,
				smoothing_mode_anti_alias,
				smoothing_mode_anti_alias_8x8
			then
				Result := True
			else
					-- False by default
			end
		ensure
			instance_free: class
			definition: Result = (<<
					smoothing_mode_invalid,
					smoothing_mode_default,
					smoothing_mode_high_speed,
					smoothing_mode_high_quality,
					smoothing_mode_none,
					smoothing_mode_anti_alias,
					smoothing_mode_anti_alias_8x8
				>>).has (mode)
		end

note
	date: "$Date$"
	revision: "$Revision: рп$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
