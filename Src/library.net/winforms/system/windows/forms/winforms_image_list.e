indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ImageList"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_IMAGE_LIST

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_image_list_1,
	make_winforms_image_list

feature {NONE} -- Initialization

	frozen make_winforms_image_list_1 (container: SYSTEM_DLL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.ImageList"
		end

	frozen make_winforms_image_list is
		external
			"IL creator use System.Windows.Forms.ImageList"
		end

feature -- Access

	frozen get_images: WINFORMS_IMAGE_COLLECTION_IN_WINFORMS_IMAGE_LIST is
		external
			"IL signature (): System.Windows.Forms.ImageList+ImageCollection use System.Windows.Forms.ImageList"
		alias
			"get_Images"
		end

	frozen get_image_stream: WINFORMS_IMAGE_LIST_STREAMER is
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

	frozen get_transparent_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ImageList"
		alias
			"get_TransparentColor"
		end

	frozen get_image_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ImageList"
		alias
			"get_ImageSize"
		end

	frozen get_color_depth: WINFORMS_COLOR_DEPTH is
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

	frozen set_image_size (value: DRAWING_SIZE) is
		external
			"IL signature (System.Drawing.Size): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_ImageSize"
		end

	frozen set_color_depth (value: WINFORMS_COLOR_DEPTH) is
		external
			"IL signature (System.Windows.Forms.ColorDepth): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_ColorDepth"
		end

	frozen set_image_stream (value: WINFORMS_IMAGE_LIST_STREAMER) is
		external
			"IL signature (System.Windows.Forms.ImageListStreamer): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_ImageStream"
		end

	frozen set_transparent_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ImageList"
		alias
			"set_TransparentColor"
		end

	frozen add_recreate_handle (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ImageList"
		alias
			"add_RecreateHandle"
		end

	frozen remove_recreate_handle (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ImageList"
		alias
			"remove_RecreateHandle"
		end

feature -- Basic Operations

	frozen draw_graphics_int32_int32_int32_int32 (g: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; index: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Windows.Forms.ImageList"
		alias
			"Draw"
		end

	frozen draw (g: DRAWING_GRAPHICS; pt: DRAWING_POINT; index: INTEGER) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Point, System.Int32): System.Void use System.Windows.Forms.ImageList"
		alias
			"Draw"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ImageList"
		alias
			"ToString"
		end

	frozen draw_graphics_int32_int32_int32 (g: DRAWING_GRAPHICS; x: INTEGER; y: INTEGER; index: INTEGER) is
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

end -- class WINFORMS_IMAGE_LIST
