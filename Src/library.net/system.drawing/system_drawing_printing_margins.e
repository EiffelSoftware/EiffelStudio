indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.Margins"

external class
	SYSTEM_DRAWING_PRINTING_MARGINS

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Printing.Margins"
		end

	frozen make_1 (left: INTEGER; right: INTEGER; top: INTEGER; bottom: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.Drawing.Printing.Margins"
		end

feature -- Access

	frozen get_right: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.Margins"
		alias
			"get_Right"
		end

	frozen get_top: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.Margins"
		alias
			"get_Top"
		end

	frozen get_bottom: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.Margins"
		alias
			"get_Bottom"
		end

	frozen get_left: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.Margins"
		alias
			"get_Left"
		end

feature -- Element Change

	frozen set_right (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.Margins"
		alias
			"set_Right"
		end

	frozen set_bottom (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.Margins"
		alias
			"set_Bottom"
		end

	frozen set_left (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.Margins"
		alias
			"set_Left"
		end

	frozen set_top (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Printing.Margins"
		alias
			"set_Top"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Printing.Margins"
		alias
			"GetHashCode"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Printing.Margins"
		alias
			"Clone"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Printing.Margins"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Printing.Margins"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Printing.Margins"
		alias
			"Finalize"
		end

end -- class SYSTEM_DRAWING_PRINTING_MARGINS
