indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.DesignerLoader"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_DESIGNER_LOADER

inherit
	SYSTEM_OBJECT

feature -- Access

	get_loading: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.Serialization.DesignerLoader"
		alias
			"get_Loading"
		end

feature -- Basic Operations

	dispose is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.Design.Serialization.DesignerLoader"
		alias
			"Dispose"
		end

	begin_load (host: SYSTEM_DLL_IDESIGNER_LOADER_HOST) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerLoaderHost): System.Void use System.ComponentModel.Design.Serialization.DesignerLoader"
		alias
			"BeginLoad"
		end

	flush is
		external
			"IL signature (): System.Void use System.ComponentModel.Design.Serialization.DesignerLoader"
		alias
			"Flush"
		end

end -- class SYSTEM_DLL_DESIGNER_LOADER
