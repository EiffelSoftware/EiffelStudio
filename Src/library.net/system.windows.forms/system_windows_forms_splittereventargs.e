indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.SplitterEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_SPLITTEREVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_splittereventargs

feature {NONE} -- Initialization

	frozen make_splittereventargs (x: INTEGER; y: INTEGER; split_x: INTEGER; split_y: INTEGER) is
		external
			"IL creator signature (System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.SplitterEventArgs"
		end

feature -- Access

	frozen get_split_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_SplitX"
		end

	frozen get_split_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_SplitY"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_Y"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.SplitterEventArgs"
		alias
			"get_X"
		end

feature -- Element Change

	frozen set_split_x (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.SplitterEventArgs"
		alias
			"set_SplitX"
		end

	frozen set_split_y (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.SplitterEventArgs"
		alias
			"set_SplitY"
		end

end -- class SYSTEM_WINDOWS_FORMS_SPLITTEREVENTARGS
