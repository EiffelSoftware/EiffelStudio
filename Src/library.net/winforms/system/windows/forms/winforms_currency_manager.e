indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CurrencyManager"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CURRENCY_MANAGER

inherit
	WINFORMS_BINDING_MANAGER_BASE

create {NONE}

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CurrencyManager"
		alias
			"get_Count"
		end

	frozen get_list: ILIST is
		external
			"IL signature (): System.Collections.IList use System.Windows.Forms.CurrencyManager"
		alias
			"get_List"
		end

	get_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CurrencyManager"
		alias
			"get_Position"
		end

	get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.CurrencyManager"
		alias
			"get_Current"
		end

feature -- Element Change

	frozen add_item_changed (value: WINFORMS_ITEM_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemChangedEventHandler): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"add_ItemChanged"
		end

	set_position (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"set_Position"
		end

	frozen remove_item_changed (value: WINFORMS_ITEM_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemChangedEventHandler): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"remove_ItemChanged"
		end

feature -- Basic Operations

	add_new is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"AddNew"
		end

	end_current_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"EndCurrentEdit"
		end

	get_item_properties: SYSTEM_DLL_PROPERTY_DESCRIPTOR_COLLECTION is
		external
			"IL signature (): System.ComponentModel.PropertyDescriptorCollection use System.Windows.Forms.CurrencyManager"
		alias
			"GetItemProperties"
		end

	cancel_current_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"CancelCurrentEdit"
		end

	frozen refresh is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"Refresh"
		end

	suspend_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"SuspendBinding"
		end

	resume_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"ResumeBinding"
		end

	remove_at (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"RemoveAt"
		end

feature {NONE} -- Implementation

	get_list_name (list_accessors: ARRAY_LIST): SYSTEM_STRING is
		external
			"IL signature (System.Collections.ArrayList): System.String use System.Windows.Forms.CurrencyManager"
		alias
			"GetListName"
		end

	frozen check_empty is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"CheckEmpty"
		end

	on_position_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"OnPositionChanged"
		end

	on_current_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"OnCurrentChanged"
		end

	update_is_binding is
		external
			"IL signature (): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"UpdateIsBinding"
		end

	on_item_changed (e: WINFORMS_ITEM_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ItemChangedEventArgs): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"OnItemChanged"
		end

end -- class WINFORMS_CURRENCY_MANAGER
