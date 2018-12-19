note
	date: "$Date$"
	revision: "$Revision$"

class
	SMARTY_CMS_REGIONS_INSPECTOR

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
		do
			if attached {like {CMS_RESPONSE}.regions} obj as l_regions then
				l_fn := field_name.as_lower
				if l_fn.is_case_insensitive_equal ("count") then
					Result := cell_of (l_regions.count)
				elseif l_regions.has (l_fn) then
					Result := cell_of (l_regions.item (l_fn))
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
