indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ImageList"

frozen external class
	SYSTEM_WINDOWS_FORMS_IMAGELIST

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_imagelist_1,
	make_imagelist

feature {NONE} -- Initialization

	frozen make_imagelist_1 (container: SYSTEM_COMPONENTMODEL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.ImageList"
		end

	frozen make_imagelist is
		external
			"IL creator use System.Windows.Forms.ImageList"
		end

feature -- Access

	frozen get_images: IMAGECOLLECTION_IN_SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList+ImageCollection use System.Windows.Forms.ImageList"
		alias
			"get_Images"
		end

	frozen get_image_stream: SYSTEM_WINDOWS_FORMS_IMAGELISTSTREAMER is
		external
			"IL signature (): System.Windows.Forms.ImageListStreamer use System.Windows.Forms.ImageList"
		alias
			"get_ImageStream"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.ImageList"
		alias
			"get_Handle"
		end

	frozen get_transparent_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ImageList"
		alias
			"get_TransparentColor"
		end

	frozen get_image_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ImageList"
		alias
			"get_ImageSize"
		end

	frozen get_color_depth: SYSTEM_WINDOWS_FORMS_COLORDEPTH is
		external
			"IL signature (): System.Windows.Forms.ColorDepth use System.Windows.Forms.ImageList"
		alias
			"get_ColorDepth"
		end

	frozen get_handle_created: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ImageList"
		alias
			"get_HandleCreated"
		end

feature -- Element Change

	frozen set_image_size (value: SYSTEM_DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_ImageSize"
		end

	frozen set_color_depth (value: SYSTEM_WINDOWS_FORMS_COLORDEPTH) is
		external
			"IL signature (System.Windows.Forms.ColorDepth): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_ColorDepth"
		end

	frozen set_image_stream (value: SYSTEM_WINDOWS_FORMS_IMAGELISTSTREAMER) is
		external
			"IL signature (System.Windows.Forms.ImageListStreamer): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_ImageStream"
		end

	frozen set_transparent_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_TransparentColor"
		end

	frozen add_recreate_handle (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ImageList"
		alias
			"add_RecreateHandle"
		end

	frozen remove_recreate_handle (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ImageList"
		alias
			"remove_RecreateHandle"
		end

feature -- Basic Operations

	frozen draw_graphics_int32_int32_int32_int32 (g: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; index: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ImageList"
		alias
			"Draw"
		end

	frozen draw (g: SYSTEM_DRAWING_GRAPHICS; pt: SYSTEM_DRAWING_POINT; index: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Point, System.Int32): System.Void use System.Windows.Forms.ImageList"
		alias
			"Draw"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ImageList"
		alias
			"ToString"
		end

	frozen draw_graphics_int32_int32_int32 (g: SYSTEM_DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; index: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ImageList"
		alias
			"Draw"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ImageList"
		alias
			"Dispose"
		end

end -- class SYSTEM_WINDOWS_FORMS_IMAGELIST
