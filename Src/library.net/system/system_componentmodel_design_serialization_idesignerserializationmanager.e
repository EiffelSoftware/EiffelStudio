indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.IDesignerSerializationManager"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONMANAGER

inherit
	SYSTEM_ISERVICEPROVIDER

feature -- Access

	get_context: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_CONTEXTSTACK is
		external
			"IL deferred signature (): System.ComponentModel.Design.Serialization.ContextStack use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"get_Context"
		end

	get_properties: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"get_Properties"
		end

feature -- Element Change

	add_resolve_name (value: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.ResolveNameEventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"add_ResolveName"
		end

	remove_resolve_name (value: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_RESOLVENAMEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.ResolveNameEventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"remove_ResolveName"
		end

	remove_serialization_complete (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"remove_SerializationComplete"
		end

	add_serialization_complete (value: SYSTEM_EVENTHANDLER) is
		external
			"IL deferred signature (System.EventHandler): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"add_SerializationComplete"
		end

feature -- Basic Operations

	create_instance (type: SYSTEM_TYPE; arguments: SYSTEM_COLLECTIONS_ICOLLECTION; name: STRING; add_to_container: BOOLEAN): ANY is
		external
			"IL deferred signature (System.Type, System.Collections.ICollection, System.String, System.Boolean): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"CreateInstance"
		end

	get_serializer (object_type: SYSTEM_TYPE; serializer_type: SYSTEM_TYPE): ANY is
		external
			"IL deferred signature (System.Type, System.Type): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetSerializer"
		end

	get_name (value: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetName"
		end

	remove_serialization_provider (provider: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONPROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerSerializationProvider): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"RemoveSerializationProvider"
		end

	get_instance (name: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetInstance"
		end

	set_name (instance: ANY; name: STRING) is
		external
			"IL deferred signature (System.Object, System.String): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"SetName"
		end

	add_serialization_provider (provider: SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONPROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.Design.Serialization.IDesignerSerializationProvider): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"AddSerializationProvider"
		end

	get_type_string (type_name: STRING): SYSTEM_TYPE is
		external
			"IL deferred signature (System.String): System.Type use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"GetType"
		end

	report_error (error_information: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.ComponentModel.Design.Serialization.IDesignerSerializationManager"
		alias
			"ReportError"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_IDESIGNERSERIALIZATIONMANAGER
