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

/*
 * Byte code for assertion/debug level.
 * These values have to match with Eiffel values in classes AS_CONST/DB_CONST
 */

#define BCAS_NO			'n'
#define BCAS_REQUIRE	'r'
#define BCAS_ENSURE		'e'
#define BCAS_INVARIANT	'i'
#define BCAS_LOOP		'l'
#define BCAS_CHECK		'c'
#define BCDB_NO			'n'
#define BCDB_YES		'y'
#define BCDB_TAG		't'


public void update();		/* Update of internal structures */
public short wshort();
public long wlong();
public int32 wint32();
public uint32 wuint32();

#endif
