indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ScrollableControl+DockPaddingEdges"

external class
	DOCKPADDINGEDGES_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL

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
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone,
			is_equal as equals_object
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

	equals_object (other: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"ToString"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"Finalize"
		end

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Windows.Forms.ScrollableControl+DockPaddingEdges"
		alias
			"System.ICloneable.Clone"
		end

end -- class DOCKPADDINGEDGES_IN_SYSTEM_WINDOWS_FORMS_SCROLLABLECONTROL
