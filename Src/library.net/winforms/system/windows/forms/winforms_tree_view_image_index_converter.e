indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TreeViewImageIndexConverter"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TREE_VIEW_IMAGE_INDEX_CONVERTER

inherit
	WINFORMS_IMAGE_INDEX_CONVERTER
		redefine
			get_include_none_as_standard_value
		end

create
	make_winforms_tree_view_image_index_converter

feature {NONE} -- Initialization

	frozen make_winforms_tree_view_image_index_converter is
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

end -- class WINFORMS_TREE_VIEW_IMAGE_INDEX_CONVERTER
