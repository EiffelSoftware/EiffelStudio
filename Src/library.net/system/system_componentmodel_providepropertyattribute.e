indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ProvidePropertyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_PROVIDEPROPERTYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_type_id,
			get_hash_code,
			equals_object
		end

create
	make_providepropertyattribute_1,
	make_providepropertyattribute

feature {NONE} -- Initialization

	frozen make_providepropertyattribute_1 (property_name: STRING; receiver_type_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.ProvidePropertyAttribute"
		end

	frozen make_providepropertyattribute (property_name: STRING; receiver_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.ComponentModel.ProvidePropertyAttribute"
		end

feature -- Access

	frozen get_receiver_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"get_ReceiverTypeName"
		end

	frozen get_property_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"get_PropertyName"
		end

	get_type_id: ANY is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ProvidePropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_PROVIDEPROPERTYATTRIBUTE
