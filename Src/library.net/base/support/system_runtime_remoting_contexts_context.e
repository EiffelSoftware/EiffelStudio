indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Contexts.Context"

external class
	SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT

inherit
	ANY
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

	get_context_properties: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY] is
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

	frozen get_default_context: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT is
		external
			"IL static signature (): System.Runtime.Remoting.Contexts.Context use System.Runtime.Remoting.Contexts.Context"
		alias
			"get_DefaultContext"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Contexts.Context"
		alias
			"ToString"
		end

	frozen unregister_dynamic_property (name: STRING; obj: SYSTEM_CONTEXTBOUNDOBJECT; ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT): BOOLEAN is
		external
			"IL static signature (System.String, System.ContextBoundObject, System.Runtime.Remoting.Contexts.Context): System.Boolean use System.Runtime.Remoting.Contexts.Context"
		alias
			"UnregisterDynamicProperty"
		end

	frozen allocate_named_data_slot (name: STRING): SYSTEM_LOCALDATASTORESLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Runtime.Remoting.Contexts.Context"
		alias
			"AllocateNamedDataSlot"
		end

	get_property (name: STRING): SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY is
		external
			"IL signature (System.String): System.Runtime.Remoting.Contexts.IContextProperty use System.Runtime.Remoting.Contexts.Context"
		alias
			"GetProperty"
		end

	frozen free_named_data_slot (name: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"FreeNamedDataSlot"
		end

	frozen allocate_data_slot: SYSTEM_LOCALDATASTORESLOT is
		external
			"IL static signature (): System.LocalDataStoreSlot use System.Runtime.Remoting.Contexts.Context"
		alias
			"AllocateDataSlot"
		end

	set_property (prop: SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTPROPERTY) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextProperty): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"SetProperty"
		end

	frozen get_named_data_slot (name: STRING): SYSTEM_LOCALDATASTORESLOT is
		external
			"IL static signature (System.String): System.LocalDataStoreSlot use System.Runtime.Remoting.Contexts.Context"
		alias
			"GetNamedDataSlot"
		end

	frozen do_call_back (deleg: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CROSSCONTEXTDELEGATE) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.CrossContextDelegate): System.Void use System.Runtime.Remoting.Contexts.Context"
		alias
			"DoCallBack"
		end

	frozen set_data (slot: SYSTEM_LOCALDATASTORESLOT; data: ANY) is
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

	frozen get_data (slot: SYSTEM_LOCALDATASTORESLOT): ANY is
		external
			"IL static signature (System.LocalDataStoreSlot): System.Object use System.Runtime.Remoting.Contexts.Context"
		alias
			"GetData"
		end

	frozen register_dynamic_property (prop: SYSTEM_RUNTIME_REMOTING_CONTEXTS_IDYNAMICPROPERTY; obj: SYSTEM_CONTEXTBOUNDOBJECT; ctx: SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT): BOOLEAN is
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

end -- class SYSTEM_RUNTIME_REMOTING_CONTEXTS_CONTEXT
