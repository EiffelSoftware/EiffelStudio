indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ITypedList"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ITYPED_LIST

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_list_name (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_STRING is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor[]): System.String use System.ComponentModel.ITypedList"
		alias
			"GetListName"
		end

	get_item_properties (list_accessors: NATIVE_ARRAY [SYSTEM_DLL_PROPERTY_DESCRIPTOR]): SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ITypedList"
		alias
			"GetItemProperties"
		end

end -- class SYSTEM_DLL_ITYPED_LIST
