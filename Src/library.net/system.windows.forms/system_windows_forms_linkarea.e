indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.LinkArea"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_LINKAREA

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal
		end



feature -- Initialization

	frozen make_linkarea (start: INTEGER; length: INTEGER) is
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

	is_equal (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.LinkArea"
		alias
			"Equals"
		end

end -- class SYSTEM_WINDOWS_FORMS_LINKAREA
