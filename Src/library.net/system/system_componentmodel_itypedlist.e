indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ITypedList"

deferred external class
	SYSTEM_COMPONENTMODEL_ITYPEDLIST

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_list_name (list_accessors: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]): STRING is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor[]): System.String use System.ComponentModel.ITypedList"
		alias
			"GetListName"
		end

	get_item_properties (list_accessors: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR]): SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
		external
			"IL deferred signature (System.ComponentModel.PropertyDescriptor[]): System.ComponentModel.PropertyDescriptorCollection use System.ComponentModel.ITypedList"
		alias
			"GetItemProperties"
		end

end -- class SYSTEM_COMPONENTMODEL_ITYPEDLIST
