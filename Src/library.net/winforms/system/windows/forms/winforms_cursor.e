indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Cursor"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_CURSOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IDISPOSABLE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Windows.Forms.Cursor"
		end

	frozen make_2 (type: TYPE; resource: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Windows.Forms.Cursor"
		end

	frozen make (handle: POINTER) is
		external
			"IL creator signature (System.IntPtr) use System.Windows.Forms.Cursor"
		end

	frozen make_1 (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.Cursor"
		end

feature -- Access

	frozen get_size: DRAWING_SIZE is
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

	frozen get_current: WINFORMS_CURSOR is
		external
			"IL static signature (): System.Windows.Forms.Cursor use System.Windows.Forms.Cursor"
		alias
			"get_Current"
		end

	frozen get_position: DRAWING_POINT is
		external
			"IL static signature (): System.Drawing.Point use System.Windows.Forms.Cursor"
		alias
			"get_Position"
		end

	frozen get_clip: DRAWING_RECTANGLE is
		external
			"IL static signature (): System.Drawing.Rectangle use System.Windows.Forms.Cursor"
		alias
			"get_Clip"
		end

feature -- Element Change

	frozen set_clip (value: DRAWING_RECTANGLE) is
		external
			"IL static signature (System.Drawing.Rectangle): System.Void use System.Windows.Forms.Cursor"
		alias
			"set_Clip"
		end

	frozen set_position (value: DRAWING_POINT) is
		external
			"IL static signature (System.Drawing.Point): System.Void use System.Windows.Forms.Cursor"
		alias
			"set_Position"
		end

	frozen set_current (value: WINFORMS_CURSOR) is
		external
			"IL static signature (System.Windows.Forms.Cursor): System.Void use System.Windows.Forms.Cursor"
		alias
			"set_Current"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
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

	frozen draw (g: DRAWING_GRAPHICS; target_rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.Cursor"
		alias
			"Draw"
		end

	frozen draw_stretched (g: DRAWING_GRAPHICS; target_rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Rectangle): System.Void use System.Windows.Forms.Cursor"
		alias
			"DrawStretched"
		end

	frozen hide is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Cursor"
		alias
			"Hide"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	frozen infix "#==" (right: WINFORMS_CURSOR): BOOLEAN is
		external
			"IL operator signature (System.Windows.Forms.Cursor): System.Boolean use System.Windows.Forms.Cursor"
		alias
			"op_Equality"
		end

	frozen infix "|=" (right: WINFORMS_CURSOR): BOOLEAN is
		external
			"IL operator signature (System.Windows.Forms.Cursor): System.Boolean use System.Windows.Forms.Cursor"
		alias
			"op_Inequality"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
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

end -- class WINFORMS_CURSOR
