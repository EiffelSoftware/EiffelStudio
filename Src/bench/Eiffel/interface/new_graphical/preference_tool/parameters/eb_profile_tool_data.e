indexing
	description: "Default values of the profiler interface."
	author: "bonnard"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROFILE_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	profile_tool_width: Integer is
		do
			Result := resources.get_integer ("profile_tool_width", 250)
		end

	profile_tool_height: Integer is
		do
			Result := resources.get_integer ("profile_tool_height", 490)
		end

	query_window_width: Integer is
		do
			Result := resources.get_integer ("query_window_width", 500)
		end

	query_window_height: Integer is
		do
			Result := resources.get_integer ("query_window_height", 500)
		end

end -- class EB_PROFILE_TOOL_DATA
