indexing
	description: "Project root class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_BUILDER

inherit
	EV_APPLICATION

create
	make_and_launch 

feature {NONE} -- Initialization
		
	make_and_launch is
			-- Initialize and launch application
		local
			thread_start: THREAD_START
			thread: SYSTEM_THREAD
			l_args: ARGUMENTS_PARSER
		do	
			create l_args.make
			if l_args.is_gui then
				create thread_start.make (Current, $make_gui)
				create thread.make (thread_start)
				thread.set_apartment_state (feature {APARTMENT_STATE}.sta)
				thread.start
				thread.join
			elseif l_args.args_ok then				
				l_args.launch_command_line
			else
				io.putstring (l_args.argument_error)
				io.putstring ("%NPress any key to finish execution...")
				io.read_character
			end		
		end
			
	make_gui is	
		do
			default_create
				-- create and initialize the first window.
			prepare
			launch
		end

	prepare is
			-- Prepare the interface window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			create interface
			interface.Shared_constants.Application_constants.set_gui_mode (True)
			interface.show
		end
		
	interface: DOC_BUILDER_WINDOW
			-- Application window

end -- class DOC_BUILDER
