/*
 *
 * Functions to retrieve and convert XmStrings to MEL_STRINGs.
 *
 */

#include "mel.h"

EIF_REFERENCE xm_string_to_eiffel (XmString motif_string)
{
	/*
	 * Convert `motif_string' in Eiffel string
	 * This function was written for Vision
	 */

	char * eiffel_string = (char*) NULL;
	char *result;
	char *text;
	char separator_place;
	XmStringCharSet charset;
	XmStringDirection direction;
	XmStringContext context;
	Boolean separator;

	result = (char *) malloc (sizeof (char));
	*result = (char) 0;
	if (XmStringInitContext (&context, motif_string))
		{
		for (; XmStringGetNextSegment (context, &text, &charset, &direction, &separator);)
			{
			separator_place = 1;
			if (separator) separator_place++;
			result = realloc (result, (strlen (result) + strlen (text) + separator_place));
			strcat (result, text);
			if (separator) strcat (result, "\n");
			XtFree (text);
			XtFree (charset);
			}
		XmStringFreeContext (context);
		eiffel_string = RTMS (result);
		free (result);
		}
	return (EIF_REFERENCE) eiffel_string;
}

/*
 *  For XmStringTable
 */

EIF_REFERENCE get_i_th_xmstring_table (EIF_POINTER w, EIF_INTEGER i, char *res)
{
	/*
	 * Get XmString at `i'_th-1 position table corresponding to
	 * `res' for `w'.  Don't free XmString
	 */

	XmStringTable motif_table;
	EIF_REFERENCE eiffel_string;

	XtVaGetValues ((Widget) w, (String) res, &motif_table, NULL);
	eiffel_string = xm_string_to_eiffel (* (motif_table + (int)i -1));
	return (EIF_REFERENCE) eiffel_string;
}

EIF_POINTER get_i_th_table (EIF_POINTER motif_table, EIF_INTEGER i)
{
	/*
	 * Get XmString at `i'_th-1 position from `motif_table'.
	 * Don't free XmString
	 */

	XmString motif_string;	
	motif_string = (*((XmStringTable) motif_table + (int) i - 1));
	return (EIF_POINTER) (motif_string);
}
