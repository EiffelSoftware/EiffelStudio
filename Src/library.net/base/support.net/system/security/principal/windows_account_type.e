indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Principal.WindowsAccountType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINDOWS_ACCOUNT_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen guest: WINDOWS_ACCOUNT_TYPE is
		external
			"IL enum signature :System.Security.Principal.WindowsAccountType use System.Security.Principal.WindowsAccountType"
		alias
			"1"
		end

	frozen anonymous: WINDOWS_ACCOUNT_TYPE is
		external
			"IL enum signature :System.Security.Principal.WindowsAccountType use System.Security.Principal.WindowsAccountType"
		alias
			"3"
		end

	frozen system: WINDOWS_ACCOUNT_TYPE is
		external
			"IL enum signature :System.Security.Principal.WindowsAccountType use System.Security.Principal.WindowsAccountType"
		alias
			"2"
		end

	frozen normal: WINDOWS_ACCOUNT_TYPE is
		external
			"IL enum signature :System.Security.Principal.WindowsAccountType use System.Security.Principal.WindowsAccountType"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

	from_integer (a_value: INTEGER): like Current is
		do
			--Built-in
		end

	to_integer: INTEGER is
		do
			--Built-in
		end

end -- class WINDOWS_ACCOUNT_TYPE
