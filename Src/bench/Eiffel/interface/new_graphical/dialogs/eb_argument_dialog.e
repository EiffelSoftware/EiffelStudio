indexing
	description:	
		"Popup dialog to enter new arguments, modify existing ones and launch system with%
		%chosen argument."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ARGUMENT_DIALOG

inherit

	EV_DIALOG

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

	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end	

creation
	make
	
feature {NONE} -- Initialization

	make (a_window: EB_DEVELOPMENT_WINDOW; cmd: PROCEDURE [ANY, TUPLE]) is
			-- Initialize Current with `par' as parent and
			-- `cmd' as command window.
		require
			a_window_not_void: a_window /= Void
			cmd_not_void: cmd /= Void
		do		
			default_create
			run := cmd
			
				-- Build Dialog GUI
			create arguments_control.make (a_window.window)
			extend (execution_frame)
			key_press_actions.extend (agent escape_check (?))
			set_title ("Execution Control")
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
				create b.make_with_text ("Run")
				vbox.extend (b)
				b.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)
				vbox.disable_item_expand (b)
				b.select_actions.extend (agent execute (apply_and_run_it))
			end

			create cell
			cell.set_minimum_width (Layout_constants.Small_padding_size)
			vbox.extend (cell)

			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)

			Result.extend (hbox)
		end

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

invariant
	argument_control_not_void: arguments_control /= Void

end -- class EB_ARGUMENT_DIALOG
