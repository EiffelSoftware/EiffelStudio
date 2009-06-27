indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EDK_DISPLAY

inherit
	EDK_OBJECT_I
		redefine
			default_create
		end

feature {NONE} -- Creation

	default_create
			-- Create display object for default display.
		do
			create event_manager_internal.make_for_display (Current)
		end

feature -- Message Handling

	event_manager: EDK_DESKTOP_EVENT_MANAGER
			-- Manager for handling all EDK events.
		do
			check event_manager_internal /= Void end
			Result := event_manager_internal
		end

feature {NONE} -- Implementation

	event_manager_internal: detachable EDK_DESKTOP_EVENT_MANAGER note option: stable attribute end

end
