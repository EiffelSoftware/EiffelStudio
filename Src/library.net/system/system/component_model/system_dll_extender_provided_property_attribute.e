indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ExtenderProvidedPropertyAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_EXTENDER_PROVIDED_PROPERTY_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals
		end

create
	make_system_dll_extender_provided_property_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_extender_provided_property_attribute is
		external
			"IL creator use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		end

feature -- Access

	frozen get_extender_property: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"get_ExtenderProperty"
		end

	frozen get_receiver_type: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"get_ReceiverType"
		end

	frozen get_provider: SYSTEM_DLL_IEXTENDER_PROVIDER is
		external
			"IL signature (): System.ComponentModel.IExtenderProvider use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"get_Provider"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_EXTENDER_PROVIDED_PROPERTY_ATTRIBUTE
