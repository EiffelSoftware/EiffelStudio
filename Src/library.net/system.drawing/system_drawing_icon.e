indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Icon"

frozen external class
	SYSTEM_DRAWING_ICON

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_icon_1,
	make_icon_5,
	make_icon_4,
	make_icon,
	make_icon_3,
	make_icon_2

feature {NONE} -- Initialization

	frozen make_icon_1 (original: SYSTEM_DRAWING_ICON; size: SYSTEM_DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Icon, System.Drawing.Size) use System.Drawing.Icon"
		end

	frozen make_icon_5 (stream: SYSTEM_IO_STREAM; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.IO.Stream, System.Int32, System.Int32) use System.Drawing.Icon"
		end

	frozen make_icon_4 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Drawing.Icon"
		end

	frozen make_icon (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Drawing.Icon"
		end

	frozen make_icon_3 (type: SYSTEM_TYPE; resource: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Drawing.Icon"
		end

	frozen make_icon_2 (original: SYSTEM_DRAWING_ICON; width: INTEGER; height: INTEGER) is
		external
			"IL creator signature (System.Drawing.Icon, System.Int32, System.Int32) use System.Drawing.Icon"
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

	frozen get_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Icon"
		alias
			"get_Size"
		end

feature -- Basic Operations

	frozen to_bitmap: SYSTEM_DRAWING_BITMAP is
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

	frozen from_handle (handle: POINTER): SYSTEM_DRAWING_ICON is
		external
			"IL static signature (System.IntPtr): System.Drawing.Icon use System.Drawing.Icon"
		alias
			"FromHandle"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Drawing.Icon"
		alias
			"ToString"
		end

	frozen clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Icon"
		alias
			"Clone"
		end

	frozen save (output_stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Drawing.Icon"
		alias
			"Save"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
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

end -- class SYSTEM_DRAWING_ICON
