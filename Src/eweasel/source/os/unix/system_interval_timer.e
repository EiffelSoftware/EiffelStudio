indexing
	date: "August 21, 1998";
	description: "An operating system interval timer that counts down in %
		%real time"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class SYSTEM_INTERVAL_TIMER

feature -- Modification

	set_seconds (d: DOUBLE) is
			-- Set timer to expire in `d' seconds.  Raise
			-- a Sigalrm signal exception after it expires
		deferred
		end;
	
	clear is
		deferred
		end
	
indexing
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class SYSTEM_INTERVAL_TIMER
