/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
	Interpretor datas update primitives declarations
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


extern void update(char ignore_updt);					/* Update of internal structures */
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
