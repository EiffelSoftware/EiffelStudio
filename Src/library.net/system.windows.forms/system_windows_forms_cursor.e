indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Cursor"

frozen external class
	SYSTEM_WINDOWS_FORMS_CURSOR

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			finalize,
			get_hash_code,
			equals_object,
			to_string
		end
	SYSTEM_IDISPOSABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data,
			is_equal as equals_object
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Windows.Forms.Cursor"
		end

	frozen make_2 (type: SYSTEM_TYPE; resource: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Windows.Forms.Cursor"
		end

	frozen make (handle: POINTER) is
		external
			"IL creator signature (System.IntPtr) use System.Windows.Forms.Cursor"
		end

	frozen make_1 (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.Cursor"
		end

feature -- Access

	frozen get_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.Cursor"
		alias
			"get_Size"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Cursor"
		alias
			"get_Handle"
		end

	frozen get_current: SYSTEM_WINDOWS_FORMS_CURSOR is
		external
			"IL static signature (): System.Windows.Forms.Cursor use System.Windows.Forms.Cursor"
		alias
			"get_Current"
		end

	frozen get_position: SYSTEM_DRAWING_POINT is
		external
			"IL static signature (): System.Drawing.Point use System.Windows.Forms.Cursor"
		alias
			"get_Position"
		end

	frozen get_clip: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL static signature (): System.Drawing.Rectangle use System.Windows.Forms.Cursor"
		alias
			"get_Clip"
		end

feature -- Element Change

	frozen set_clip (value: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Cursor"
		alias
			"set_Clip"
		end

	frozen set_position (value: SYSTEM_DRAWING_POINT) is
		external
			"IL static signature (System.Drawing.Point): System.Void use System.Windows.Forms.Cursor"
		alias
			"set_Position"
		end

	frozen set_current (value: SYSTEM_WINDOWS_FORMS_CURSOR) is
		external
			"IL static signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.Cursor"
		alias
			"set_Current"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Cursor"
		alias
			"ToString"
		end

	frozen show is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Cursor"
		alias
			"Show"
		end

	frozen copy_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Cursor"
		alias
			"CopyHandle"
		end

	frozen draw (g: SYSTEM_DRAWING_GRAPHICS; target_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.Cursor"
		alias
			"Draw"
		end

	frozen hide is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Cursor"
		alias
			"Hide"
		end

	frozen draw_stretched (g: SYSTEM_DRAWING_GRAPHICS; target_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.Cursor"
		alias
			"DrawStretched"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.Cursor"
		alias
			"Equals"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Windows.Forms.Cursor"
		alias
			"Dispose"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Cursor"
		alias
			"GetHashCode"
		end

feature -- Binary Operators

	frozen infix "#==" (right: SYSTEM_WINDOWS_FORMS_CURSOR): BOOLEAN is
		external
			"IL operator  signature (System.Windows.Forms.Cursor): System.Boolean use System.Windows.Forms.Cursor"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: SYSTEM_WINDOWS_FORMS_CURSOR): BOOLEAN is
		external
			"IL operator  signature (System.Windows.Forms.Cursor): System.Boolean use System.Windows.Forms.Cursor"
		alias
			"op_Inequality"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.Cursor"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.Cursor"
		alias
			"Finalize"
		end

end -- class SYSTEM_WINDOWS_FORMS_CURSOR
