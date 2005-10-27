indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTERNAL_COMPONENTS
	
inherit
	ANY
		redefine
			default_create
		end
		
	GB_CONSTANTS
		redefine
			default_create
		end
		
	GB_INTERFACE_CONSTANTS
		redefine
			default_create
		end
		
	GB_EIFFEL_ENV
		redefine
			default_create
		end

feature -- Access

	default_create is
			--
		do	
			create digit_checker
			digit_checker.initialize_digit_checker (Current)
			create events
			events.initialize_events (Current)
			create status_bar
			status_bar.initialize_status_bar (Current)
			create constants
			constants.initialize_constants (Current)
			create system_status
			system_status.initialize_system_status (Current)
			create history
			history.initialize_history (Current)
			create clipboard
			clipboard.initialize_clipboard (Current)
			create commands
			commands.initialize_commands (Current)
			create tools
			tools.initialize_tools (Current)
			create object_editors
			object_editors.initialize_editors (Current)
			create xml_handler
			xml_handler.initialize_xml_handler (Current)
			
			create object_handler
			object_handler.initialize_object_handler (Current)
			create id_handler
			id_handler.initialize_id_handler (Current)
			
			
				-- Now initialize the application wide action sequences
			application.pnd_motion_actions.extend (agent pick_and_drop_motion)
			application.pick_actions.extend (agent pick_and_drop_started)
			application.cancel_actions.extend (agent pick_and_drop_cancelled)
			application.drop_actions.extend (agent pick_and_drop_completed)
		end
		
	commands: GB_COMMAND_HANDLER
	
	tools: GB_TOOLS
	
	history: GB_GLOBAL_HISTORY
	
	object_editors: GB_OBJECT_EDITORS
	
	xml_handler: GB_XML_HANDLER
	
	system_status: GB_SYSTEM_STATUS
	
	clipboard: GB_CLIPBOARD
	
	object_handler: GB_OBJECT_HANDLER
	
	constants: GB_CONSTANTS_HANDLER
	
	id_handler: GB_ID
	
	events: GB_EVENTS
	
	status_bar: GB_STATUS_BAR
	
	digit_checker: GB_DIGIT_CHECKER
		
feature {NONE} -- Implementation

	pick_and_drop_motion (an_x, a_y: INTEGER; target: EV_ABSTRACT_PICK_AND_DROPABLE) is
			-- Respond to a global pick and drop motion.
		do
			status_bar.clear_status_during_transport (an_x, a_y, target)
		end

	pick_and_drop_started (pebble: ANY) is
			-- Respond to a pick and drop starting.
		require
			pebble_not_void: pebble /= Void
		do
			system_status.set_pick_and_drop_pebble (pebble)
			commands.update
		end

	pick_and_drop_cancelled (pebble: ANY) is
			-- Respond to the cancelling of a pick and drop.
		require
			pebble_not_void: pebble /= Void
		do
			digit_checker.end_processing
			system_status.remove_pick_and_drop_pebble
			status_bar.clear_status_after_transport (pebble)
			commands.update
		end
		
	pick_and_drop_completed (pebble: ANY) is
			-- Respond to the successful completion of a pick and drop.
		require
			pebble_not_void: pebble /= Void
		do
			digit_checker.end_processing
			system_status.remove_pick_and_drop_pebble
			commands.update
		end

invariant
	invariant_clause: True -- Your invariant here

end
