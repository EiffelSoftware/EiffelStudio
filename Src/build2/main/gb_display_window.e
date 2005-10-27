indexing
	description: "Objects that display the widget structure built by the user."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DISPLAY_WINDOW

inherit

	EV_DIALOG
		redefine
			initialize
		end

	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

	GB_WIDGET_UTILITIES
		export
			{NONE} all
		undefine
			default_create, copy
		end

	GB_ICONABLE_TOOL
		undefine
			default_create, copy
		end

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		do
			Precursor {EV_DIALOG}
			set_title (gb_display_window_title)
				-- Set up cancel actions on `Current'.
			fake_cancel_button (Current, agent (components.commands.show_hide_display_window_command).execute)
			set_icon_pixmap (icon)
		end

feature -- Access

	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_display_window @ 1
		end

end -- class GB_DISPLAY_WINDOW
