indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ScrollableControl+DockPaddingEdges"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DOCK_PADDING_EDGES_IN_WINFORMS_SCROLLABLE_CONTROL

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

create {NONE}

feature -- Access

	frozen get_right: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"get_Right"
		end

	frozen get_top: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"get_Top"
		end

	frozen get_bottom: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"get_Bottom"
		end

	frozen get_left: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"get_Left"
		end

	frozen get_all: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"get_All"
		end

feature -- Element Change

	frozen set_right (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"set_Right"
		end

	frozen set_bottom (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"set_Bottom"
		end

	frozen set_left (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"set_Left"
		end

	frozen set_all (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"set_All"
		end

	frozen set_top (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"set_Top"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"ToString"
		end

	equals (other: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"Finalize"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"System.ICloneable.Clone"
		end

end -- class WINFORMS_DOCK_PADDING_EDGES_IN_WINFORMS_SCROLLABLE_CONTROL
