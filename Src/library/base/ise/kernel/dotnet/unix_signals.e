note

	description: "[
		Constants used for signal handling.
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNIX_SIGNALS

feature -- Access

	meaning (sig: INTEGER): detachable STRING
			-- A message in English describing what `sig' is
		do
			if is_defined (sig) then
				create Result.make_from_c (c_signal_name (sig))
			end
		end

	is_defined (sig: INTEGER): BOOLEAN
			-- Is `sig' a signal defined for this platform?
		do
			check
				not_implemented: False
			end
		end

	is_ignored (sig: INTEGER): BOOLEAN
			-- Is `sig' currently set to be ignored?
		do
			Result := not is_caught (sig)
		end

	Sighup: INTEGER
			-- Code for ``Hangup'' signal
		once
			Result := c_signal_map (1)
		end

	Sigint: INTEGER
			-- Code for ``Interrupt'' signal
		once
			Result := c_signal_map (2)
		end

	Sigquit: INTEGER
			-- Code for ``Quit'' signal
		once
			Result := c_signal_map (3)
		end

	Sigill: INTEGER
			-- Code for ``Illegal instruction'' signal
		once
			Result := c_signal_map (4)
		end

	Sigtrap: INTEGER
			-- Code for ``Trace trap'' signal
		once
			Result := c_signal_map (5)
		end

	Sigabrt: INTEGER
			-- Code for ``Abort'' signal
		once
			Result := c_signal_map (6)
		end

	Sigiot: INTEGER
			-- Code for ``IOT instruction'' signal
		once
			Result := c_signal_map (7)
		end

	Sigemt: INTEGER
			-- Code for ``EMT instruction'' signal
		once
			Result := c_signal_map (8)
		end

	Sigfpe: INTEGER
			-- Code for ``Floating point exception'' signal
			--| (Already caught by Eiffel run-time)
		once
			Result := c_signal_map (9)
		end

	Sigkill: INTEGER
			-- Code for ``Terminator'' signal
		once
			Result := c_signal_map (10)
		end

	Sigbus: INTEGER
			-- Code for ``Bus error'' signal
		once
			Result := c_signal_map (11)
		end

	Sigsegv: INTEGER
			-- Code for ``Segmentation violation'' signal
		once
			Result := c_signal_map (12)
		end

	Sigsys: INTEGER
			-- Code for ``Bad argument to system call'' signal
		once
			Result := c_signal_map (13)
		end

	Sigpipe: INTEGER
			-- Code for ``Broken pipe'' signal
		once
			Result := c_signal_map (14)
		end

	Sigalrm: INTEGER
			-- Code for ``Alarm clock'' signal
		once
			Result := c_signal_map (15)
		end

	Sigterm: INTEGER
			-- Code for ``Software termination'' signal
		once
			Result := c_signal_map (16)
		end

	Sigusr1: INTEGER
			-- Code for ``User-defined signal #1''
		once
			Result := c_signal_map (17)
		end

	Sigusr2: INTEGER
			-- Code for ``User-defined signal #2''
		once
			Result := c_signal_map (18)
		end

	Sigchld: INTEGER
			-- Code for ``Death of a child'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (19)
		end

	Sigcld: INTEGER
			-- Code for ``Death of a child'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (20)
		end

	Sigio: INTEGER
			-- Code for ``Pending I/O on a descriptor'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (21)
		end

	Sigpoll: INTEGER
			-- Code for ``Selectable event pending'' signal
		once
			Result := c_signal_map (22)
		end

	Sigttin: INTEGER
			-- Code for ``Tty input from background'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (23)
		end

	Sigttou: INTEGER
			-- Code for ``Tty output from background'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (24)
		end

	Sigstop: INTEGER
			-- Code for ``Stop'' signal
		once
			Result := c_signal_map (25)
		end

	Sigtstp: INTEGER
			-- Code for ``Stop from tty'' signal
		once
			Result := c_signal_map (26)
		end

	Sigxcpu: INTEGER
			-- Code for ``Cpu time limit exceeded'' signal
		once
			Result := c_signal_map (27)
		end

	Sigxfsz: INTEGER
			-- Code for ``File size limit exceeded'' signal
		once
			Result := c_signal_map (28)
		end

	Sigvtalarm: INTEGER
			-- Code for ``Virtual time alarm'' signal
		once
			Result := c_signal_map (29)
		end

	Sigpwr: INTEGER
			-- Code for ``Power-fail'' signal
		once
			Result := c_signal_map (30)
		end

	Sigprof: INTEGER
			-- Code for ``Profiling timer alarm'' signal
		once
			Result := c_signal_map (31)
		end

	Sigwinch: INTEGER
			-- Code for ``Window size changed'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (32)
		end

	Sigwind: INTEGER
			-- Code for ``Window change'' signal
		once
			Result := c_signal_map (33)
		end

	Sigphone: INTEGER
			-- Code for ``Line status change'' signal
		once
			Result := c_signal_map (34)
		end

	Siglost: INTEGER
			-- Code for ``Resource lost'' signal
		once
			Result := c_signal_map (35)
		end

	Sigurg: INTEGER
			-- Code for ``Urgent condition on socket'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (36)
		end

	Sigcont: INTEGER
			-- Code for ``Continue after stop'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (37)
		end


feature -- Status report

	signal: INTEGER
			-- Code of last signal
		do
			check
				not_implemented: False
			end
		end

feature -- Status setting

	catch (sig: INTEGER)
			-- Make sure that future occurrences of `sig'
			-- will be treated as exceptions.
			-- (This is the default for all signals.)
			-- No effect if signal not defined.
		do
			check
				not_implemented: False
			end
		end

	ignore (sig: INTEGER)
			-- Make sure that future occurrences of `sig'
			-- will be ignored. (This is not the default.)
			-- No effect if signal not defined.
		do
			check
				not_implemented: False
			end
		end

	reset_all_default
			-- Make sure that all exceptions will lead to their
			-- default handling.
		do
			check
				not_implemented: False
			end
		end

	reset_default (sig: INTEGER)
			-- Make sure that exception of code code will lead
			-- to its default action.
		require
			is_defined (sig)
		do
			check
				not_implemented: False
			end
		end

feature {NONE} -- Implementation

	is_caught (sig: INTEGER): BOOLEAN
			-- Is `sig' currently set to be caught?
		do
			check
				not_implemented: False
			end
		end

	c_signal_map (i: INTEGER): INTEGER
		do
			check
				not_implemented: False
			end
		end

	c_signal_name (i: INTEGER): POINTER
		do
			check
				not_implemented: False
			end
		end

note
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class UNIX_SIGNALS
