indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.CollectionChangeEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_collection_change_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_collection_change_event_args (action: SYSTEM_DLL_COLLECTION_CHANGE_ACTION; element: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.ComponentModel.CollectionChangeAction, System.Object) use System.ComponentModel.CollectionChangeEventArgs"
		end

feature -- Access

	get_element: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.CollectionChangeEventArgs"
		alias
			"get_Element"
		end

	get_action: SYSTEM_DLL_COLLECTION_CHANGE_ACTION is
		external
			"IL signature (): System.ComponentModel.CollectionChangeAction use System.ComponentModel.CollectionChangeEventArgs"
		alias
			"get_Action"
		end

end -- class SYSTEM_DLL_COLLECTION_CHANGE_EVENT_ARGS
