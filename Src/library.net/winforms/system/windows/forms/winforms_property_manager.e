indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyManager"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PROPERTY_MANAGER

inherit
	WINFORMS_BINDING_MANAGER_BASE

create
	make_winforms_property_manager

feature {NONE} -- Initialization

	frozen make_winforms_property_manager is
		external
			"IL creator use System.Windows.Forms.PropertyManager"
		end

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PropertyManager"
		alias
			"get_Count"
		end

	get_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.PropertyManager"
		alias
			"get_Position"
		end

	get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.PropertyManager"
		alias
			"get_Current"
		end

feature -- Element Change

	set_position (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"set_Position"
		end

feature -- Basic Operations

	resume_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"ResumeBinding"
		end

	add_new is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"AddNew"
		end

	end_current_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"EndCurrentEdit"
		end

	suspend_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"SuspendBinding"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"RemoveAt"
		end

	get_item_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.PropertyManager"
		alias
			"GetItemProperties"
		end

	cancel_current_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"CancelCurrentEdit"
		end

feature {NONE} -- Implementation

	get_list_name (list_accessors: ARRAY_LIST): SYSTEM_STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use System.Windows.Forms.PropertyManager"
		alias
			"GetListName"
		end

	on_current_changed (ea: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"OnCurrentChanged"
		end

	update_is_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyManager"
		alias
			"UpdateIsBinding"
		end

end -- class WINFORMS_PROPERTY_MANAGER
