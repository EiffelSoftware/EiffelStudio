/*
	description: "Declarations for `identify.c'."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _identify_h_
#define _identify_h_

#ifdef EIF_WINDOWS
#include <windows.h>
extern int custom_identify(char* id, HANDLE *p_ewbin, HANDLE *p_ewbout, HANDLE *p_event_r, HANDLE *p_event_w, int (*get_pipe_data_func_ptr)(int, char*, HANDLE*, HANDLE*, HANDLE*, HANDLE*), int get_pipe_data_func_arg1);
extern int identify(char* id, HANDLE *p_ewbin, HANDLE *p_ewbout, HANDLE *p_event_r, HANDLE *p_event_w);
extern int identify_with_socket(char* id, HANDLE *p_ewbin, HANDLE *p_ewbout, HANDLE *p_event_r, HANDLE *p_event_w, int a_port_number);
#else
extern int custom_identify(char* id, int* p_fdr, int* p_fdw, int (*get_pipe_data_func_ptr)(int, char*, int*, int*), int get_pipe_data_func_arg1);
extern int identify(char* id, int fdr, int fdw);
extern int identify_with_socket(char* id, int* p_fdr, int* p_fdw, int a_port_number);
#endif

#endif /* _identify_h_ */
