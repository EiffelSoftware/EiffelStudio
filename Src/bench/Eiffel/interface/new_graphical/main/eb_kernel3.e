indexing
	description: "EifelBench kernel, or supposed to be so"

class
	EB_KERNEL3

inherit
	EV_APPLICATION

	EB_SHARED_INTERFACE_TOOLS

creation

	make

feature -- Access

--	first_window: EB_ABOUT_WINDOW is
--	first_window: EB_FEATURE_WINDOW is
--	first_window: EB_CLASS_WINDOW is
	first_window: EB_PROJECT_WINDOW is
			--
		do
--			create Result.make_default ("About_Dialog")
			create Result.make_top_level
			Project_tool_cell.put (Result.tool)
			Result.show
		end

end -- class EB_KERNEL3
