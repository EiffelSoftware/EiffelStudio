indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IRootDesigner"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IROOT_DESIGNER

inherit
	SYSTEM_DLL_IDESIGNER
	IDISPOSABLE

feature -- Access

	get_supported_technologies: NATIVE_ARRAY [SYSTEM_DLL_VIEW_TECHNOLOGY] is
		external
			"IL deferred signature (): System.ComponentModel.Design.ViewTechnology[] use System.ComponentModel.Design.IRootDesigner"
		alias
			"get_SupportedTechnologies"
		end

feature -- Basic Operations

	get_view (technology: SYSTEM_DLL_VIEW_TECHNOLOGY): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.ComponentModel.Design.ViewTechnology): System.Object use System.ComponentModel.Design.IRootDesigner"
		alias
			"GetView"
		end

end -- class SYSTEM_DLL_IROOT_DESIGNER
