indexing

	description:
		"Constants used for signal handling. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	UNIX_SIGNALS

feature -- Access

	meaning (sig: INTEGER): STRING is
			-- A message in English describing what `sig' is
		do
			if is_defined (sig) then
				!! Result.make (0);
				Result.from_c (c_signal_name (sig));
			end
		end


	is_defined (sig: INTEGER): BOOLEAN is
			-- Is `sig' a signal defined for this platform?
		external
			"C | %"eif_sig.h%""
		alias
			"esigdefined"
		end;

	is_ignored (sig: INTEGER): BOOLEAN is
			-- Is `sig' currently set to be ignored?
		do
			Result := not is_caught (sig)
		end;

	Sighup: INTEGER is
			-- Code for ``Hangup'' signal
		once
			Result := c_signal_map (1)
		end;

	Sigint: INTEGER is
			-- Code for ``Interrupt'' signal
		once
			Result := c_signal_map (2)
		end;

	Sigquit: INTEGER is
			-- Code for ``Quit'' signal
		once
			Result := c_signal_map (3)
		end;

	Sigill: INTEGER is
			-- Code for ``Illegal instruction'' signal
		once
			Result := c_signal_map (4)
		end;

	Sigtrap: INTEGER is
			-- Code for ``Trace trap'' signal
		once
			Result := c_signal_map (5)
		end;

	Sigabrt: INTEGER is
			-- Code for ``Abort'' signal
		once
			Result := c_signal_map (6)
		end;

	Sigiot: INTEGER is
			-- Code for ``IOT instruction'' signal
		once
			Result := c_signal_map (7)
		end;

	Sigemt: INTEGER is
			-- Code for ``EMT instruction'' signal
		once
			Result := c_signal_map (8)
		end;

	Sigfpe: INTEGER is
			-- Code for ``Floating point exception'' signal
			--| (Already caught by Eiffel run-time)
		once
			Result := c_signal_map (9)
		end;

	Sigkill: INTEGER is
			-- Code for ``Terminator'' signal
		once
			Result := c_signal_map (10)
		end;

	Sigbus: INTEGER is
			-- Code for ``Bus error'' signal
		once
			Result := c_signal_map (11)
		end;

	Sigsegv: INTEGER is
			-- Code for ``Segmentation violation'' signal
		once
			Result := c_signal_map (12)
		end;

	Sigsys: INTEGER is
			-- Code for ``Bad argument to system call'' signal
		once
			Result := c_signal_map (13)
		end;

	Sigpipe: INTEGER is
			-- Code for ``Broken pipe'' signal
		once
			Result := c_signal_map (14)
		end;

	Sigalrm: INTEGER is
			-- Code for ``Alarm clock'' signal
		once
			Result := c_signal_map (15)
		end;

	Sigterm: INTEGER is
			-- Code for ``Software termination'' signal
		once
			Result := c_signal_map (16)
		end;

	Sigusr1: INTEGER is
			-- Code for ``User-defined signal #1''
		once
			Result := c_signal_map (17)
		end;

	Sigusr2: INTEGER is
			-- Code for ``User-defined signal #2''
		once
			Result := c_signal_map (18)
		end;

	Sigchld: INTEGER is
			-- Code for ``Death of a child'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (19)
		end;

	Sigcld: INTEGER is
			-- Code for ``Death of a child'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (20)
		end;

	Sigio: INTEGER is
			-- Code for ``Pending I/O on a descriptor'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (21)
		end;

	Sigpoll: INTEGER is
			-- Code for ``Selectable event pending'' signal
		once
			Result := c_signal_map (22)
		end;

	Sigttin: INTEGER is
			-- Code for ``Tty input from background'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (23)
		end;

	Sigttou: INTEGER is
			-- Code for ``Tty output from background'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (24)
		end;

	Sigstop: INTEGER is
			-- Code for ``Stop'' signal
		once
			Result := c_signal_map (25)
		end;

	Sigtstp: INTEGER is
			-- Code for ``Stop from tty'' signal
		once
			Result := c_signal_map (26)
		end;

	Sigxcpu: INTEGER is
			-- Code for ``Cpu time limit exceeded'' signal
		once
			Result := c_signal_map (27)
		end;

	Sigxfsz: INTEGER is
			-- Code for ``File size limit exceeded'' signal
		once
			Result := c_signal_map (28)
		end;

	Sigvtalarm: INTEGER is
			-- Code for ``Virtual time alarm'' signal
		once
			Result := c_signal_map (29)
		end;

	Sigpwr: INTEGER is
			-- Code for ``Power-fail'' signal
		once
			Result := c_signal_map (30)
		end;

	Sigprof: INTEGER is
			-- Code for ``Profiling timer alarm'' signal
		once
			Result := c_signal_map (31)
		end;

	Sigwinch: INTEGER is
			-- Code for ``Window size changed'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (32)
		end;

	Sigwind: INTEGER is
			-- Code for ``Window change'' signal
		once
			Result := c_signal_map (33)
		end;

	Sigphone: INTEGER is
			-- Code for ``Line status change'' signal
		once
			Result := c_signal_map (34)
		end;

	Siglost: INTEGER is
			-- Code for ``Resource lost'' signal
		once
			Result := c_signal_map (35)
		end;

	Sigurg: INTEGER is
			-- Code for ``Urgent condition on socket'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (36)
		end;

	Sigcont: INTEGER is
			-- Code for ``Continue after stop'' signal.
			-- Signal ignored by default
		once
			Result := c_signal_map (37)
		end;


feature -- Status report

	signal: INTEGER is
			-- Code of last signal
		external
			"C | %"eif_sig.h%""
		alias
			"esignum"
		end;


feature -- Status setting

	catch (sig: INTEGER) is
			-- Make sure that future occurrences of `sig'
			-- will be treated as exceptions.
			-- (This is the default for all signals.)
			-- No effect if signal not defined.
		external
			"C | %"eif_sig.h%""
		alias
			"esigcatch"
		end;

	ignore (sig: INTEGER) is
			-- Make sure that future occurrences of `sig'
			-- will be ignored. (This is not the default.)
			-- No effect if signal not defined.
		external
			"C | %"eif_sig.h%""
		alias
			"esigignore"
		end;

	reset_all_default is
			-- Make sure that all exceptions will lead to their
			-- default handling.
		external
			"C | %"eif_sig.h%""
		alias
			"esigresall"
		end

	reset_default (sig: INTEGER) is
			-- Make sure that exception of code code will lead
			-- to its default action.
		require
			is_defined (sig)
		external
			"C | %"eif_sig.h%""
		alias
			"esigresdef"
		end

feature {NONE} -- Implementation

	is_caught (sig: INTEGER): BOOLEAN is
			-- Is `sig' currently set to be caught?
		external
			"C | %"eif_sig.h%""
		alias
			"esigiscaught"
		end;

	c_signal_map (i: INTEGER): INTEGER is
		external
			"C | %"eif_sig.h%""
		alias
			"esigmap"
		end;

	c_signal_name (i: INTEGER): POINTER is
		external
			"C | %"eif_sig.h%""
		alias
			"esigname"
		end;

end -- class UNIX_SIGNALS

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

