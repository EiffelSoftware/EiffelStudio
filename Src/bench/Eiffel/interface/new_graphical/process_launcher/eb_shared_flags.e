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

	set_last_c_compiler_launch_successful (b: BOOLEAN) is
			-- 	Set `c_compilation_cell' with `b'.
		do
			c_compilation_cell.put (b)
		end


feature -- Status reporting

	is_gui: BOOLEAN is
			-- Is ec running on GUI mode?
		do
			Result := gui_cell.item
		end

	last_c_compiler_launch_successful: BOOLEAN is
			-- Is last c compilation successful?
		do
			Result := c_compilation_cell.item
		end


feature{NONE} -- Implementation

	gui_cell: CELL [BOOLEAN] is
			-- GUI mode cell
		once
			create Result.put (False)
		end

	c_compilation_cell: CELL [BOOLEAN] is
			-- GUI mode cell
		once
			create Result.put (True)
		end

end
