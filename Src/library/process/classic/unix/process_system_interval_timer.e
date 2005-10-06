
indexing
	
	author: "David Hollenberg";
	date: "August 21, 1998";
	description: "An operating system interval timer that counts down in %
		%real time"

deferred class PROCESS_SYSTEM_INTERVAL_TIMER

feature -- Modification

	set_seconds (d: DOUBLE) is
			-- Set timer to expire in `d' seconds.  Raise
			-- a Sigalrm signal exception after it expires
		deferred
		end;
	
	clear is
		deferred
		end
	
end -- class PROCESS_SYSTEM_INTERVAL_TIMER
