indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.RegionData"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_REGION_DATA

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_data: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Drawing.Drawing2D.RegionData"
		alias
			"get_Data"
		end

feature -- Element Change

	frozen set_data (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Drawing.Drawing2D.RegionData"
		alias
			"set_Data"
		end

end -- class DRAWING_REGION_DATA
