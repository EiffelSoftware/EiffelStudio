indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ComponentRenameEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPONENT_RENAME_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_component_rename_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_component_rename_event_args (component: SYSTEM_OBJECT; old_name: SYSTEM_STRING; new_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Object, System.String, System.String) use System.ComponentModel.Design.ComponentRenameEventArgs"
		end

feature -- Access

	frozen get_component: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentRenameEventArgs"
		alias
			"get_Component"
		end

	get_old_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.ComponentRenameEventArgs"
		alias
			"get_OldName"
		end

	get_new_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.ComponentRenameEventArgs"
		alias
			"get_NewName"
		end

end -- class SYSTEM_DLL_COMPONENT_RENAME_EVENT_ARGS
