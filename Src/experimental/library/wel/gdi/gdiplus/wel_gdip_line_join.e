note
	description: "[
			A collection of constants specifiyng how to join two lines that are drawn by the same GDI+ pen and whose ends meet.
			At the intersection of the two line ends, a line join makes the join look more continuous.
		]"
	eis: "protocol=URI", "src=https://docs.microsoft.com/ru-ru/windows/desktop/api/gdiplusenums/ne-gdiplusenums-linejoin"

class WEL_GDIP_LINE_JOIN

feature -- Access

	line_join_miter: INTEGER_32 = 0
			-- A mitered join.
			-- This produces a sharp corner or a clipped corner, depending on whether the length of the miter exceeds the miter limit.

	line_join_bevel: INTEGER_32 = 1
			-- A beveled join.
			-- This produces a diagonal corner.

	line_join_round: INTEGER_32 = 2
			-- A circular join.
			-- This produces a smooth, circular arc between the lines.

	line_join_miter_clipped: INTEGER_32 = 3
			-- A mitered join.
			-- This produces a sharp corner or a beveled corner, depending on whether the length of the miter exceeds the miter limit.

feature -- Status report

	is_valid (join: INTEGER): BOOLEAN
			-- Is value `join` a valid line join?
		do
			inspect join
			when
				line_join_miter,
				line_join_bevel,
				line_join_round,
				line_join_miter_clipped
			then
				Result := True
			else
					-- False by default
			end
		ensure
			instance_free: class
			definition: Result = (<<
					line_join_miter,
					line_join_bevel,
					line_join_round,
					line_join_miter_clipped
				>>).has (join)
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
