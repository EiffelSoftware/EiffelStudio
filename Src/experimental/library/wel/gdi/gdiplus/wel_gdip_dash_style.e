note
	description: "[
			A collection of constants specifiyng the line style of a line drawn with a Windows GDI+ pen.
			The line can be drawn by using one of several predefined styles or a custom style.
		]"
	eis: "protocol=URI", "src=https://docs.microsoft.com/en-us/windows/desktop/api/gdiplusenums/ne-gdiplusenums-dashstyle"

class WEL_GDIP_DASH_STYLE

feature -- Access

	dash_style_solid: INTEGER_32 = 0
			-- A solid line.

	dash_style_dash: INTEGER_32 = 1
			-- A dashed line.

	dash_style_dot: INTEGER_32 = 2
			-- A dotted line.

	dash_style_dash_dot: INTEGER_32 = 3
			-- An alternating dash-dot line.

	dash_style_dash_dot_dot: INTEGER_32 = 4
			-- An alternating dash-dot-dot line.

	dash_style_custom: INTEGER_32 = 5
			-- A user-defined, custom dashed line.

feature -- Status report

	is_valid (style: INTEGER): BOOLEAN
			-- Is value `style` a valid dash style?
		do
			inspect style
			when
				dash_style_solid,
				dash_style_dash,
				dash_style_dot,
				dash_style_dash_dot,
				dash_style_dash_dot_dot,
				dash_style_custom
			then
				Result := True
			else
					-- False by default
			end
		ensure
			instance_free: class
			definition: Result = (<<
					dash_style_solid,
					dash_style_dash,
					dash_style_dot,
					dash_style_dash_dot,
					dash_style_dash_dot_dot,
					dash_style_custom
				>>).has (style)
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
