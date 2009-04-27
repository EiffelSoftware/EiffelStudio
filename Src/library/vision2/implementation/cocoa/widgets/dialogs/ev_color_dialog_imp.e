indexing
	description: "EiffelVision color selection dialog. Cocoa implementation."

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

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			base_make (an_interface)
			create {NS_COLOR_PANEL}cocoa_item.shared_color_panel
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
		do
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

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_COLOR_DIALOG_IMP

