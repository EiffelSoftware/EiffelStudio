indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.OperatingSystem"

frozen external class
	SYSTEM_OPERATINGSYSTEM

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE

create
	make

feature {NONE} -- Initialization

	frozen make (platform: SYSTEM_PLATFORMID; version: SYSTEM_VERSION) is
		external
			"IL creator signature (System.PlatformID, System.Version) use System.OperatingSystem"
		end

feature -- Access

	frozen get_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.OperatingSystem"
		alias
			"get_Version"
		end

	frozen get_platform: SYSTEM_PLATFORMID is
		external
			"IL signature (): System.PlatformID use System.OperatingSystem"
		alias
			"get_Platform"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.OperatingSystem"
		alias
			"GetHashCode"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.OperatingSystem"
		alias
			"Clone"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.OperatingSystem"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.OperatingSystem"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.OperatingSystem"
		alias
			"Finalize"
		end

end -- class SYSTEM_OPERATINGSYSTEM
