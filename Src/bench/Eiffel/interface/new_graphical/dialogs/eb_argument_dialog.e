indexing
	description:	
		"Popup dialog to enter new arguments, modify existing ones and launch system with%
		%chosen argument."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit

	EV_TITLED_WINDOW

	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end		

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end	
		
	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end	

	EB_DEBUGGER_OBSERVER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		redefine
			on_application_killed,
			on_application_launched,
			on_application_stopped
		end

creation
	make,
	default_create
	
feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW; cmd: PROCEDURE [ANY, TUPLE]) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
		require
			a_window_not_void: a_window /= Void
			cmd_not_void: cmd /= Void
		do		
			make_with_title ("Execution Control")
			Debugger_manager.observers.extend (Current)
			run := cmd
			
				-- Build Dialog GUI
			create arguments_control.make (a_window.window)
			extend (execution_frame)
			key_press_actions.extend (agent escape_check (?))
			focus_in_actions.extend (agent on_window_focused)
		end

	execution_frame: EV_HORIZONTAL_BOX is
			-- Frame containing all execution option
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			b: EV_BUTTON
			cell: EV_CELL
		do
			create Result
			create hbox
			hbox.extend (arguments_control)
			hbox.set_border_width (Layout_constants.Small_border_size)
			hbox.set_padding (Layout_constants.Small_padding_size)
			
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			
			create b.make_with_text ("OK")
			vbox.extend (b)
			b.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
			vbox.disable_item_expand (b)
			b.select_actions.extend (agent okay)
			
			create b.make_with_text ("Cancel")
			vbox.extend (b)
			b.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
			vbox.disable_item_expand (b)
			b.select_actions.extend (agent cancel)

			if run /= Void then
				create run_button.make_with_text ("Run")
				vbox.extend (run_button)
				run_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
				vbox.disable_item_expand (run_button)
				run_button.select_actions.extend (agent execute (apply_and_run_it))
				
				create run_and_close_button.make_with_text ("Run & Close")
				vbox.extend (run_and_close_button)
				run_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
				vbox.disable_item_expand (run_and_close_button)
				run_and_close_button.select_actions.extend (agent execute_and_close (apply_and_run_it))
				run_and_close_button.key_press_actions.extend (agent on_run_button_key_press)
			end

			create cell
			cell.set_minimum_width (Layout_constants.Small_padding_size)
			vbox.extend (cell)

			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			Result.extend (hbox)
		end

feature -- GUI

	run_button,
	run_and_close_button: EV_BUTTON
			-- Button to run system.

feature -- Status Setting
	
	update is
			-- Update.
		do
			arguments_control.update
		end

feature {NONE} -- Actions

	cancel is
			-- Action to take when user presses 'Cancel' button.
		do
			hide
		end

	okay is
	 		-- Action to take when user presses 'OK' button.
		do
			arguments_control.store_arguments (Void)
			hide
		end	

feature {NONE} -- Properties

	arguments_control: EB_ARGUMENT_CONTROL
			-- Widget holding all arguments information.

	apply_and_run_it: ANY is
			-- Arguments for the command
		once
			create Result
		end

	run: PROCEDURE [ANY, TUPLE]

feature {NONE} -- Implementation

	on_window_focused is
			-- Acion to be taken when window gains focused.
		do
			arguments_control.current_argument.set_focus
		end
		
	on_run_button_key_press (key: EV_KEY) is
			-- Key was pressed whilst button had focus.
		do
			if key.code = feature {EV_KEY_CONSTANTS}.key_enter then
				execute (apply_and_run_it)
			end
		end

	escape_check (key: EV_KEY) is
			-- Check for keyboard escape character.
		require
			key_not_void: key /= Void
     	do
        	if key.code = feature {EV_KEY_CONSTANTS}.key_escape then
            	cancel
            end
      	end

	execute (arg: ANY) is
		do
			if arg /= Void then
				if arg = Apply_and_run_it then
					arguments_control.store_arguments (Void)
					run.call ([])
				end
			end
		end
		
	execute_and_close (arg: ANY) is
		do
			if arg /= Void then
				if arg = Apply_and_run_it then
					arguments_control.store_arguments (Void)
					run.call ([])
					hide
				end
			end
		end

feature {NONE} -- Observing event handling.

	on_application_killed is
			-- Action to take when the application is killed.
		do
			if not run_button.is_sensitive then
				run_button.enable_sensitive				
			end
			if not run_and_close_button.is_sensitive then
				run_and_close_button.enable_sensitive				
			end
		end
	
	on_application_launched is
			-- Action to take when the application is launched.
		do
			if run_button.is_sensitive then
				run_button.disable_sensitive				
			end
			if run_and_close_button.is_sensitive then
				run_and_close_button.disable_sensitive				
			end
		end
		
	on_application_stopped is
			-- Action to take when the application is stopped.
		do
			if not run_button.is_sensitive then
				run_button.enable_sensitive				
			end
			if not run_and_close_button.is_sensitive then
				run_and_close_button.enable_sensitive				
			end
		end
		
invariant
	argument_control_not_void: arguments_control /= Void

end -- class EB_ARGUMENT_DIALOG
