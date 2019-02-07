note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_OBJECT_Z_TREE

inherit
	TEMPLATE_INSPECTOR

create
	register

feature -- Internal data

	internal_data (fn: STRING; obj: detachable Z_TREE): detachable CELL [detachable ANY]
		local
			l_fn: STRING
		do
			if obj /= Void then
				l_fn := fn.twin
				l_fn.to_lower

				if fn.is_equal ("title") then
					Result := cell_of (obj.title)
				else
				end
			end
		end

end
