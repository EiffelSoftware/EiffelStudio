indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ProvidePropertyAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_PROVIDE_PROPERTY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			equals
		end

create
	make_system_dll_provide_property_attribute_1,
	make_system_dll_provide_property_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_provide_property_attribute_1 (property_name: SYSTEM_STRING; receiver_type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.ProvidePropertyAttribute"
		end

	frozen make_system_dll_provide_property_attribute (property_name: SYSTEM_STRING; receiver_type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.ProvidePropertyAttribute"
		end

feature -- Access

	frozen get_receiver_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"get_ReceiverTypeName"
		end

	frozen get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"get_PropertyName"
		end

	get_type_id: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"get_TypeId"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_PROVIDE_PROPERTY_ATTRIBUTE
