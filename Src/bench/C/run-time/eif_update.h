/*

 #    #  #####   #####     ##     #####  ######          #    #
 #    #  #    #  #    #   #  #      #    #               #    #
 #    #  #    #  #    #  #    #     #    #####           ######
 #    #  #####   #    #  ######     #    #        ###    #    #
 #    #  #       #    #  #    #     #    #        ###    #    #
  ####   #       #####   #    #     #    ######   ###    #    #

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


/* Read information from file `fil'.
 */
extern short wshort(void);
extern long wlong(void);
extern int32 wint32(void);
extern uint32 wuint32(void);
extern void wread(char *buffer, size_t nbytes);
extern int16 *wtype_array(int16 *);
extern char *wclass_name(void);

#ifdef __cplusplus
}
#endif

#endif
