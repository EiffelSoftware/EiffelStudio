indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.License"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_LICENSE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE

feature -- Access

	get_license_key: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.ComponentModel.License"
		alias
			"get_LicenseKey"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.License"
		alias
			"GetHashCode"
		end

	dispose is
		external
			"IL deferred signature (): System.Void use System.ComponentModel.License"
		alias
			"Dispose"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.License"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.License"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.ComponentModel.License"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_LICENSE
