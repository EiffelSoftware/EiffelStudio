indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.IToolboxUser"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_ITOOLBOX_USER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	tool_picked (tool: DRAWING_TOOLBOX_ITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxUser"
		alias
			"ToolPicked"
		end

	get_tool_supported (tool: DRAWING_TOOLBOX_ITEM): BOOLEAN is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Boolean use System.Drawing.Design.IToolboxUser"
		alias
			"GetToolSupported"
		end

end -- class DRAWING_ITOOLBOX_USER
