indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.License"

deferred external class
	SYSTEM_COMPONENTMODEL_LICENSE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_IDISPOSABLE

feature -- Access

	get_license_key: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.License"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_COMPONENTMODEL_LICENSE
