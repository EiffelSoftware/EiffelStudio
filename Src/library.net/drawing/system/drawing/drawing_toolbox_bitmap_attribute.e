indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.ToolboxBitmapAttribute"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_TOOLBOX_BITMAP_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_drawing_toolbox_bitmap_attribute_2,
	make_drawing_toolbox_bitmap_attribute,
	make_drawing_toolbox_bitmap_attribute_1

feature {NONE} -- Initialization

	frozen make_drawing_toolbox_bitmap_attribute_2 (t: TYPE; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Drawing.ToolboxBitmapAttribute"
		end

	frozen make_drawing_toolbox_bitmap_attribute (image_file: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.ToolboxBitmapAttribute"
		end

	frozen make_drawing_toolbox_bitmap_attribute_1 (t: TYPE) is
		external
			"IL creator signature (System.Type) use System.Drawing.ToolboxBitmapAttribute"
		end

feature -- Access

	frozen default_: DRAWING_TOOLBOX_BITMAP_ATTRIBUTE is
		external
			"IL static_field signature :System.Drawing.ToolboxBitmapAttribute use System.Drawing.ToolboxBitmapAttribute"
		alias
			"Default"
		end

feature -- Basic Operations

	frozen get_image_object_boolean (component: SYSTEM_OBJECT; large: BOOLEAN): DRAWING_IMAGE is
		external
			"IL signature (System.Object, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_object (component: SYSTEM_OBJECT): DRAWING_IMAGE is
		external
			"IL signature (System.Object): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_type_boolean (type: TYPE; large: BOOLEAN): DRAWING_IMAGE is
		external
			"IL signature (System.Type, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image (type: TYPE): DRAWING_IMAGE is
		external
			"IL signature (System.Type): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_type_string (type: TYPE; img_name: SYSTEM_STRING; large: BOOLEAN): DRAWING_IMAGE is
		external
			"IL signature (System.Type, System.String, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImage"
		end

	frozen get_image_from_resource (t: TYPE; image_name: SYSTEM_STRING; large: BOOLEAN): DRAWING_IMAGE is
		external
			"IL static signature (System.Type, System.String, System.Boolean): System.Drawing.Image use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetImageFromResource"
		end

	equals (value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Drawing.ToolboxBitmapAttribute"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.ToolboxBitmapAttribute"
		alias
			"GetHashCode"
		end

end -- class DRAWING_TOOLBOX_BITMAP_ATTRIBUTE
