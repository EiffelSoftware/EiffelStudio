indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Container"

external class
	SYSTEM_COMPONENTMODEL_CONTAINER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICONTAINER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Container"
		end

feature -- Access

	get_components: SYSTEM_COMPONENTMODEL_COMPONENTCOLLECTION is
		external
			"IL signature (): System.ComponentModel.ComponentCollection use System.ComponentModel.Container"
		alias
			"get_Components"
		end

feature -- Basic Operations

	add_icomponent_string (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; name: STRING) is
		external
			"IL signature (System.ComponentModel.IComponent, System.String): System.Void use System.ComponentModel.Container"
		alias
			"Add"
		end

	dispose is
		external
			"IL signature (): System.Void use System.ComponentModel.Container"
		alias
			"Dispose"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.Container"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Container"
		alias
			"ToString"
		end

	add (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Container"
		alias
			"Add"
		end

	remove (component: SYSTEM_COMPONENTMODEL_ICOMPONENT) is
		external
			"IL signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Container"
		alias
			"Remove"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Container"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	get_service (service: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.ComponentModel.Container"
		alias
			"GetService"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.ComponentModel.Container"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.Container"
		alias
			"Finalize"
		end

	create_site (component: SYSTEM_COMPONENTMODEL_ICOMPONENT; name: STRING): SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL signature (System.ComponentModel.IComponent, System.String): System.ComponentModel.ISite use System.ComponentModel.Container"
		alias
			"CreateSite"
		end

end -- class SYSTEM_COMPONENTMODEL_CONTAINER
