indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.ListChangedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_LIST_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_list_changed_event_args_1,
	make_system_dll_list_changed_event_args_2,
	make_system_dll_list_changed_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_list_changed_event_args_1 (list_changed_type: SYSTEM_DLL_LIST_CHANGED_TYPE; prop_desc: SYSTEM_DLL_PROPERTY_DESCRIPTOR) is
		external
			"IL creator signature (System.ComponentModel.ListChangedType, System.ComponentModel.PropertyDescriptor) use System.ComponentModel.ListChangedEventArgs"
		end

	frozen make_system_dll_list_changed_event_args_2 (list_changed_type: SYSTEM_DLL_LIST_CHANGED_TYPE; new_index: INTEGER; old_index: INTEGER) is
		external
			"IL creator signature (System.ComponentModel.ListChangedType, System.Int32, System.Int32) use System.ComponentModel.ListChangedEventArgs"
		end

	frozen make_system_dll_list_changed_event_args (list_changed_type: SYSTEM_DLL_LIST_CHANGED_TYPE; new_index: INTEGER) is
		external
			"IL creator signature (System.ComponentModel.ListChangedType, System.Int32) use System.ComponentModel.ListChangedEventArgs"
		end

feature -- Access

	frozen get_new_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ListChangedEventArgs"
		alias
			"get_NewIndex"
		end

	frozen get_list_changed_type: SYSTEM_DLL_LIST_CHANGED_TYPE is
		external
			"IL signature (): System.ComponentModel.ListChangedType use System.ComponentModel.ListChangedEventArgs"
		alias
			"get_ListChangedType"
		end

	frozen get_old_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ListChangedEventArgs"
		alias
			"get_OldIndex"
		end

end -- class SYSTEM_DLL_LIST_CHANGED_EVENT_ARGS
