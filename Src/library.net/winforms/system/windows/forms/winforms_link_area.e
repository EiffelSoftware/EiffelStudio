indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.LinkArea"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	WINFORMS_LINK_AREA

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			equals
		end

feature -- Initialization

	frozen make_winforms_link_area (start: INTEGER; length: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32) use System.Windows.Forms.LinkArea"
		end

feature -- Access

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.LinkArea"
		alias
			"get_IsEmpty"
		end

	frozen get_length: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkArea"
		alias
			"get_Length"
		end

	frozen get_start: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkArea"
		alias
			"get_Start"
		end

feature -- Element Change

	frozen set_length (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.LinkArea"
		alias
			"set_Length"
		end

	frozen set_start (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.LinkArea"
		alias
			"set_Start"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.LinkArea"
		alias
			"GetHashCode"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.LinkArea"
		alias
			"Equals"
		end

end -- class WINFORMS_LINK_AREA
