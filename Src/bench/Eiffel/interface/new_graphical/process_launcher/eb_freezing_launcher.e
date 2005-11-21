indexing
	description: "Object that is responsible for launching c compiler in workbench mode."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FREEZING_LAUNCHER

inherit
	EB_C_COMPILER_LAUNCHER
		redefine
			on_start
		end

create
	make

feature{NONE} -- Actions

	on_start is
			-- Handler called before c compiler starts
		do
			Precursor
			idle_printing_manager.add_printer ({EB_IDLE_PRINTING_MANAGER}.freezing_printer)
		end

end
