indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ExtenderProvidedPropertyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_EXTENDERPROVIDEDPROPERTYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_extenderprovidedpropertyattribute

feature {NONE} -- Initialization

	frozen make_extenderprovidedpropertyattribute is
		external
			"IL creator use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		end

feature -- Access

	frozen get_extender_property: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTOR is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptor use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"get_ExtenderProperty"
		end

	frozen get_receiver_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"get_ReceiverType"
		end

	frozen get_provider: SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER is
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

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ExtenderProvidedPropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_EXTENDERPROVIDEDPROPERTYATTRIBUTE
