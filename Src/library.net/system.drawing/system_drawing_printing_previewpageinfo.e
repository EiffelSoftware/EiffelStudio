indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Printing.PreviewPageInfo"

frozen external class
	SYSTEM_DRAWING_PRINTING_PREVIEWPAGEINFO

create
	make

feature {NONE} -- Initialization

	frozen make (image: SYSTEM_DRAWING_IMAGE; physical_size: SYSTEM_DRAWING_SIZE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Size) use System.Drawing.Printing.PreviewPageInfo"
		end

feature -- Access

	frozen get_physical_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Drawing.Printing.PreviewPageInfo"
		alias
			"get_PhysicalSize"
		end

	frozen get_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Drawing.Printing.PreviewPageInfo"
		alias
			"get_Image"
		end

end -- class SYSTEM_DRAWING_PRINTING_PREVIEWPAGEINFO
