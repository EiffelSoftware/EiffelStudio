indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.RefreshEventArgs"

external class
	SYSTEM_COMPONENTMODEL_REFRESHEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_refresheventargs,
	make_refresheventargs_1

feature {NONE} -- Initialization

	frozen make_refresheventargs (component_changed: ANY) is
		external
			"IL creator signature (System.Object) use System.ComponentModel.RefreshEventArgs"
		end

	frozen make_refresheventargs_1 (type_changed: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.RefreshEventArgs"
		end

feature -- Access

	frozen get_component_changed: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.RefreshEventArgs"
		alias
			"get_ComponentChanged"
		end

	frozen get_type_changed: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.RefreshEventArgs"
		alias
			"get_TypeChanged"
		end

end -- class SYSTEM_COMPONENTMODEL_REFRESHEVENTARGS
