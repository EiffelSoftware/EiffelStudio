indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.ToolboxBitmapAttribute"

external class
	SYSTEM_DRAWING_TOOLBOXBITMAPATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_toolboxbitmapattribute_1,
	make_toolboxbitmapattribute,
	make_toolboxbitmapattribute_2

feature {NONE} -- Initialization

	frozen make_toolboxbitmapattribute_1 (t: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Drawing.ToolboxBitmapAttribute"
		end

	frozen make_toolboxbitmapattribute (image_file: STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.ToolboxBitmapAttribute"
		end

	frozen make_toolboxbitmapattribute_2 (t: SYSTEM_TYPE; name: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Drawing.ToolboxBitmapAttribute"
		end

feature -- Access

	frozen default: SYSTEM_DRAWING_TOOLBOXBITMAPATTRIBUTE is
		external
			"IL static_field signature :System.Drawing.ToolboxBitmapAttribute use System.Drawing.ToolboxBitmapAttribute"
		alias
			"Default"
		end

feature -- Basic Operations

	frozen get_image_object_boolean (component: ANY; large: BOOLEAN): SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (System.Object, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_object (component: ANY): SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (System.Object): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_type_boolean (type: SYSTEM_TYPE; large: BOOLEAN): SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (System.Type, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	equals_object (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.ToolboxBitmapAttribute"
		alias
			"Equals"
		end

	frozen get_image_from_resource (t: SYSTEM_TYPE; image_name: STRING; large: BOOLEAN): SYSTEM_DRAWING_IMAGE is
		external
			"IL static signature (System.Type, System.String, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImageFromResource"
		end

	frozen get_image (type: SYSTEM_TYPE): SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (System.Type): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_type_string (type: SYSTEM_TYPE; img_name: STRING; large: BOOLEAN): SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (System.Type, System.String, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_DRAWING_TOOLBOXBITMAPATTRIBUTE
