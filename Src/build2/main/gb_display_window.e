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
			if components /= Void then
					-- We protect against `components' being Void for the special case where we create `Current'
					-- from DEFAULT_OBJECT_STATE_CHECKER `default_object_by_type'. In this case the feature returns an
					-- on object of type EV_ANY and so it is not possible to directly call `set_components' after
					-- calling `default_create'. We do not need `components' in this case as the only use for
					-- `Current' in that case is to query some of the default properties.
				fake_cancel_button (Current, agent (components.commands.show_hide_display_window_command).execute)
			end
			set_icon_pixmap (icon)
		end

feature -- Access

	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_display_window @ 1
		end

end -- class GB_DISPLAY_WINDOW
