indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DragDropEffects"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen scroll: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"-2147483648"
		end

	frozen link: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"4"
		end

	frozen move: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"2"
		end

	frozen copy: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"1"
		end

	frozen All_: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"-2147483645"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL enum signature :System.Windows.Forms.DragDropEffects use System.Windows.Forms.DragDropEffects"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS
