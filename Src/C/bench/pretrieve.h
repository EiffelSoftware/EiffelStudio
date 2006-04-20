/*
	description: "[
			Custom version of storable facilities which enables the compiler to perform
			partial retrieve on a large object. Used to extract bodys of routines from
			a store class abstract syntax tree.
			]"
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

#ifndef _pretrieve_h_
#define _pretrieve_h_

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_REFERENCE partial_retrieve (EIF_INTEGER f_desc, long position, long nb_obj);
extern EIF_REFERENCE retrieve_all(EIF_INTEGER f_desc, long position);
extern void parsing_retrieve_initialize (void);
extern EIF_REFERENCE parsing_retrieve (EIF_INTEGER f_desc, EIF_INTEGER a_pos);

#ifdef __cplusplus
}
#endif

#endif
