indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.PropertyTabAttribute"

external class
	SYSTEM_COMPONENTMODEL_PROPERTYTABATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_propertytabattribute_4,
	make_propertytabattribute,
	make_propertytabattribute_1,
	make_propertytabattribute_2,
	make_propertytabattribute_3

feature {NONE} -- Initialization

	frozen make_propertytabattribute_4 (tab_class_name: STRING; tab_scope: SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE) is
		external
			"IL creator signature (System.String, System.ComponentModel.PropertyTabScope) use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_propertytabattribute is
		external
			"IL creator use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_propertytabattribute_1 (tab_class: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_propertytabattribute_2 (tab_class_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.PropertyTabAttribute"
		end

	frozen make_propertytabattribute_3 (tab_class: SYSTEM_TYPE; tab_scope: SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE) is
		external
			"IL creator signature (System.Type, System.ComponentModel.PropertyTabScope) use System.ComponentModel.PropertyTabAttribute"
		end

feature -- Access

	frozen get_tab_scopes: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE] is
		external
			"IL signature (): System.ComponentModel.PropertyTabScope[] use System.ComponentModel.PropertyTabAttribute"
		alias
			"get_TabScopes"
		end

	frozen get_tab_classes: ARRAY [SYSTEM_TYPE] is
		external
			"IL signature (): System.Type[] use System.ComponentModel.PropertyTabAttribute"
		alias
			"get_TabClasses"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.PropertyTabAttribute"
		alias
			"GetHashCode"
		end

	equals_object (other: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.PropertyTabAttribute"
		alias
			"Equals"
		end

	frozen equals_property_tab_attribute (other: SYSTEM_COMPONENTMODEL_PROPERTYTABATTRIBUTE): BOOLEAN is
		external
			"IL signature (System.ComponentModel.PropertyTabAttribute): System.Boolean use System.ComponentModel.PropertyTabAttribute"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen initialize_arrays_array_string (tab_class_names: ARRAY [STRING]; tab_scopes: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE]) is
		external
			"IL signature (System.String[], System.ComponentModel.PropertyTabScope[]): System.Void use System.ComponentModel.PropertyTabAttribute"
		alias
			"InitializeArrays"
		end

	frozen get_tab_class_names: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.ComponentModel.PropertyTabAttribute"
		alias
			"get_TabClassNames"
		end

	frozen initialize_arrays (tab_classes: ARRAY [SYSTEM_TYPE]; tab_scopes: ARRAY [SYSTEM_COMPONENTMODEL_PROPERTYTABSCOPE]) is
		external
			"IL signature (System.Type[], System.ComponentModel.PropertyTabScope[]): System.Void use System.ComponentModel.PropertyTabAttribute"
		alias
			"InitializeArrays"
		end

end -- class SYSTEM_COMPONENTMODEL_PROPERTYTABATTRIBUTE
