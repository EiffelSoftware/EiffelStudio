indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IDESIGNER_SERIALIZATION_MANAGER

inherit
	ISERVICE_PROVIDER

feature -- Access

	get_context: SYSTEM_DLL_CONTEXT_STACK is
		external
			"IL deferred signature (): System.ComponentModel.Design.Serialization.ContextStack use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"get_Context"
		end

	get_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"get_Properties"
		end

feature -- Element Change

	add_resolve_name (value: SYSTEM_DLL_RESOLVE_NAME_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.ResolveNameEventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"add_ResolveName"
		end

	remove_resolve_name (value: SYSTEM_DLL_RESOLVE_NAME_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.ResolveNameEventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"remove_ResolveName"
		end

	remove_serialization_complete (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"remove_SerializationComplete"
		end

	add_serialization_complete (value: EVENT_HANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"add_SerializationComplete"
		end

feature -- Basic Operations

	create_instance (type: TYPE; arguments: ICOLLECTION; name: SYSTEM_STRING; add_to_container: BOOLEAN): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Type, System.Collections.ICollection, System.String, System.Boolean): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"CreateInstance"
		end

	get_serializer (object_type: TYPE; serializer_type: TYPE): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Type, System.Type): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetSerializer"
		end

	get_name (value: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetName"
		end

	remove_serialization_provider (provider: SYSTEM_DLL_IDESIGNER_SERIALIZATION_PROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerSerializationProvider): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"RemoveSerializationProvider"
		end

	get_instance (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetInstance"
		end

	set_name (instance: SYSTEM_OBJECT; name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Object, System.String): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"SetName"
		end

	add_serialization_provider (provider: SYSTEM_DLL_IDESIGNER_SERIALIZATION_PROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerSerializationProvider): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"AddSerializationProvider"
		end

	get_type_string (type_name: SYSTEM_STRING): TYPE is
		external
			"IL deferred signature (System.String): System.Type use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetType"
		end

	report_error (error_information: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"ReportError"
		end

end -- class SYSTEM_DLL_IDESIGNER_SERIALIZATION_MANAGER
