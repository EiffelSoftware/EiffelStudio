/*
	description: "Interpretor datas update primitives declarations."
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

#ifndef _eif_update_h_
#define _eif_update_h_

#ifdef __cplusplus
extern "C" {
#endif


/*
 * Byte code for assertion/debug level.
 * These values have to match with Eiffel values in classes AS_CONST/DB_CONST
 */

#define BCDB_NO			'n'
#define BCDB_YES		'y'
#define BCDB_TAG		't'
#define BC_NO			'n'
#define BC_YES			'y'


extern void update(char ignore_updt, char *argv0);					/* Update of internal structures */
extern void cnode_updt(void);				/* Update a cnode structure */
extern void routid_updt(void);				/* Update routine id arrays */
extern void conform_updt(void);				/* Update conformance table */
extern void option_updt(void);				/* Update of the option table */
extern void routinfo_updt(void);			/* Update routine information table */
extern void desc_updt(void);				/* Update the descriptors */
extern long melt_count;					/* Size of melting table */


#ifdef __cplusplus
}
#endif

#endif
