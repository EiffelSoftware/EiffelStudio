indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyGridInternal.IRootGridEntry"

deferred external class
	SYSTEM_WINDOWS_FORMS_PROPERTYGRIDINTERNAL_IROOTGRIDENTRY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_browsable_attributes: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.AttributeCollection use System.Windows.Forms.PropertyGridInternal.IRootGridEntry"
		alias
			"get_BrowsableAttributes"
		end

feature -- Element Change

	set_browsable_attributes (value: SYSTEM_COMPONENTMODEL_ATTRIBUTECOLLECTION) is
		external
			"IL deferred signature (System.ComponentModel.AttributeCollection): System.Void use System.Windows.Forms.PropertyGridInternal.IRootGridEntry"
		alias
			"set_BrowsableAttributes"
		end

feature -- Basic Operations

	reset_browsable_attributes is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.PropertyGridInternal.IRootGridEntry"
		alias
			"ResetBrowsableAttributes"
		end

	show_categories (show_categories2: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGridInternal.IRootGridEntry"
		alias
			"ShowCategories"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYGRIDINTERNAL_IROOTGRIDENTRY
