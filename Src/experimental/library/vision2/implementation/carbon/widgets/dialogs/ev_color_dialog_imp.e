note
	description: "EiffelVision color selection dialog. Carbon implementation."

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize,
			show
		end

	COLORPICKER_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			base_make (an_interface)

		end

	initialize
			-- Connect action sequences to button signals.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}

			enable_closeable
			forbid_resize
			set_is_initialized (True)
		end

	show
			--
		local
			ret: INTEGER
			color_picker_info: COLOR_PICKER_INFO_STRUCT
			npm_color: NPMCOLOR_STRUCT
			cm_color: CMCOLOR_UNION
			cmrgb_color: CMRGBCOLOR_STRUCT
			ev_color: EV_COLOR
		do
			create color_picker_info.make_new_unshared
			ret := npick_color_external (color_picker_info.item)
			if color_picker_info.newcolorchosen.to_boolean then
				create npm_color.make_unshared (color_picker_info.thecolor)
				create cm_color.make_unshared (npm_color.color)
				-- TODO: We may need to do a color space conversion here to a RGB profile. See http://www.mactech.com/articles/develop/issue_19/068-084_Holland_final.html
				create cmrgb_color.make_unshared (cm_color.rgb)
				create ev_color.make_with_8_bit_rgb (cmrgb_color.red, cmrgb_color.green, cmrgb_color.blue)
				set_color (ev_color)
				on_ok
			else
				on_cancel
			end
		end

feature -- Access

	color: EV_COLOR
			-- Currently selected color.
		do
			Result := internal_set_color
		end

feature -- Element change

	set_color (a_color: EV_COLOR)
			-- Set `color' to `a_color'.
		do
			internal_set_color := a_color
		end

feature {NONE} -- Implementation

	internal_set_color: EV_COLOR
		-- Color explicitly set with `set_color'.

feature {EV_ANY_I} -- Implementation

	interface: EV_COLOR_DIALOG;

note
	copyright:	"Copyright (c) 2006-2007: The Eiffel.Mac Team"

end -- class EV_COLOR_DIALOG_IMP

