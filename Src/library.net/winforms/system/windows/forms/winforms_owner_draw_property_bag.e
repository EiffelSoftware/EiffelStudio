indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.OwnerDrawPropertyBag"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_OWNER_DRAW_PROPERTY_BAG

inherit
	MARSHAL_BY_REF_OBJECT
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create {NONE}

feature -- Access

	frozen get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"get_ForeColor"
		end

	frozen get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"get_Font"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"get_BackColor"
		end

feature -- Element Change

	frozen set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"set_ForeColor"
		end

	frozen set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"set_BackColor"
		end

	frozen set_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"set_Font"
		end

feature -- Basic Operations

	is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"IsEmpty"
		end

	frozen copy_ (value: WINFORMS_OWNER_DRAW_PROPERTY_BAG): WINFORMS_OWNER_DRAW_PROPERTY_BAG is
		external
			"IL static signature (System.Windows.Forms.OwnerDrawPropertyBag): System.Windows.Forms.OwnerDrawPropertyBag use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"Copy"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.OwnerDrawPropertyBag"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class WINFORMS_OWNER_DRAW_PROPERTY_BAG
