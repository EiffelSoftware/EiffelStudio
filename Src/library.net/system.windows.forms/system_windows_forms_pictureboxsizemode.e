indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PictureBoxSizeMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE

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

	frozen auto_size: SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.PictureBoxSizeMode use System.Windows.Forms.PictureBoxSizeMode"
		alias
			"2"
		end

	frozen center_image: SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.PictureBoxSizeMode use System.Windows.Forms.PictureBoxSizeMode"
		alias
			"3"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.PictureBoxSizeMode use System.Windows.Forms.PictureBoxSizeMode"
		alias
			"0"
		end

	frozen stretch_image: SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.PictureBoxSizeMode use System.Windows.Forms.PictureBoxSizeMode"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_PICTUREBOXSIZEMODE
