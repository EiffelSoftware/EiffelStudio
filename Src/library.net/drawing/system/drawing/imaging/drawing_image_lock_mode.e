indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ImageLockMode"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_IMAGE_LOCK_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen user_input_buffer: DRAWING_IMAGE_LOCK_MODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"4"
		end

	frozen read_write: DRAWING_IMAGE_LOCK_MODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"3"
		end

	frozen write_only: DRAWING_IMAGE_LOCK_MODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"2"
		end

	frozen read_only: DRAWING_IMAGE_LOCK_MODE is
		external
			"IL enum signature :System.Drawing.Imaging.ImageLockMode use System.Drawing.Imaging.ImageLockMode"
		alias
			"1"
		end

end -- class DRAWING_IMAGE_LOCK_MODE
