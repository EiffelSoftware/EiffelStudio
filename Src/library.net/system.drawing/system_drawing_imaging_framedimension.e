indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.FrameDimension"

frozen external class
	SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create
	make

feature {NONE} -- Initialization

	frozen make (guid: SYSTEM_GUID) is
		external
			"IL creator signature (System.Guid) use System.Drawing.Imaging.FrameDimension"
		end

feature -- Access

	frozen get_guid: SYSTEM_GUID is
		external
			"IL signature (): System.Guid use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Guid"
		end

	frozen get_time: SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION is
		external
			"IL static signature (): System.Drawing.Imaging.FrameDimension use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Time"
		end

	frozen get_page: SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION is
		external
			"IL static signature (): System.Drawing.Imaging.FrameDimension use System.Drawing.Imaging.FrameDimension"
		alias
			"get_Page"
		end

	frozen get_resolution: SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION is
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

	equals_object (o: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.Imaging.FrameDimension"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Imaging.FrameDimension"
		alias
			"ToString"
		end

end -- class SYSTEM_DRAWING_IMAGING_FRAMEDIMENSION
