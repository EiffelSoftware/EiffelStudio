indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ControlBindingsCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONTROL_BINDINGS_COLLECTION

inherit
	WINFORMS_BINDINGS_COLLECTION
		redefine
			remove_core,
			clear_core,
			add_core
		end
	ICOLLECTION
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_control: WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ControlBindingsCollection"
		alias
			"get_Control"
		end

	frozen get_item_string (property_name: SYSTEM_STRING): WINFORMS_BINDING is
		external
			"IL signature (System.String): System.Windows.Forms.Binding use System.Windows.Forms.ControlBindingsCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen remove_binding (binding: WINFORMS_BINDING) is
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

	frozen add_binding (binding: WINFORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"Add"
		end

	frozen add_string (property_name: SYSTEM_STRING; data_source: SYSTEM_OBJECT; data_member: SYSTEM_STRING): WINFORMS_BINDING is
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

	remove_core (data_binding: WINFORMS_BINDING) is
		external
			"IL signature (System.Windows.Forms.Binding): System.Void use System.Windows.Forms.ControlBindingsCollection"
		alias
			"RemoveCore"
		end

	add_core (data_binding: WINFORMS_BINDING) is
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

end -- class WINFORMS_CONTROL_BINDINGS_COLLECTION
