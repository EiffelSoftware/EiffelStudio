indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.StandardToolWindows"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_STANDARD_TOOL_WINDOWS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Design.StandardToolWindows"
		end

feature -- Access

	frozen task_list: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"TaskList"
		end

	frozen object_browser: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"ObjectBrowser"
		end

	frozen property_browser: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"PropertyBrowser"
		end

	frozen output_window: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"OutputWindow"
		end

	frozen toolbox: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"Toolbox"
		end

	frozen related_links: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"RelatedLinks"
		end

	frozen server_explorer: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"ServerExplorer"
		end

	frozen project_explorer: GUID is
		external
			"IL static_field signature :System.Guid use System.ComponentModel.Design.StandardToolWindows"
		alias
			"ProjectExplorer"
		end

end -- class SYSTEM_DLL_STANDARD_TOOL_WINDOWS
