indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.Context"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	CONTEXT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Contexts.Context"
		end

feature -- Access

	get_context_properties: NATIVE_ARRAY [ICONTEXT_PROPERTY] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextProperty[] use System.Runtime.Remoting.Contexts.Context"
		alias
			"get_ContextProperties"
		end

	get_context_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Contexts.Context"
		alias
			"get_ContextID"
		end

	frozen get_default_context: CONTEXT is
		external
			"IL static signature (): System.Runtime.Remoting.Contexts.Context use System.Runtime.Remoting.Contexts.Context"
		alias
			"get_DefaultContext"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Contexts.Context"
		alias
			"ToString"
		end

	frozen unregister_dynamic_property (name: SYSTEM_STRING; obj: CONTEXT_BOUND_OBJECT; ctx: CONTEXT): BOOLEAN is
		external
			"IL static signature (System.String, System.ContextBoundObject, System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.Context"
		alias
			"UnregisterDynamicProperty"
		end

	frozen allocate_named_data_slot (name: SYSTEM_STRING): LOCAL_DATA_STORE_SLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Runtime.Remoting.Contexts.Context"
		alias
			"AllocateNamedDataSlot"
		end

	get_property (name: SYSTEM_STRING): ICONTEXT_PROPERTY is
		external
			"IL signature (System.String): System.Runtime.Remoting.Contexts.IContextProperty use System.Runtime.Remoting.Contexts.Context"
		alias
			"GetProperty"
		end

	frozen free_named_data_slot (name: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"FreeNamedDataSlot"
		end

	frozen allocate_data_slot: LOCAL_DATA_STORE_SLOT is
		external
			"IL static signature (): System.LocalDataStoreSlot use System.Runtime.Remoting.Contexts.Context"
		alias
			"AllocateDataSlot"
		end

	set_property (prop: ICONTEXT_PROPERTY) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextProperty): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"SetProperty"
		end

	frozen get_named_data_slot (name: SYSTEM_STRING): LOCAL_DATA_STORE_SLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Runtime.Remoting.Contexts.Context"
		alias
			"GetNamedDataSlot"
		end

	frozen do_call_back (deleg: CROSS_CONTEXT_DELEGATE) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.CrossContextDelegate): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"DoCallBack"
		end

	frozen set_data (slot: LOCAL_DATA_STORE_SLOT; data: SYSTEM_OBJECT) is
		external
			"IL static signature (System.LocalDataStoreSlot, System.Object): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"SetData"
		end

	freeze is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"Freeze"
		end

	frozen get_data (slot: LOCAL_DATA_STORE_SLOT): SYSTEM_OBJECT is
		external
			"IL static signature (System.LocalDataStoreSlot): System.Object use System.Runtime.Remoting.Contexts.Context"
		alias
			"GetData"
		end

	frozen register_dynamic_property (prop: IDYNAMIC_PROPERTY; obj: CONTEXT_BOUND_OBJECT; ctx: CONTEXT): BOOLEAN is
		external
			"IL static signature (System.Runtime.Remoting.Contexts.IDynamicProperty, System.ContextBoundObject, System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.Context"
		alias
			"RegisterDynamicProperty"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"Finalize"
		end

end -- class CONTEXT
