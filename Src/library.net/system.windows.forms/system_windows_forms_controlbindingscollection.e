indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ControlBindingsCollection"

external class
	SYSTEM_WINDOWS_FORMS_CONTROLBINDINGSCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_WINDOWS_FORMS_BINDINGSCOLLECTION
		redefine
			remove_core,
			clear_core,
			add_core
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ControlBindingsCollection"
		alias
			"get_Control"
		end

	frozen get_item_string (property_name: STRING): SYSTEM_WINDOWS_FORMS_BINDING is
		external
			"IL signature (System.String): System.Windows.Forms.Binding use System.Windows.Forms.ControlBindingsCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen remove_binding (binding: SYSTEM_WINDOWS_FORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"Remove"
		end

	frozen remove_at_int32 (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"RemoveAt"
		end

	frozen add_binding (binding: SYSTEM_WINDOWS_FORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"Add"
		end

	frozen add_string (property_name: STRING; data_source: ANY; data_member: STRING): SYSTEM_WINDOWS_FORMS_BINDING is
		external
			"IL signature (System.String, System.Object, System.String): System.Windows.Forms.Binding use System.Windows.Forms.ControlBindingsCollection"
		alias
			"Add"
		end

	frozen clear_void is
		external
			"IL signature (): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"Clear"
		end

feature {NONE} -- Implementation

	remove_core (data_binding: SYSTEM_WINDOWS_FORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"RemoveCore"
		end

	add_core (data_binding: SYSTEM_WINDOWS_FORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"AddCore"
		end

	clear_core is
		external
			"IL signature (): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"ClearCore"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTROLBINDINGSCOLLECTION
