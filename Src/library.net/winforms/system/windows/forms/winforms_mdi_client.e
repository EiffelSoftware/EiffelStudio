indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MdiClient"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	WINFORMS_MDI_CLIENT

inherit
	WINFORMS_CONTROL
		redefine
			wnd_proc,
			set_bounds_core,
			scale_core,
			on_resize,
			create_controls_instance,
			get_create_params,
			set_background_image,
			get_background_image
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

create
	make_winforms_mdi_client

feature {NONE} -- Initialization

	frozen make_winforms_mdi_client is
		external
			"IL creator use System.Windows.Forms.MdiClient"
		end

feature -- Access

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.MdiClient"
		alias
			"get_BackgroundImage"
		end

	frozen get_mdi_children: NATIVE_ARRAY [WINFORMS_FORM] is
		external
			"IL signature (): System.Windows.Forms.Form[] use System.Windows.Forms.MdiClient"
		alias
			"get_MdiChildren"
		end

feature -- Element Change

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.MdiClient"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen layout_mdi (value: WINFORMS_MDI_LAYOUT) is
		external
			"IL signature (System.Windows.Forms.MdiLayout): System.Void use System.Windows.Forms.MdiClient"
		alias
			"LayoutMdi"
		end

feature {NONE} -- Implementation

	scale_core (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Windows.Forms.MdiClient"
		alias
			"ScaleCore"
		end

	create_controls_instance: WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.MdiClient"
		alias
			"CreateControlsInstance"
		end

	on_resize (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MdiClient"
		alias
			"OnResize"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.MdiClient"
		alias
			"get_CreateParams"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: WINFORMS_BOUNDS_SPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.MdiClient"
		alias
			"SetBoundsCore"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.MdiClient"
		alias
			"WndProc"
		end

end -- class WINFORMS_MDI_CLIENT
