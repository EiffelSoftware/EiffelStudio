indexing
	description: "Objects that contain the widget structure built by the user%
		%with containers visible."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_BUILDER_WINDOW


inherit
	
	EV_TITLED_WINDOW
		redefine
			initialize
		end
		
	GB_CONSTANTS
		
	GB_COMMAND_HANDLER
		undefine
			default_create, copy
		end

feature -- Initialization

	initialize is
			-- Initalize `Current'.
		do
			Precursor {EV_TITLED_WINDOW}
			set_title (gb_builder_window_title)
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_builder_window @ 1)
			close_request_actions.extend (agent (show_hide_builder_window_command).execute)
		end
		
feature -- Access

	object: GB_OBJECT
		-- EV_TITLED_WINDOW object associated with `Current'.

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
