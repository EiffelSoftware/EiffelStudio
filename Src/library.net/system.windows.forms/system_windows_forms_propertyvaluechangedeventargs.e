indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertyValueChangedEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_PROPERTYVALUECHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_propertyvaluechangedeventargs

feature {NONE} -- Initialization

	frozen make_propertyvaluechangedeventargs (changed_item: SYSTEM_WINDOWS_FORMS_GRIDITEM; old_value: ANY) is
		external
			"IL creator signature (System.Windows.Forms.GridItem, System.Object) use System.Windows.Forms.PropertyValueChangedEventArgs"
		end

feature -- Access

	frozen get_changed_item: SYSTEM_WINDOWS_FORMS_GRIDITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.PropertyValueChangedEventArgs"
		alias
			"get_ChangedItem"
		end

	frozen get_old_value: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.PropertyValueChangedEventArgs"
		alias
			"get_OldValue"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYVALUECHANGEDEVENTARGS
