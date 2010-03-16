note
	description: "Style for UI_TABLE_VIEW creation."
	date: "$Date$"
	revision: "$Revision$"

class
	UI_TABLE_VIEW_CONSTANTS

feature -- Table style constants

	style_plain: NATURAL_32
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return UITableViewStylePlain;"
		end

   style_grouped: NATURAL_32
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return UITableViewStyleGrouped;"
		end

feature -- Separator style constants

	no_separator: NATURAL_32
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return UITableViewCellSeparatorStyleNone;"
		end

   single_line_separator: NATURAL_32
		external
			"C inline use <UIKit/UIKit.h>"
		alias
			"return UITableViewCellSeparatorStyleSingleLine;"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
