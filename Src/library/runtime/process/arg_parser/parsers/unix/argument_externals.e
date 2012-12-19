note
	description: "Externals used by the argument parser library"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_EXTERNALS

feature -- Externals

	c_get_term_columns: INTEGER
			-- Retrieves the number of columns in the active terminal.
		external
			"C inline use <stdio.h>, <unistd.h>, <sys/ioctl.h>, <termios.h>"
		alias
			"[
				#ifdef TIOCGSIZE
					struct ttysize win;
				    if (ioctl (STDIN_FILENO, TIOCGSIZE, &win))
				        return 0;
				    else
				        return win.ts_cols;
				#elif defined TIOCGWINSZ
					struct winsize win;
				    if (ioctl (STDIN_FILENO, TIOCGWINSZ, &win))
				        return 0;
				    else
				        return win.ws_col;
				#else
				    {
						// Not likely to work because COLUMNS generally is a shell variable.
				        const char *s;
				        s = getenv ("COLUMNS");
				        if (s)
				            return strtol (s, 0, 10);
				        else
				            return 0;
				    }
				#endif
			]"
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
