indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_NAMES

feature -- Names

	t_Not_running: STRING is "Application is not running"
	t_Running: STRING is "Application is running"
	t_Running_no_stop_points: STRING is	"Application is running (ignoring breakpoints)";
	t_Paused: STRING is "Application is paused"

end
