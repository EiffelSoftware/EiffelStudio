indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ExtensibleClassFactory"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTENSIBLECLASSFACTORY

create {NONE}

feature -- Basic Operations

	frozen register_object_creation_callback (callback: SYSTEM_RUNTIME_INTEROPSERVICES_OBJECTCREATIONDELEGATE) is
		external
			"IL static signature (System.Runtime.InteropServices.ObjectCreationDelegate): System.Void use System.Runtime.InteropServices.ExtensibleClassFactory"
		alias
			"RegisterObjectCreationCallback"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_EXTENSIBLECLASSFACTORY
