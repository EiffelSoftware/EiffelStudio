indexing

	description: "Command that closes a `closeable' window.";
	date: "$Date$";
	revision: "$Revision $"

class CLOSE_WINDOW_COM 

inherit
	--EC_LICENCED_COMMAND
	--	redefine
	--		license_checked
	--	end

	EV_COMMAND

	CONSTANTS

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
				-- Callback for associated button. If no argument is 
				-- provided, `default_execute_arg' is used.
		do
			--if (closeable /= Void) then
			--	closeable.close
			--else
			--	default_execute_arg.close
			--end
		end

feature {EC_BUTTON} -- Properties 

	symbol: EV_PIXMAP is
			-- Symbol representing button associated to Current command
		once
			Result := Pixmaps.quit_pixmap
		end

feature {TRANSPORTER, EC_TOP_SHELL} -- Properties

	default_execute_arg: CLOSEABLE 
			-- Default argument used by `execute' if none was supplied

feature {TRANSPORTER, EC_TOP_SHELL} -- Settings

	set_default_execute_arg (arg: like default_execute_arg) is
			-- Set the `default_execute_arg'
		require
			arg_exists: arg /= Void
		do
			default_execute_arg := arg
		ensure
			default_execute_arg_set: default_execute_arg = arg
		end

feature {NONE} -- Implementation

	license_checked: BOOLEAN is True
            -- Is license checked?
			--| True, so as to always allow the user to close windows
			--| even if his/her licence has expired.

end -- class CLOSE_WINDOW_COM
