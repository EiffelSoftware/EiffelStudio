indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TreeViewImageIndexConverter"

external class
	SYSTEM_WINDOWS_FORMS_TREEVIEWIMAGEINDEXCONVERTER

inherit
	SYSTEM_WINDOWS_FORMS_IMAGEINDEXCONVERTER
		redefine
			get_include_none_as_standard_value
		end

create
	make_treeviewimageindexconverter

feature {NONE} -- Initialization

	frozen make_treeviewimageindexconverter is
		external
			"IL creator use System.Windows.Forms.TreeViewImageIndexConverter"
		end

feature {NONE} -- Implementation

	get_include_none_as_standard_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeViewImageIndexConverter"
		alias
			"get_IncludeNoneAsStandardValue"
		end

end -- class SYSTEM_WINDOWS_FORMS_TREEVIEWIMAGEINDEXCONVERTER
