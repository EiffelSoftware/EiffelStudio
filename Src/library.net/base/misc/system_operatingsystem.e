indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	frozen make (platform: INTEGER; version: SYSTEM_VERSION) is
			-- Valid values for `platform' are:
			-- Win32S = 0
			-- Win32Windows = 1
			-- Win32NT = 2
		require
			valid_platform_id: platform = 0 or platform = 1 or platform = 2
		external
			"IL creator signature (enum System.PlatformID, System.Version) use System.OperatingSystem"
		end

feature -- Access

	frozen get_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.OperatingSystem"
		alias
			"get_Version"
		end

	frozen get_platform: INTEGER is
		external
			"IL signature (): enum System.PlatformID use System.OperatingSystem"
		alias
			"get_Platform"
		ensure
			valid_platform_id: Result = 0 or Result = 1 or Result = 2
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
