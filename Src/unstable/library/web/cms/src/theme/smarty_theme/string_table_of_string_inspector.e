note
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_TABLE_OF_STRING_INSPECTOR

inherit
	TEMPLATE_INSPECTOR

create
	register

feature {TEMPLATE_ROUTINES}

	internal_data (field_name: STRING; obj: detachable ANY): detachable CELL [detachable ANY]
			-- Return object in a cell
			-- If not handled by this inspector, return Void
		local
			l_fn: STRING
			utf: UTF_CONVERTER
		do
			if attached {STRING_TABLE [detachable READABLE_STRING_GENERAL]} obj as l_regions then
				l_fn := field_name.as_lower
				if l_fn.is_case_insensitive_equal ("count") then
					Result := cell_of (l_regions.count)
				elseif attached l_regions.item (l_fn) as v then
					if attached {READABLE_STRING_32} v as v32 then
						if attached v32.is_valid_as_string_8 then
							Result := cell_of (v.to_string_8)
						else
							Result := cell_of (utf.escaped_utf_32_string_to_utf_8_string_8 (v32))
						end
					else
						Result := cell_of (v.to_string_8)
					end
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
