indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MdiClient"

frozen external class
	SYSTEM_WINDOWS_FORMS_MDICLIENT

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
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
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_mdiclient

feature {NONE} -- Initialization

	frozen make_mdiclient is
		external
			"IL creator use System.Windows.Forms.MdiClient"
		end

feature -- Access

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.MdiClient"
		alias
			"get_BackgroundImage"
		end

	frozen get_mdi_children: ARRAY [SYSTEM_WINDOWS_FORMS_FORM] is
		external
			"IL signature (): System.Windows.Forms.Form[] use System.Windows.Forms.MdiClient"
		alias
			"get_MdiChildren"
		end

feature -- Element Change

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.MdiClient"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen layout_mdi (value: SYSTEM_WINDOWS_FORMS_MDILAYOUT) is
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

	create_controls_instance: CONTROLCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.MdiClient"
		alias
			"CreateControlsInstance"
		end

	on_resize (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MdiClient"
		alias
			"OnResize"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.MdiClient"
		alias
			"get_CreateParams"
		end

	set_bounds_core (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; specified: SYSTEM_WINDOWS_FORMS_BOUNDSSPECIFIED) is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32, System.Windows.Forms.BoundsSpecified): System.Void use System.Windows.Forms.MdiClient"
		alias
			"SetBoundsCore"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.MdiClient"
		alias
			"WndProc"
		end

end -- class SYSTEM_WINDOWS_FORMS_MDICLIENT
