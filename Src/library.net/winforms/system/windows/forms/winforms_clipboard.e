indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Clipboard"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_CLIPBOARD

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen set_data_object_object_boolean (data: SYSTEM_OBJECT; copy_: BOOLEAN) is
		external
			"IL static signature (System.Object, System.Boolean): System.Void use System.Windows.Forms.Clipboard"
		alias
			"SetDataObject"
		end

	frozen get_data_object: WINFORMS_IDATA_OBJECT is
		external
			"IL static signature (): System.Windows.Forms.IDataObject use System.Windows.Forms.Clipboard"
		alias
			"GetDataObject"
		end

	frozen set_data_object (data: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.Windows.Forms.Clipboard"
		alias
			"SetDataObject"
		end

end -- class WINFORMS_CLIPBOARD
