indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxComponentsCreatingEventArgs"

external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_toolboxcomponentscreatingeventargs

feature {NONE} -- Initialization

	frozen make_toolboxcomponentscreatingeventargs (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL creator signature (System.ComponentModel.Design.IDesignerHost) use System.Drawing.Design.ToolboxComponentsCreatingEventArgs"
		end

feature -- Access

	frozen get_designer_host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST is
		external
			"IL signature (): System.ComponentModel.Design.IDesignerHost use System.Drawing.Design.ToolboxComponentsCreatingEventArgs"
		alias
			"get_DesignerHost"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATINGEVENTARGS
