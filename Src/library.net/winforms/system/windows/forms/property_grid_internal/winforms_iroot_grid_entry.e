indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyGridInternal.IRootGridEntry"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_IROOT_GRID_ENTRY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_browsable_attributes: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL deferred signature (): System.ComponentModel.AttributeCollection use System.Windows.Forms.PropertyGridInternal.IRootGridEntry"
		alias
			"get_BrowsableAttributes"
		end

feature -- Element Change

	set_browsable_attributes (value: SYSTEM_DLL_ATTRIBUTE_COLLECTION) is
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

end -- class WINFORMS_IROOT_GRID_ENTRY
