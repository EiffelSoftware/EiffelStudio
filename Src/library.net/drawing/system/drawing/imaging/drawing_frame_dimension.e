indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.FrameDimension"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_FRAME_DIMENSION

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (guid: GUID) is
		external
			"IL creator signature (System.Guid) use System.Drawing.Imaging.FrameDimension"
		end

feature -- Access

	frozen get_guid: GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Guid"
		end

	frozen get_time: DRAWING_FRAME_DIMENSION is
		external
			"IL static signature (): System.Drawing.Imaging.FrameDimension use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Time"
		end

	frozen get_page: DRAWING_FRAME_DIMENSION is
		external
			"IL static signature (): System.Drawing.Imaging.FrameDimension use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Page"
		end

	frozen get_resolution: DRAWING_FRAME_DIMENSION is
		external
			"IL static signature (): System.Drawing.Imaging.FrameDimension use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Resolution"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.FrameDimension"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.FrameDimension"
		alias
			"ToString"
		end

	equals (o: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.FrameDimension"
		alias
			"Equals"
		end

end -- class DRAWING_FRAME_DIMENSION
