indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ExtensibleClassFactory"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	EXTENSIBLE_CLASS_FACTORY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen register_object_creation_callback (callback: OBJECT_CREATION_DELEGATE) is
		external
			"IL static signature (System.Runtime.InteropServices.ObjectCreationDelegate): System.Void use System.Runtime.InteropServices.ExtensibleClassFactory"
		alias
			"RegisterObjectCreationCallback"
		end

end -- class EXTENSIBLE_CLASS_FACTORY
