indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListViewItem"

external class
	SYSTEM_WINDOWS_FORMS_LISTVIEWITEM

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_6 (sub_items: ARRAY [LISTVIEWSUBITEM_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM]; image_index: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem+ListViewSubItem[], System.Int32) use System.Windows.Forms.ListViewItem"
		end

	frozen make_5 (items: ARRAY [STRING]; image_index: INTEGER; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR; font: SYSTEM_DRAWING_FONT) is
		external
			"IL creator signature (System.String[], System.Int32, System.Drawing.Color, System.Drawing.Color, System.Drawing.Font) use System.Windows.Forms.ListViewItem"
		end

	frozen make_4 (items: ARRAY [STRING]; image_index: INTEGER) is
		external
			"IL creator signature (System.String[], System.Int32) use System.Windows.Forms.ListViewItem"
		end

	frozen make_3 (items: ARRAY [STRING]) is
		external
			"IL creator signature (System.String[]) use System.Windows.Forms.ListViewItem"
		end

	frozen make_2 (text: STRING; image_index: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Windows.Forms.ListViewItem"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.ListViewItem"
		end

	frozen make_1 (text: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.ListViewItem"
		end

feature -- Access

	frozen get_sub_items: LISTVIEWSUBITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (): System.Windows.Forms.ListViewItem+ListViewSubItemCollection use System.Windows.Forms.ListViewItem"
		alias
			"get_SubItems"
		end

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem"
		alias
			"get_BackColor"
		end

	frozen get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.ListViewItem"
		alias
			"get_Font"
		end

	frozen get_list_view: SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView use System.Windows.Forms.ListViewItem"
		alias
			"get_ListView"
		end

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem"
		alias
			"get_ForeColor"
		end

	frozen get_use_item_style_for_sub_items: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem"
		alias
			"get_UseItemStyleForSubItems"
		end

	frozen get_selected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem"
		alias
			"get_Selected"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem"
		alias
			"get_Text"
		end

	frozen get_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ListViewItem"
		alias
			"get_ImageList"
		end

	frozen get_state_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListViewItem"
		alias
			"get_StateImageIndex"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListViewItem"
		alias
			"get_ImageIndex"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ListViewItem"
		alias
			"get_Bounds"
		end

	frozen get_tag: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListViewItem"
		alias
			"get_Tag"
		end

	frozen get_focused: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem"
		alias
			"get_Focused"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListViewItem"
		alias
			"get_Index"
		end

	frozen get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListViewItem"
		alias
			"get_Checked"
		end

feature -- Element Change

	frozen set_state_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_StateImageIndex"
		end

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Text"
		end

	frozen set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_BackColor"
		end

	frozen set_tag (value: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Tag"
		end

	frozen set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Checked"
		end

	frozen set_font (value: SYSTEM_DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Font"
		end

	frozen set_use_item_style_for_sub_items (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_UseItemStyleForSubItems"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_ImageIndex"
		end

	frozen set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_ForeColor"
		end

	frozen set_selected (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Selected"
		end

	frozen set_focused (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Focused"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem"
		alias
			"ToString"
		end

	frozen get_bounds_item_bounds_portion (portion: SYSTEM_WINDOWS_FORMS_ITEMBOUNDSPORTION): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Windows.Forms.ItemBoundsPortion): System.Drawing.Rectangle use System.Windows.Forms.ListViewItem"
		alias
			"GetBounds"
		end

	ensure_visible is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"EnsureVisible"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ListViewItem"
		alias
			"Clone"
		end

	remove is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"Remove"
		end

	frozen begin_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"BeginEdit"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ListViewItem"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ListViewItem"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	deserialize (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"Deserialize"
		end

	serialize (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"Serialize"
		end

	frozen system_runtime_serialization_iserializable_get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"Finalize"
		end

end -- class SYSTEM_WINDOWS_FORMS_LISTVIEWITEM
