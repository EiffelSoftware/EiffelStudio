indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Clipboard"

frozen external class
	SYSTEM_WINDOWS_FORMS_CLIPBOARD

create {NONE}

feature -- Basic Operations

	frozen set_data_object_object_boolean (data: ANY; copy: BOOLEAN) is
		external
			"IL static signature (System.Object, System.Boolean): System.Void use System.Windows.Forms.Clipboard"
		alias
			"SetDataObject"
		end

	frozen get_data_object: SYSTEM_WINDOWS_FORMS_IDATAOBJECT is
		external
			"IL static signature (): System.Windows.Forms.IDataObject use System.Windows.Forms.Clipboard"
		alias
			"GetDataObject"
		end

	frozen set_data_object (data: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.Windows.Forms.Clipboard"
		alias
			"SetDataObject"
		end

end -- class SYSTEM_WINDOWS_FORMS_CLIPBOARD
