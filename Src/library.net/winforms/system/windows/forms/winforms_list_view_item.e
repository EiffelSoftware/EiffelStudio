indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ListViewItem"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_LIST_VIEW_ITEM

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
	ISERIALIZABLE
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

	frozen make_6 (sub_items: NATIVE_ARRAY [WINFORMS_LIST_VIEW_SUB_ITEM_IN_WINFORMS_LIST_VIEW_ITEM]; image_index: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.ListViewItem+ListViewSubItem[], System.Int32) use System.Windows.Forms.ListViewItem"
		end

	frozen make_5 (items: NATIVE_ARRAY [SYSTEM_STRING]; image_index: INTEGER; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR; font: DRAWING_FONT) is
		external
			"IL creator signature (System.String[], System.Int32, System.Drawing.Color, System.Drawing.Color, System.Drawing.Font) use System.Windows.Forms.ListViewItem"
		end

	frozen make_4 (items: NATIVE_ARRAY [SYSTEM_STRING]; image_index: INTEGER) is
		external
			"IL creator signature (System.String[], System.Int32) use System.Windows.Forms.ListViewItem"
		end

	frozen make_3 (items: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String[]) use System.Windows.Forms.ListViewItem"
		end

	frozen make_2 (text: SYSTEM_STRING; image_index: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32) use System.Windows.Forms.ListViewItem"
		end

	frozen make is
		external
			"IL creator use System.Windows.Forms.ListViewItem"
		end

	frozen make_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.ListViewItem"
		end

feature -- Access

	frozen get_sub_items: WINFORMS_LIST_VIEW_SUB_ITEM_COLLECTION_IN_WINFORMS_LIST_VIEW_ITEM is
		external
			"IL signature (): System.Windows.Forms.ListViewItem+ListViewSubItemCollection use System.Windows.Forms.ListViewItem"
		alias
			"get_SubItems"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListViewItem"
		alias
			"get_BackColor"
		end

	frozen get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.ListViewItem"
		alias
			"get_Font"
		end

	frozen get_list_view: WINFORMS_LIST_VIEW is
		external
			"IL signature (): System.Windows.Forms.ListView use System.Windows.Forms.ListViewItem"
		alias
			"get_ListView"
		end

	frozen get_fore_color: DRAWING_COLOR is
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

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem"
		alias
			"get_Text"
		end

	frozen get_image_list: WINFORMS_IMAGE_LIST is
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

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.ListViewItem"
		alias
			"get_Bounds"
		end

	frozen get_tag: SYSTEM_OBJECT is
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

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_Text"
		end

	frozen set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"set_BackColor"
		end

	frozen set_tag (value: SYSTEM_OBJECT) is
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

	frozen set_font (value: DRAWING_FONT) is
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

	frozen set_fore_color (value: DRAWING_COLOR) is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListViewItem"
		alias
			"ToString"
		end

	frozen get_bounds_item_bounds_portion (portion: WINFORMS_ITEM_BOUNDS_PORTION): DRAWING_RECTANGLE is
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

	clone_: SYSTEM_OBJECT is
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

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	deserialize (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"Deserialize"
		end

	serialize (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.ListViewItem"
		alias
			"Serialize"
		end

	frozen system_runtime_serialization_iserializable_get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
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

end -- class WINFORMS_LIST_VIEW_ITEM
