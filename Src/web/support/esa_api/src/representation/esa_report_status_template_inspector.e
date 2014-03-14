note
	description: "Summary description for {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_STATUS_TEMPLATE_INSPECTOR


inherit
	TEMPLATE_INSPECTOR
		redefine
			internal_data
		end

create
	register

feature -- Internal data

	internal_data (fn: STRING; obj: ESA_REPORT_STATUS): detachable CELL [detachable ANY]
		local
			l_fn: STRING
		do
			if obj /= Void then
				l_fn := fn.twin
				l_fn.to_lower

				if fn.is_equal ("is_selected") then
					Result := cell_of (obj.is_selected)
				elseif fn.is_equal ("id") then
					Result := cell_of (obj.id)
				elseif fn.is_equal ("synopsis") then
					Result := cell_of (obj.synopsis)
				else
					Result := cell_of ("")
				end
			end
		end
end
