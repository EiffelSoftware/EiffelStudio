indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.IToolboxUser"

deferred external class
	SYSTEM_DRAWING_DESIGN_ITOOLBOXUSER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	tool_picked (tool: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxUser"
		alias
			"ToolPicked"
		end

	get_tool_supported (tool: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM): BOOLEAN is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Boolean use System.Drawing.Design.IToolboxUser"
		alias
			"GetToolSupported"
		end

end -- class SYSTEM_DRAWING_DESIGN_ITOOLBOXUSER
