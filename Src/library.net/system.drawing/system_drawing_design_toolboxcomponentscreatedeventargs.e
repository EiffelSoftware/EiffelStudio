indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxComponentsCreatedEventArgs"

external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_toolboxcomponentscreatedeventargs

feature {NONE} -- Initialization

	frozen make_toolboxcomponentscreatedeventargs (components: ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT]) is
		external
			"IL creator signature (System.ComponentModel.IComponent[]) use System.Drawing.Design.ToolboxComponentsCreatedEventArgs"
		end

feature -- Access

	frozen get_components: ARRAY [SYSTEM_COMPONENTMODEL_ICOMPONENT] is
		external
			"IL signature (): System.ComponentModel.IComponent[] use System.Drawing.Design.ToolboxComponentsCreatedEventArgs"
		alias
			"get_Components"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXCOMPONENTSCREATEDEVENTARGS
