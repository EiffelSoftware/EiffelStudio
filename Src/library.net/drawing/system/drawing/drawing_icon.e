indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Icon"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_ICON

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize,
			to_string
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_icon,
	make_drawing_icon_2,
	make_drawing_icon_3,
	make_drawing_icon_1,
	make_drawing_icon_4,
	make_drawing_icon_5

feature {NONE} -- Initialization

	frozen make_drawing_icon (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.Icon"
		end

	frozen make_drawing_icon_2 (original: DRAWING_ICON; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Drawing.Icon, System.Int32, System.Int32) use System.Drawing.Icon"
		end

	frozen make_drawing_icon_3 (type: TYPE; resource: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Drawing.Icon"
		end

	frozen make_drawing_icon_1 (original: DRAWING_ICON; size: DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Icon, System.Drawing.Size) use System.Drawing.Icon"
		end

	frozen make_drawing_icon_4 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Drawing.Icon"
		end

	frozen make_drawing_icon_5 (stream: SYSTEM_STREAM; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Int32, System.Int32) use System.Drawing.Icon"
		end

feature -- Access

	frozen get_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Icon"
		alias
			"get_Height"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Icon"
		alias
			"get_Handle"
		end

	frozen get_width: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Icon"
		alias
			"get_Width"
		end

	frozen get_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Icon"
		alias
			"get_Size"
		end

feature -- Basic Operations

	frozen to_bitmap: DRAWING_BITMAP is
		external
			"IL signature (): System.Drawing.Bitmap use System.Drawing.Icon"
		alias
			"ToBitmap"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Icon"
		alias
			"Dispose"
		end

	frozen from_handle (handle: POINTER): DRAWING_ICON is
		external
			"IL static signature (System.IntPtr): System.Drawing.Icon use System.Drawing.Icon"
		alias
			"FromHandle"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Drawing.Icon"
		alias
			"ToString"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Icon"
		alias
			"Clone"
		end

	frozen save (output_stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Drawing.Icon"
		alias
			"Save"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Drawing.Icon"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Icon"
		alias
			"Finalize"
		end

end -- class DRAWING_ICON
