indexing
	description: "Objects that contain the widget structure built by the user%
		%with containers visible."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_BUILDER_WINDOW


inherit
	
	EV_DIALOG
		redefine
			initialize
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
		
	GB_COMMAND_HANDLER
		export
			{NONE} all
		undefine
			default_create, copy
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

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		local
			button: EV_BUTTON
		do
			Precursor {EV_DIALOG}
			set_title (gb_builder_window_title)			
				-- Set up cancel actions on `Current'.
			fake_cancel_button (Current, agent show_hide_builder_window_command.execute)
			set_icon_pixmap (icon)
		end

feature -- Access

	object: GB_OBJECT
		-- EV_TITLED_WINDOW object associated with `Current'.
		
	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_builder_window @ 1
		end

feature -- Status setting

	set_object (an_object: GB_OBJECT) is
			--
		require
			an_object_not_void: an_object /= Void
		do
			object := an_object
				-- We can only set up the drop actions once `object' has
				-- been set. This is because we must do the processing within the
				-- object.
			drop_actions.wipe_out
			drop_actions.extend (agent object.add_new_object_wrapper (?))
			drop_actions.set_veto_pebble_function (agent object.can_add_child (?))		
		end
		
end -- class GB_BUILDER_WINDOW
