indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Printing.PreviewPageInfo"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PREVIEW_PAGE_INFO

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (image: DRAWING_IMAGE; physical_size: DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Size) use System.Drawing.Printing.PreviewPageInfo"
		end

feature -- Access

	frozen get_physical_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Printing.PreviewPageInfo"
		alias
			"get_PhysicalSize"
		end

	frozen get_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Drawing.Printing.PreviewPageInfo"
		alias
			"get_Image"
		end

end -- class DRAWING_PREVIEW_PAGE_INFO
