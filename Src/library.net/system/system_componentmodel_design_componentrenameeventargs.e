indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ComponentRenameEventArgs"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_componentrenameeventargs

feature {NONE} -- Initialization

	frozen make_componentrenameeventargs (component: ANY; old_name: STRING; new_name: STRING) is
		external
			"IL creator signature (System.Object, System.String, System.String) use System.ComponentModel.Design.ComponentRenameEventArgs"
		end

feature -- Access

	frozen get_component: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.ComponentRenameEventArgs"
		alias
			"get_Component"
		end

	get_old_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.ComponentRenameEventArgs"
		alias
			"get_OldName"
		end

	get_new_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.ComponentRenameEventArgs"
		alias
			"get_NewName"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTARGS
