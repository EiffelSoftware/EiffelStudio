/*
 * mt_sql_support.c
 *
 *  Support MATISSE SQL
 *
 * Created: Aug. 98
 * Author: Kazuhiro Nakao
 *
 */

#include "matisse_eif.h"

/*****************/
/* MATISSE SQL      */
/*****************/

/*
 * c_sql_exec(char * statement)
 * 
 *  Execute SQL select query. Then return a selection ID of MtSQLResult
 *
 */
EIF_INTEGER c_sql_exec(char * statement)
{
	MtSQLResult sql_result;
	MtSTS mtResult;
	
	/*(CHECK_STS(MtSQLExec(statement, &sql_result));*/
	mtResult = MtSQLExec (statement, &sql_result);
	/*return &sql_result;*/
	return (MTEIF_OPAQUE_TYPE) sql_result.selection;
}

/*
 * c_sql_get_selection(char * selection_name)
 *
 *  Execute MtSQLGetSelection() function. 
 *  Return a selection ID of MtSQLSelection.
 */
EIF_INTEGER c_sql_get_selection(char * selection_name)
{
	MtSQLSelection selection;
	
	CHECK_STS(MtSQLGetSelection(&selection, selection_name));
	return (MTEIF_OPAQUE_TYPE) selection;
}

/*
 * c_sql_get_instance_number(int selection_id)
 *
 *  Execute MtSQL_GetSelectionNumberObjects() function. 
 *  Return the number of objects contained in a selection.
 */
EIF_INTEGER c_sql_get_instance_number(int selection_id)
{
	MtSize numObjects;
	MtSQLSelection selection;
	
	selection = (MtSQLSelection) selection_id;
	CHECK_STS(MtSQL_GetSelectionNumberObjects(&numObjects, selection));
	return numObjects;
}

/*
 * c_sql_free_selection(int selection_id)
 *
 *  Execute MtSQL_FreeSelection() function. 
 */
void c_sql_free_selection(int selection_id)
{
	MtSQLSelection selection;
	
	selection = (MtSQLSelection) selection_id;
	CHECK_STS(MtSQL_FreeSelection(selection));
}

/*
 * c_get_selection_name(int selection_id)
 *
 *  Execute MtSQLMGetSelectionName() function. 
 *  Return string of the selection name.
 */
EIF_POINTER c_get_selection_name(int selection_id)
{
	MtSQLSelection selection;
	MtString selectionName;
	
	selection = (MtSQLSelection) selection_id;
	CHECK_STS(MtSQLMGetSelectionName(selection, &selectionName));
	return selectionName;
	
}


/*************************/
/* MT_SELECTION_STREAM      */
/*************************/

/*
 * c_open_selection_stream(MTEIF_OPAQUE_TYPE  selection_id)
 *
 *  Result is MtStream.
 *    typedef mts_int32 MtStream;
 */
EIF_INTEGER c_open_selection_stream(MTEIF_OPAQUE_TYPE  selection_id)
{
	MtStream stream;
	
	CHECK_STS(MtSQL_OpenSelectionStream(&stream, (MtSQLSelection) selection_id));
	return (EIF_INTEGER) stream;
}
