indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Container"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CONTAINER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICONTAINER
	IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.ComponentModel.Container"
		end

feature -- Access

	get_components: SYSTEM_DLL_COMPONENT_COLLECTION is
		external
			"IL signature (): System.ComponentModel.ComponentCollection use System.ComponentModel.Container"
		alias
			"get_Components"
		end

feature -- Basic Operations

	add_icomponent_string (component: SYSTEM_DLL_ICOMPONENT; name: SYSTEM_STRING) is
		external
			"IL signature (System.ComponentModel.IComponent, System.String): System.Void use System.ComponentModel.Container"
		alias
			"Add"
		end

	frozen dispose is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Container"
		alias
			"ToString"
		end

	add (component: SYSTEM_DLL_ICOMPONENT) is
		external
			"IL signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Container"
		alias
			"Add"
		end

	remove (component: SYSTEM_DLL_ICOMPONENT) is
		external
			"IL signature (System.ComponentModel.IComponent): System.Void use System.ComponentModel.Container"
		alias
			"Remove"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.Container"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	get_service (service: TYPE): SYSTEM_OBJECT is
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

	create_site (component: SYSTEM_DLL_ICOMPONENT; name: SYSTEM_STRING): SYSTEM_DLL_ISITE is
		external
			"IL signature (System.ComponentModel.IComponent, System.String): System.ComponentModel.ISite use System.ComponentModel.Container"
		alias
			"CreateSite"
		end

end -- class SYSTEM_DLL_CONTAINER
