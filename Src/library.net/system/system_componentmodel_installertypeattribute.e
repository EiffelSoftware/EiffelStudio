indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.InstallerTypeAttribute"

external class
	SYSTEM_COMPONENTMODEL_INSTALLERTYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_installertypeattribute,
	make_installertypeattribute_1

feature {NONE} -- Initialization

	frozen make_installertypeattribute (installer_type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.InstallerTypeAttribute"
		end

	frozen make_installertypeattribute_1 (type_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.InstallerTypeAttribute"
		end

feature -- Access

	get_installer_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.InstallerTypeAttribute"
		alias
			"get_InstallerType"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.InstallerTypeAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.InstallerTypeAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_INSTALLERTYPEATTRIBUTE
