indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.MetaHeader"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_META_HEADER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Drawing.Imaging.MetaHeader"
		end

feature -- Access

	frozen get_no_parameters: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_NoParameters"
		end

	frozen get_no_objects: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_NoObjects"
		end

	frozen get_max_record: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_MaxRecord"
		end

	frozen get_header_size: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_HeaderSize"
		end

	frozen get_version: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_Version"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_Size"
		end

	frozen get_type_int16: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Drawing.Imaging.MetaHeader"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_max_record (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_MaxRecord"
		end

	frozen set_no_parameters (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_NoParameters"
		end

	frozen set_size (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_Size"
		end

	frozen set_type (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_Type"
		end

	frozen set_version (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_Version"
		end

	frozen set_no_objects (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_NoObjects"
		end

	frozen set_header_size (value: INTEGER_16) is
		external
			"IL signature (System.Int16): System.Void use System.Drawing.Imaging.MetaHeader"
		alias
			"set_HeaderSize"
		end

end -- class DRAWING_META_HEADER
