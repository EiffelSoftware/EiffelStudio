indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.OperatingSystem"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	OPERATING_SYSTEM

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE

create
	make

feature {NONE} -- Initialization

	frozen make (platform: PLATFORM_ID; version: VERSION) is
		external
			"IL creator signature (System.PlatformID, System.Version) use System.OperatingSystem"
		end

feature -- Access

	frozen get_version: VERSION is
		external
			"IL signature (): System.Version use System.OperatingSystem"
		alias
			"get_Version"
		end

	frozen get_platform: PLATFORM_ID is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.OperatingSystem"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.OperatingSystem"
		alias
			"Clone"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class OPERATING_SYSTEM
