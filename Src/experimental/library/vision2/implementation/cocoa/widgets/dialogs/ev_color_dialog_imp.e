note
	description: "EiffelVision color selection dialog. Cocoa implementation."
	author: "Daniel Furrer"

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			make,
			interface,
			dispose
		end

	NS_COLOR_PANEL
		rename
			make as make_cocoa,
			item as color_panel,
			title as cocoa_title,
			set_title as cocoa_set_title,
			set_background_color as set_background_color_cocoa,
			background_color as background_color_cocoa
		undefine
			copy
		redefine
			dispose
		select
			color_panel,
			make_cocoa,
			set_background_color_cocoa,
			background_color_cocoa
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Connect action sequences to button signals.
		do
			shared_color_panel
			Precursor {EV_STANDARD_DIALOG_IMP}

			enable_closeable

			forbid_resize
			set_is_initialized (True)
			create internal_set_color
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	dispose
		do

		end

	interface: detachable EV_COLOR_DIALOG note option: stable attribute end;

end -- class EV_COLOR_DIALOG_IMP
