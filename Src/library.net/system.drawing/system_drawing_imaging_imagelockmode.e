indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ImageLockMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen user_input_buffer: SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"4"
		end

	frozen read_write: SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"3"
		end

	frozen write_only: SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"2"
		end

	frozen read_only: SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_IMAGING_IMAGELOCKMODE
