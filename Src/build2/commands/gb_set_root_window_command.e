indexing
	description: "Objects that represent a command for setting of the root window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SET_ROOT_WINDOW_COMMAND
	
inherit
	EB_STANDARD_CMD
		redefine
			make, execute, executable
		end
	
	GB_SHARED_TOOLS
		export
			{NONE} all
		end
		
	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Create `Current'.
		do
			Precursor {EB_STANDARD_CMD}
			set_tooltip ("Set root window")
			set_pixmaps (Icon_titled_window_main_small)
			set_name ("Set root window")
			set_menu_name ("Set root window")
			add_agent (agent execute)
		end
		
feature -- Access	

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
			Result := not widget_selector.objects.is_empty and not Layout_constructor.is_empty
		end

feature -- Basic operations
	
	execute is
				-- Execute `Current'.
		do
			widget_selector.change_root_window
			widget_selector.tool_bar.update_select_root_window_command
		end
		
end -- class GB_SET_ROOT_WINDOW_COMMAND
