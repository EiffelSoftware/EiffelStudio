indexing
	description: "Objects that ..."
		" EiffelVision timeout, implementation."
	status: "See notice at end of class"
	date: "$$"
	revision: "$$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I

	EV_GTK_GENERAL_EXTERNALS

create
	make

feature -- Initialization

	make (delay: INTEGER; cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Create a timeout that call that launch `cmd' with `arg' every `delay'
			-- milliseconds.
		local
			ev_str: ANY
			temp_str: STRING
			ev_cmd: EV_ROUTINE_COMMAND
		do
			temp_str := "timeout"
			ev_str := temp_str.to_c

			-- Set all internal attributes of timeout
			period := delay
			command := cmd

			create ev_cmd.make(~ev_timeout_callback)
			
				-- The main C function for connecting callbacks to signals
				-- is being used to prevent duplicated C-code regarding
				-- memory allocation of the `callback data' C `structure'

			timeout_tag := c_gtk_signal_connect
				(
					default_pointer,
					$ev_str,
					ev_cmd.execute_address,
					$ev_cmd,
					$arg,
					Default_pointer,
					Default_pointer,
					Default_pointer,
					0,
					False,
					c_gtk_integer_to_pointer (delay)
				)
		end

feature -- Implementation

	timeout_tag: INTEGER

	ev_timeout_callback (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Callback used as an intermediate to update callback count
			-- and to call user-defined callback.
		do
			count := count + 1
			command.execute (arg, data)
		end

feature -- Access

	period: INTEGER 
			-- Period of the timeout in milli-seconds.

	command: EV_COMMAND 
			-- Command associated with the timeout.

	argument: EV_ARGUMENT 
			-- Argument associated with the timeout.

	count: INTEGER
			-- Number of times the command was already called.

feature -- Status report

	destroyed: BOOLEAN
			-- Is Current object destroyed?

feature -- Status setting

	destroy is
			-- Destroy timeout object.
		do
			destroyed := True

			--Destroy timeout in GTK
			gtk_timeout_remove (timeout_tag)

			--Reset all attributes
			command := Void
			period := 0
			argument := Void
			count := 0
		end

feature -- External

	gtk_timeout_remove (tag: INTEGER) is
		external
			"C (gint) | <gtk/gtk.h>"
		end

end -- class EV_TIMEOUT_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------
