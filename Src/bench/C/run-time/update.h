/*

 #    #  #####   #####     ##     #####  ######          #    #
 #    #  #    #  #    #   #  #      #    #               #    #
 #    #  #    #  #    #  #    #     #    #####           ######
 #    #  #####   #    #  ######     #    #        ###    #    #
 #    #  #       #    #  #    #     #    #        ###    #    #
  ####   #       #####   #    #     #    ######   ###    #    #

	Interpretor datas update primitives declarations
*/

#ifndef _update_h_
#define _update_h_

#ifdef __cplusplus
extern "C" {
#endif


/*
 * Byte code for assertion/debug level.
 * These values have to match with Eiffel values in classes AS_CONST/DB_CONST
 */

#define BCAS_NO			'n'
#define BCAS_REQUIRE		'r'
#define BCAS_ENSURE		'e'
#define BCAS_INVARIANT		'i'
#define BCAS_LOOP		'l'
#define BCAS_CHECK		'c'
#define BCDB_NO			'n'
#define BCDB_YES		'y'
#define BCDB_TAG		't'
#define BC_NO			'n'
#define BC_YES			'y'


extern void update();					/* Update of internal structures */
extern void cnode_updt();				/* Update a cnode structure */
extern void routid_updt();				/* Update routine id arrays */
extern void conform_updt();				/* Update conformance table */
extern void option_updt();				/* Update of the option table */
extern void routinfo_updt();			/* Update routine information table */
extern void desc_updt();				/* Update the descriptors */
extern long melt_count;					/* Size of melting table */


/* Read information from file `fil'.
 */
extern short wshort();
extern long wlong();
extern int32 wint32();
extern uint32 wuint32();
extern void wread();

#ifdef __cplusplus
}
#endif

#endif
