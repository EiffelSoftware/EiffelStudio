note
	date: "$Date$"
	revision: "$Revision$"

class
	SMARTY_CMS_HTML_PAGE_INSPECTOR

inherit
	TEMPLATE_INSPECTOR

	CMS_ENCODERS

create
	register

feature {TEMPLATE_ROUTINES}

	internal_data (field_name: STRING; obj: detachable ANY): detachable CELL [detachable ANY]
			-- Return object in a cell
			-- If not handled by this inspector, return Void
		local
			l_fn: STRING
		do
			if attached {CMS_HTML_PAGE} obj as l_page then
				l_fn := field_name.as_lower
				if attached l_page.variables.item (l_fn) as v then
					Result := cell_of (v)
				elseif l_fn.is_case_insensitive_equal ("title") then
					if attached l_page.title as l_title then
						Result := cell_of (html_encoded (l_title))
					else
						Result := cell_of (Void)
					end
				elseif l_fn.is_case_insensitive_equal ("is_front") then
					Result := cell_of (l_page.is_front)
				elseif l_fn.is_case_insensitive_equal ("is_https") then
					Result := cell_of (l_page.is_https)
				elseif l_fn.starts_with_general ("region_") then
					l_fn.remove_head (7) -- remove "region_"
					Result := cell_of (l_page.region (l_fn))
				elseif l_fn.is_case_insensitive_equal ("regions") then
					Result := cell_of (l_page.regions)
				end
			end
		end

note
	copyright: "2011-2018, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
