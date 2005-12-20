indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_FLAGS

feature{EB_KERNEL}

	set_gui (b: BOOLEAN) is
			-- Set `gui_cell' with `b'.
		do
			gui_cell.put (b)
		end

feature -- Status reporting

	is_gui: BOOLEAN is
			-- Is ec running on GUI mode?
		do
			Result := gui_cell.item
		end

feature{NONE} -- Implementation

	gui_cell: CELL [BOOLEAN] is
			-- GUI mode cell
		once
			create Result.put (False)
		end

end
