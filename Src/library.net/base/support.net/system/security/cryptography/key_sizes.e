indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.KeySizes"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	KEY_SIZES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (min_size: INTEGER; max_size: INTEGER; skip_size: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32) use System.Security.Cryptography.KeySizes"
		end

feature -- Access

	frozen get_max_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.KeySizes"
		alias
			"get_MaxSize"
		end

	frozen get_min_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.KeySizes"
		alias
			"get_MinSize"
		end

	frozen get_skip_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.KeySizes"
		alias
			"get_SkipSize"
		end

end -- class KEY_SIZES
