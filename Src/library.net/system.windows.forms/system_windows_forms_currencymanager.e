indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.CurrencyManager"

external class
	SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER

inherit
	SYSTEM_WINDOWS_FORMS_BINDINGMANAGERBASE

create {NONE}

feature -- Access

	get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CurrencyManager"
		alias
			"get_Count"
		end

	frozen get_list: SYSTEM_COLLECTIONS_ILIST is
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

	get_current: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.CurrencyManager"
		alias
			"get_Current"
		end

feature -- Element Change

	frozen add_item_changed (value: SYSTEM_WINDOWS_FORMS_ITEMCHANGEDEVENTHANDLER) is
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

	frozen remove_item_changed (value: SYSTEM_WINDOWS_FORMS_ITEMCHANGEDEVENTHANDLER) is
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

	get_item_properties: SYSTEM_COMPONENTMODEL_PROPERTYDESCRIPTORCOLLECTION is
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

	get_list_name (list_accessors: SYSTEM_COLLECTIONS_ARRAYLIST): STRING is
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

	on_position_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"OnPositionChanged"
		end

	on_current_changed (e: SYSTEM_EVENTARGS) is
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

	on_item_changed (e: SYSTEM_WINDOWS_FORMS_ITEMCHANGEDEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ItemChangedEventArgs): System.Void use System.Windows.Forms.CurrencyManager"
		alias
			"OnItemChanged"
		end

end -- class SYSTEM_WINDOWS_FORMS_CURRENCYMANAGER
