/************************************************************************
	C functions for Font selection box
	----------------------------------
		font_box_apply_button (value: POINTER): POINTER
		font_box_show_ok (value: POINTER)
		font_box_show_cancel (value: POINTER)
		font_box_show_apply (value: POINTER)
		font_box_hide_ok (value: POINTER)
		font_box_hide_cancel (value: POINTER)
		font_box_hide_apply (value: POINTER)
		font_box_current_font (value: POINTER): ANY
		font_box_ok_button (value: POINTER): POINTER
		font_box_cancel_button (value: POINTER): POINTER
		font_box_create (b_name: ANY; scr_obj: POINTER, value: BOOLEAN): POINTER
		font_box_form (value: POINTER): POINTER
************************************************************************/

#include <Xm/Xm.h>
#include <Xm/RowColumn.h>
#include <Xm/List.h>
#include <Xm/PushB.h>
#include <Xm/PushBG.h>
#include <Xm/ToggleBG.h>
#include <Xm/Form.h>
#include <Xm/Text.h>
#include <Xm/SeparatoGP.h>
#include <Xm/Frame.h>
#include "eif_macros.h"

#define AttachTop(wgt,off) XtVaSetValues((wgt),XmNtopAttachment,XmATTACH_FORM,XmNtopOffset,(off),NULL)
#define AttachLeft(wgt,off) XtVaSetValues((wgt),XmNleftAttachment,XmATTACH_FORM,XmNleftOffset,(off),NULL)
#define AttachRight(wgt,off) XtVaSetValues((wgt),XmNrightAttachment,XmATTACH_FORM,XmNrightOffset,(off),NULL)
#define AttachBottom(wgt,off) XtVaSetValues((wgt),XmNbottomAttachment,XmATTACH_FORM,XmNbottomOffset,(off),NULL)
#define AttachTopWidget(tar,wgt,off) XtVaSetValues((wgt),XmNtopAttachment,XmATTACH_WIDGET,XmNtopOffset,(off),XmNtopWidget,(tar),NULL)
#define AttachLeftWidget(tar,wgt,off) XtVaSetValues((wgt),XmNleftAttachment,XmATTACH_WIDGET,XmNleftOffset,(off),XmNleftWidget,(tar),NULL)
#define AttachRightWidget(tar,wgt,off) XtVaSetValues((wgt),XmNrightAttachment,XmATTACH_WIDGET,XmNrightOffset,(off),XmNrightWidget,(tar),NULL)
#define AttachBottomWidget(tar,wgt,off) XtVaSetValues((wgt),XmNbottomAttachment,XmATTACH_WIDGET,XmNbottomOffset,(off),XmNbottomWidget,(tar),NULL)
#define AttachTopPosition(wgt,pos,off) XtVaSetValues((wgt),XmNtopAttachment,XmATTACH_POSITION,XmNtopOffset,(off),XmNtopPosition,(pos),NULL)
#define AttachLeftPosition(wgt,pos,off) XtVaSetValues((wgt),XmNleftAttachment,XmATTACH_POSITION,XmNleftOffset,(off),XmNleftPosition,(pos),NULL)
#define AttachRightPosition(wgt,pos,off) XtVaSetValues((wgt),XmNrightAttachment,XmATTACH_POSITION,XmNrightOffset,(off),XmNrightPosition,(pos),NULL)
#define AttachBottomPosition(wgt,pos,off) XtVaSetValues((wgt),XmNbottomAttachment,XmATTACH_POSITION,XmNbottomOffset,(off),XmNbottomPosition,(pos),NULL)

/****************************************************************************/
/* Datas structures															*/
/****************************************************************************/

typedef struct {						/* Informations on a standard font	*/
	char *name;							/* Full name						*/
	char *family;						/* Family name (adobe-times, ...)	*/
	char *weight;						/* Weight (bold, medium, ...)		*/
	char *slant;						/* Slant (italic, roman, ...)		*/
	char *width;						/* Width (condensed, normal, ...)	*/
	char *point;						/* Size in point					*/
	char *resolution;					/* Resolution of the screen for		*/
										/* the font has been drawn			*/
} font_box_font_info;

typedef struct {						/* Datas needed by the font-box		*/
	Widget non_stand_list;				/* Scroll list who contains the		*/
										/* non-standard fonts				*/
	Widget frame;						/* Frame who contains the			*/
										/* option-buttons to select standard*/
										/* fonts							*/
	Widget text;						/* Text widget to show the font		*/
	Widget non_stand_fonts_button; 		/* non-standard fonts option button	*/
	Widget stand_fonts_button;			/* Standard fonts option button		*/
	Widget *family_menu_buttons;		/* Buttons inside the family menu	*/
	Widget *weight_menu_buttons;		/*					weight menu		*/
	Widget *slant_menu_buttons;			/*					slant menu		*/
	Widget *width_menu_buttons;			/*					width menu		*/
	Widget *point_menu_buttons;			/*					point menu		*/
	Widget *resolution_menu_buttons;	/*					resolution menu	*/
	Widget family_menu_b;				/* Option button for the family menu*/
	Widget weight_menu_b;				/*					weight menu		*/
	Widget slant_menu_b;				/*					slant menu		*/
	Widget width_menu_b;				/*					width menu		*/
	Widget point_menu_b;				/*					point menu		*/
	Widget resolution_menu_b;			/*					resolution menu	*/
	Widget form;						/* Global form						*/
	Widget ok_button;					/* The OK button					*/
	Widget apply_button;				/* The apply button					*/
	Widget cancel_button;				/* The cancel button				*/
	int buttons_shown;					/* Are buttons shown ? (Mask)		*/
	char ** family_menu_list;			/* Array of the family names		*/
	char ** weight_menu_list;			/* Array of the weight names		*/
	char ** slant_menu_list;			/* Array of the slant names			*/
	char ** width_menu_list;			/* Array of the width names			*/
	char ** point_menu_list;			/* Array of the point names			*/
	char ** resolution_menu_list;		/* Array of the resolution names	*/
	char ** non_stand_fonts_list;		/* Array of the non standard font	*/
										/* names							*/
	font_box_font_info ** stand_fonts_list;
										/* Array of standard font			*/
										/* informations						*/
	int current_non_stand_font;			/* # of current non standard font	*/
	int current_stand_font;				/* # of current standard font		*/
	int is_stand_mode;					/* Is the current selection a		*/
										/* standard font ?					*/
	int number_stand;					/* Number of standard fonts 		*/
	char * current_font_name;			/* Current font name (!!!)			*/
	XFontStruct * current_font;			/* X structure for the current font	*/
	int current_family;					/* # of the family of current font	*/
	int current_weight;					/* # of the weight of current font	*/
	int current_slant;					/* # of the slant of current font	*/
	int current_width;					/* # of the width of current font	*/
	int current_point;					/* # of the point of current font	*/
	int current_resolution;				/* # of the resolution of current	*/
										/* font								*/
	int number_family;					/* Number of families				*/
	int number_weight;					/* Number of weights				*/
	int number_slant;					/* Number of slants					*/
	int number_width;					/* Number of widths					*/
	int number_point;					/* Number of points					*/
	int number_resolution;				/* Number of resolutions			*/
} font_box_data;

/****************************************************************************/
/* Global variable to store the Xtoolkit application context				*/
/****************************************************************************/
extern XtAppContext gAppContext;

/****************************************************************************/
/* Free all the memory used for the font box								*/
/* Called at the font-box death (XmNdestroyCallback)						*/
/* Warning: free 5 % of the memory...										*/
/****************************************************************************/
static void font_box_destroy_action (
Widget widget,							/* useless							*/
font_box_data * client,					/* font-box datas					*/
XtPointer motif)						/* Useless							*/
{
	xfree (client);
} /* font_box_destroy_action */

/****************************************************************************/
/* Create a font_box_font_info structure and fill it with the informations	*/
/* about the specified font													*/
/****************************************************************************/
static font_box_font_info * font_box_create_font_info (char * name)
	/* Full name of the font 			*/
{
	font_box_font_info * result;
	int i,j;

/* Create the structure */
	result = (font_box_font_info *) cmalloc (sizeof (font_box_font_info));

/* Fill the `name' field with the full name */
	result->name = name;

/* Extract the family name */
	for (i = 1; name [i] != '-'; i++);
	for (i++; name [i] != '-'; i++);
	result->family = (char *) cmalloc (i*sizeof (char));
	for (i = 1; name [i] != '-'; i++) result->family [i-1] = name [i];
	result->family [i-1] = '-';
	for (i++; name [i] != '-'; i++) result->family [i-1] = name [i];
	result->family [i-1] = '\0';

/* Extract the weight */
	for (j = i+1; name [j] != '-'; j++);
	if (j == i+1) result->weight = NULL;
	else {
		result->weight = (char *) cmalloc ((j-i)*sizeof (char));
		for (j = i+1; name [j] != '-'; j++) result->weight [j-(i+1)] = name [j];
		result->weight [j-(i+1)] = '\0';
	}

/* Extract the slant and give it a more significant name */
	i = j+1;
	switch (name [i]) {
		case 'o':
			result->slant = (char *) cmalloc (8*sizeof (char));
			strcpy (result->slant, "Oblique");
			break;
		case 'r':
			result->slant = (char *) cmalloc (6*sizeof (char));
			strcpy (result->slant, "Roman");
			break;
		case 'i':
			result->slant = (char *) cmalloc (7*sizeof (char));
			strcpy (result->slant, "Italic");
			break;
		case '-':
			result->slant = NULL;
			i--;
			break;
		default:
			result->slant = (char *) cmalloc (2*sizeof (char));
			result->slant [0] = name [i];
			result->slant [1] = '\0';
	}

/* Extract the width */
	i++;
	for (j = i+1; name [j] != '-'; j++);
	if (j == i+1) result->width = NULL;
	else {
		result->width = (char *) cmalloc ((j-i)*sizeof (char));
		for (j = i+1; name [j] != '-'; j++) result->width [j-(i+1)] = name [j];
		result->width [j-(i+1)] = '\0';
	}

/* Extract the point */
	i = j;
	for (i++; name [i] != '-'; i++);
	for (i++; name [i] != '-'; i++);
	for (j = i+1; name [j] != '-'; j++);
	result->point = (char *) cmalloc ((1+j-i)*sizeof (char));
	for (j = i+1; name [j] != '-'; j++) result->point [j-(i+1)] = name [j];
	if (result->point [j-(i+2)] == '0') result->point [j-(i+2)] = '\0';
	else {
		result->point [j-(i+1)] = result->point [j-(i+2)];
		result->point [j-(i+2)] = '.';
		result->point [j-i] =  '\0';
	}

/* Extract the resolution */
	i = j;
	for (j = i+1; name [j] != '-'; j++);
	for (j++; name [j] != '-'; j++);
	result->resolution = (char *) cmalloc ((j-i)*sizeof (char));
	for (j = i+1; name [j] != '-'; j++) result->resolution [j-(i+1)] = name [j];
	result->resolution [j-(i+1)] = name [j];
	for (j++; name [j] != '-'; j++) result->resolution [j-(i+1)] = name [j];
	result->resolution [j-(i+1)] = '\0';

/* Return the pointer to the structure */
	return result;
} /* font_box_create_font_info */

/****************************************************************************/
/* Put an item into a list													*/
/* Do not duplicate two equal items : if there's already an item equal to	*/
/* the one to insert, just modify the pointer to the item to make it		*/
/* pointing to the one found in the list (and free the other)				*/
/****************************************************************************/
static void font_box_put_item (
char **item,							/* Pointer to the pointer to the	*/
										/* item to insert (C is great)		*/
										/* RETURNED							*/
int *number,							/* Pointer to the number of items	*/
										/* RETURNED							*/
char ***menu_list)						/* Pointer to the pointer to the	*/
										/* array of items (C is $%*!@#)		*/
{
	int i, j;

/* Do nothing if the item is undefined */
	if (NULL == *item) return;

/* Search an item equal to the one to insert in the list */
	for (i = 0; (i < *number) && (strcmp ((*menu_list) [i], *item)); i++);

/* If found, modify the pointer to the item */
	if (i < *number) {
		xfree (*item);
		*item = (*menu_list) [i];
		return;
	}

/* If not insert it into the list */
	if ((*number)++) *menu_list = (char **) crealloc (*menu_list, (*number)*sizeof (char *));
	else *menu_list = (char **) cmalloc (sizeof (char *));
	(*menu_list) [i] = *item;
}

/****************************************************************************/
/* Sort a list with an alphabetic order										*/
/* Implemented as a buble sort												*/
/****************************************************************************/
static void font_box_sort_alpha (
int *number,							/* Pointer to the number of items	*/
										/* in the list						*/
char ***menu_list)						/* Pointer to the pointer to the	*/
										/* array of items					*/
										/* I don't why I used pointer here	*/
										/* but I'm too tired to change it	*/
{
	int i, j;
	char * tmp;

	i = 1;
	while (i)
		for (j = i = 0; j < (*number)-1; j ++)
			if (strcmp ((*menu_list) [j], (*menu_list) [j+1]) > 0) {
				i = 1;
				tmp = (*menu_list) [j];
				(*menu_list) [j] = (*menu_list) [j+1];
				(*menu_list) [j+1] = tmp;
			}
}

/****************************************************************************/
/* Sort a list with an arithmetic order										*/
/* Implemented as a buble sort												*/
/****************************************************************************/
static void font_box_sort_num (
int *number,							/* Pointer to the number of items	*/
										/* in the list						*/
char ***menu_list)						/* Pointer to the pointer to the	*/
										/* array of items					*/
										/* Same remark as above				*/
{
	int i, j;
	int num1, num2;
	char * tmp;

	i = 1;
	while (i)
		for (j = i = 0; j < (*number)-1; j ++) {
			sscanf ((*menu_list) [j], "%d", &num1);
			sscanf ((*menu_list) [j+1], "%d", &num2);
			if (num1 > num2) {
				i = 1;
				tmp = (*menu_list) [j];
				(*menu_list) [j] = (*menu_list) [j+1];
				(*menu_list) [j+1] = tmp;
			}
		}
}

/****************************************************************************/
/* Set current font in the text widget										*/
/* Free the old because it's a clever routine								*/
/****************************************************************************/
static void font_box_show_font (font_box_data * client)
	/* Font-box datas					*/
{
	Display * display;
	XmFontList motif_font_list;
	XFontStruct *old_font;
	Window window;

/* Get the display */
	display = XtDisplay (client->text);

/* Store the old font */
	old_font = client->current_font;

/* Query the new font */
	client->current_font = XLoadQueryFont (display, client->current_font_name);

/* Set it in the text widget */
	motif_font_list = XmFontListCreate (client->current_font, XmSTRING_DEFAULT_CHARSET);
	XtVaSetValues (client->text, XmNfontList, motif_font_list, NULL);
	XmFontListFree (motif_font_list);

/* Free the old font if it's loaded (the first time it is not) */
	if (old_font != NULL) XFreeFont (display, old_font);

/* Clear the window and force an Expose event to redraw properly the text */
	if (window = XtWindow (client->text))
		XClearArea (display, XtWindow (client->text), 0, 0, 0, 0, True);
}

/****************************************************************************/
/* # of the standard font who matches the current # of family, weight, ...	*/
/****************************************************************************/
static int font_box_match_stand_font (font_box_data *client)
	/* Font box datas					*/
{
	int i;

	for (i = 0;
		(client->stand_fonts_list [i]->family != client->family_menu_list [client->current_family]) ||
		((client->current_weight != -1) && (client->stand_fonts_list [i]->weight != client->weight_menu_list [client->current_weight])) ||
		((client->current_slant != -1) && (client->stand_fonts_list [i]->slant != client->slant_menu_list [client->current_slant])) ||
		((client->current_width != -1) && (client->stand_fonts_list [i]->width != client->width_menu_list [client->current_width])) ||
		(client->stand_fonts_list [i]->point != client->point_menu_list [client->current_point]) ||
		(client->stand_fonts_list [i]->resolution != client->resolution_menu_list [client->current_resolution]); i++);
	return i;
}

/****************************************************************************/
/* Set current resolution to the resolution represented by widget			*/
/* Called when a button is selected in the resolution menu					*/
/****************************************************************************/
static void font_box_set_resolution (
Widget widget,							/* Widget who select the resolution	*/
font_box_data *client,					/* Font-box datas					*/
XtPointer motif)						/* Useless							*/
{
	int i;

/* Search the # of widget */
	for (i = 0; client->resolution_menu_buttons [i] != widget; i++);

/* If already selected, return immediately */
	if (i == client->current_resolution) return;

/* Update the datas */
	client->current_resolution = i;
	client->current_stand_font = font_box_match_stand_font (client);

/* Show the new font in text widget */
	font_box_show_font (client);
}

/****************************************************************************/
/* Update the font-box when the point field has changed						*/
/* Set the sensitivity of the buttons in the resolution menu				*/
/* And select the first button if the one selected does not match any font	*/
/****************************************************************************/
static void font_box_update_point (font_box_data *client)
	/* Font-box datas				*/
{
	int j, k, l;

/* Set the sensitivity of the buttons */
	l = -1;
	for (j = 0; j < client->number_resolution; j ++) {
		XtSetSensitive (client->resolution_menu_buttons [j], False);
		for (k = 0; k < client->number_stand; k++)
			if ((client->stand_fonts_list [k]->resolution == client->resolution_menu_list [j]) &&
				(client->stand_fonts_list [k]->point == client->point_menu_list [client->current_point]) &&
				((client->current_slant == -1) || (client->stand_fonts_list [k]->slant == client->slant_menu_list [client->current_slant])) &&
				((client->current_width == -1) || (client->stand_fonts_list [k]->width == client->width_menu_list [client->current_width])) &&
				((client->current_weight == -1) || (client->stand_fonts_list [k]->weight == client->weight_menu_list [client->current_weight])) &&
				(client->stand_fonts_list [k]->family == client->family_menu_list [client->current_family])) {
				XtSetSensitive (client->resolution_menu_buttons [j], True);
				if (client->current_resolution == j) l = j;
				else if (l == -1) l = j;
			}
	}

/* If the selected button matches a font, exit */
	if (client->current_resolution == l) return;

/* Select the first button */
	client->current_resolution = l;
	XtVaSetValues (client->resolution_menu_b, XmNmenuHistory, client->resolution_menu_buttons [l], NULL);
}

/****************************************************************************/
/* Set current point size to the point size represented by widget			*/
/* Called when a button is selected in the resolution menu					*/
/****************************************************************************/
static void font_box_set_point (
Widget widget,							/* Widget who select the resolution	*/
font_box_data *client,					/* Font-box datas					*/
XtPointer motif)						/* Useless							*/
{
	int i;

/* Search the # of the widget */
	for (i = 0; client->point_menu_buttons [i] != widget; i++);

/* If already selected, return immediatly */
	if (i == client->current_point) return;

/* Update the datas */
	client->current_point = i;
	font_box_update_point (client);
	client->current_stand_font = font_box_match_stand_font (client);
	client->current_font_name = client->stand_fonts_list [client->current_stand_font]->name;

/* Show the new font in the text widget */
	font_box_show_font (client);
}

/****************************************************************************/
/* Update the font-box when the width field has changed						*/
/* Set the sensitivity of the buttons in the point size menu				*/
/* And select the first button if the one selected does not match any font	*/
/****************************************************************************/
static void font_box_update_width (font_box_data *client)
	/* Font-box datas				*/
{
	int j, k, l;

/* Set the sensitivity of the buttons */
	l = -1;
	for (j = 0; j < client->number_point; j ++) {
		XtUnmanageChild (client->point_menu_buttons [j]);
		for (k = 0; k < client->number_stand; k++)
			if ((client->stand_fonts_list [k]->point == client->point_menu_list [j]) &&
				((client->current_slant == -1) || (client->stand_fonts_list [k]->slant == client->slant_menu_list [client->current_slant])) &&
				((client->current_width == -1) || (client->stand_fonts_list [k]->width == client->width_menu_list [client->current_width])) &&
				((client->current_weight == -1) || (client->stand_fonts_list [k]->weight == client->weight_menu_list [client->current_weight])) &&
				(client->stand_fonts_list [k]->family == client->family_menu_list [client->current_family])) {
				XtManageChild (client->point_menu_buttons [j]);
				if (client->current_point == j) l = j;
				else if (l == -1) l = j;
			}
	}

/* Select the first button if it does not match any font */
	if (client->current_point != l) {
		client->current_point = l;
		XtVaSetValues (client->point_menu_b, XmNmenuHistory, client->point_menu_buttons [l], NULL);
	}

/* Update the datas after a change in point size menu */
	font_box_update_point (client);
}

void font_box_set_width (Widget widget, font_box_data *client, XtPointer motif)
{
	int i;

	for (i = 0; client->width_menu_buttons [i] != widget; i++);
	if (i == client->current_width) return;
	client->current_width = i;
	font_box_update_width (client);
	client->current_stand_font = font_box_match_stand_font (client);
	client->current_font_name = client->stand_fonts_list [client->current_stand_font]->name;
	font_box_show_font (client);
}

void font_box_update_slant (font_box_data *client)
{
	int j, k, l;

	l = -1;
	for (j = 0; j < client->number_width; j ++) {
		XtSetSensitive (client->width_menu_buttons [j], False);
		for (k = 0; k < client->number_stand; k++)
			if ((client->stand_fonts_list [k]->width == client->width_menu_list [j]) &&
				((client->current_slant == -1) || (client->stand_fonts_list [k]->slant == client->slant_menu_list [client->current_slant])) &&
				((client->current_weight == -1) || (client->stand_fonts_list [k]->weight == client->weight_menu_list [client->current_weight])) &&
				(client->stand_fonts_list [k]->family == client->family_menu_list [client->current_family])) {
				XtSetSensitive (client->width_menu_buttons [j], True);
				if (client->current_width == j) l = j;
				else if (l == -1) l = j;
			}
	}
	if (client->current_width != l) {
		client->current_width = l;
		if (l >= 0) {
			XtSetSensitive (client->width_menu_b, True);
			XtVaSetValues (client->width_menu_b, XmNmenuHistory, client->width_menu_buttons [l], NULL);
		}
		else XtSetSensitive (client->width_menu_b, False);
	}
	font_box_update_width (client);
}

void font_box_set_slant (Widget widget, font_box_data *client, XtPointer motif)
{
	int i;

	for (i = 0; client->slant_menu_buttons [i] != widget; i++);
	if (i == client->current_slant) return;
	client->current_slant = i;
	font_box_update_slant (client);
	client->current_stand_font = font_box_match_stand_font (client);
	client->current_font_name = client->stand_fonts_list [client->current_stand_font]->name;
	font_box_show_font (client);
}

void font_box_update_weight (font_box_data *client)
{
	int j, k, l;

	l = -1;
	for (j = 0; j < client->number_slant; j ++) {
		XtSetSensitive (client->slant_menu_buttons [j], False);
		for (k = 0; k < client->number_stand; k++)
			if ((client->stand_fonts_list [k]->slant == client->slant_menu_list [j]) &&
				((client->current_weight == -1) || (client->stand_fonts_list [k]->weight == client->weight_menu_list [client->current_weight])) &&
				(client->stand_fonts_list [k]->family == client->family_menu_list [client->current_family])) {
				XtSetSensitive (client->slant_menu_buttons [j], True);
				if (client->current_slant == j) l = j;
				else if (l == -1) l = j;
			}
	}
	if (client->current_slant != l) {
		client->current_slant = l;
		if (l >= 0) {
			XtSetSensitive (client->slant_menu_b, True);
			XtVaSetValues (client->slant_menu_b, XmNmenuHistory, client->slant_menu_buttons [l], NULL);
		}
		else XtSetSensitive (client->slant_menu_b, False);
	}
	font_box_update_slant (client);
}

void font_box_set_weight (Widget widget, font_box_data *client, XtPointer motif)
{
	int i;

	for (i = 0; client->weight_menu_buttons [i] != widget; i++);
	if (i == client->current_weight) return;
	client->current_weight = i;
	font_box_update_weight (client);
	client->current_stand_font = font_box_match_stand_font (client);
	client->current_font_name = client->stand_fonts_list [client->current_stand_font]->name;
	font_box_show_font (client);
}

void font_box_update_family (font_box_data *client)
{
	int j, k, l;

	l = -1;
	for (j = 0; j < client->number_weight; j ++) {
		XtSetSensitive (client->weight_menu_buttons [j], False);
		for (k = 0; k < client->number_stand; k++) {
			if ((client->stand_fonts_list [k]->weight == client->weight_menu_list [j]) &&
				(client->stand_fonts_list [k]->family == client->family_menu_list [client->current_family])) {
				XtSetSensitive (client->weight_menu_buttons [j], True);
				if (client->current_weight == j) l = j;
				else if (l == -1) l = j;
			}
		}
	}
	if (client->current_weight != l) {
		client->current_weight = l;
		if (l >= 0) {
			XtSetSensitive (client->weight_menu_b, True);
			XtVaSetValues (client->weight_menu_b, XmNmenuHistory, client->weight_menu_buttons [l], NULL);
		}
		else XtSetSensitive (client->weight_menu_b, False);
	}
	font_box_update_weight (client);
}

void font_box_set_family (Widget widget, font_box_data *client, XtPointer motif)
{
	int i;

	for (i = 0; client->family_menu_buttons [i] != widget; i++);
	if (i == client->current_family) return;
	client->current_family = i;
	font_box_update_family (client);
	client->current_stand_font = font_box_match_stand_font (client);
	client->current_font_name = client->stand_fonts_list [client->current_stand_font]->name;
	font_box_show_font (client);
}

void font_box_fill_menu (Widget **menu_buttons, Widget menu, int *number, char ***menu_list)
{
	int i;

	*menu_buttons = (Widget *) cmalloc ((*number)*sizeof (Widget));
	for (i = 0; i < *number; i++) {
		(*menu_buttons) [i] = XmCreatePushButtonGadget (menu, (*menu_list) [i], NULL, 0);
		XtManageChild ((*menu_buttons) [i]);
	}
}

void font_box_switch_to_non_stand (Widget widget, font_box_data * client, XtPointer motif)
{
	if (!client->is_stand_mode) return;
	XtMapWidget (XtParent (client->non_stand_list));
	XtUnmapWidget (client->frame);
	client->current_font_name = client->non_stand_fonts_list [client->current_non_stand_font];
	client->is_stand_mode = 0;
	font_box_show_font (client);
}

void font_box_switch_to_stand (Widget widget, font_box_data * client, XtPointer motif)
{
	if (client->is_stand_mode) return;
	XtUnmapWidget (XtParent (client->non_stand_list));
	XtMapWidget (client->frame);
	client->current_font_name = client->stand_fonts_list [client->current_stand_font]->name;
	client->is_stand_mode = 1;
	font_box_show_font (client);
}

void font_box_select_non_stand (Widget widget, font_box_data * client,
	XmListCallbackStruct * motif)
{
	client->current_non_stand_font = motif->item_position-1;
	client->current_font_name = client->non_stand_fonts_list [motif->item_position-1];
	font_box_show_font (client);
}

void font_box_attach_buttons (font_box_data * client)
{
	int width_button, nb_buttons, i;

	nb_buttons = 0;
	if (client->buttons_shown & 1) nb_buttons++;
	if (client->buttons_shown & 2) nb_buttons++;
	if (client->buttons_shown & 4) nb_buttons++;
	if (!nb_buttons) return;
	width_button = 6 / nb_buttons;
	i = 1;
	if (client->buttons_shown & 1) {
		AttachLeft (client->ok_button, 3);
		if (i == nb_buttons) AttachRight (client->ok_button, 3);
		else AttachRightPosition (client->ok_button, i*width_button, 3);
		i++;
	}
	if (client->buttons_shown & 2) {
		if (i == 1) AttachLeft (client->apply_button, 3);
		else AttachLeftPosition (client->apply_button, (i-1)*width_button, 3);
		if (i == nb_buttons) AttachRight (client->apply_button, 3);
		else AttachRightPosition (client->apply_button, i*width_button, 3);
		i++;
	}
	if (client->buttons_shown & 4) {
		if (i == 1) AttachLeft (client->cancel_button, 3);
		else AttachLeftPosition (client->cancel_button, (i-1)*width_button, 3);
		AttachRight (client->cancel_button, 3);
	}
}

EIF_POINTER font_box_create (char * a_name, EIF_POINTER a_parent, EIF_BOOLEAN dialog)
{
	Widget form, select_form, mode_option;
	Widget mode_menu, stand_fonts_button, non_stand_fonts_button;
	Widget non_stand_list;
	Widget stand_column, frame;
	Widget form_button;
	Widget ok_button, apply_button, cancel_button;
	Widget family_menu_b, weight_menu_b, slant_menu_b;
	Widget width_menu_b, point_menu_b, resolution_menu_b;
	Widget family_menu, weight_menu, slant_menu;
	Widget width_menu, point_menu, resolution_menu;
	Widget text;
	Widget *family_menu_buttons;
	Widget *weight_menu_buttons;
	Widget *slant_menu_buttons;
	Widget *width_menu_buttons;
	Widget *point_menu_buttons;
	Widget *resolution_menu_buttons;
	font_box_data * client;
	XmString string;
	Display * display;
	int number_fonts;
	char ** fonts_list;
	char ** non_stand_fonts_list;
	int number_non_stand, number_stand;
	XmString * non_stand_strings;
	font_box_font_info ** stand_fonts_list;
	int i, j;
	char * tmp_string;
	XmString tmp_xm_string;
	char **family_menu_list;
	char **weight_menu_list;
	char **slant_menu_list;
	char **width_menu_list;
	char **point_menu_list;
	char **resolution_menu_list;
	int number_family, number_weight, number_slant;
	int number_width, number_point, number_resolution;

/*
 * Creation of form dialog
 */
	if (dialog) {
		form = XmCreateFormDialog ((Widget) a_parent, (String) a_name, NULL, 0);
		XtVaSetValues (form, XmNautoUnmanage, False, NULL);
	}
	else form = XmCreateForm ((Widget) a_parent, (String) a_name, NULL, 0);

/*
 * Creation of sub-widgets
 */
	select_form = XmCreateForm (form, "selectForm", NULL, 0);
	XtManageChild (select_form);
	text = XmCreateText (form, "text", NULL, 0);
	XtManageChild (text);
	form_button = XmCreateForm (form, "buttonsForm", NULL, 0);
	XtManageChild (form_button);
	mode_option = XmCreateOptionMenu (select_form, "switchOption", NULL, 0);
	XtManageChild (mode_option);
	mode_menu = XmCreatePulldownMenu (select_form, "switchMenu", NULL, 0);
	stand_fonts_button = XmCreatePushButtonGadget (mode_menu, "standFont", NULL, 0);
	XtManageChild (stand_fonts_button);
	non_stand_fonts_button = XmCreatePushButtonGadget (mode_menu, "nonStandFont", NULL, 0);
	XtManageChild (non_stand_fonts_button);

/*
 * Creation of non-standard font selection system
 */
	non_stand_list = XmCreateScrolledList (select_form, "nonStandList", NULL, 0);
	XtManageChild (non_stand_list);

/*
 * Creation of standard font selection system
 */
	frame = XmCreateFrame (select_form, "standFrame", NULL, 0);
	XtManageChild (frame);
	stand_column = XmCreateRowColumn (frame, "standColumn", NULL, 0);
	XtManageChild (stand_column);
	family_menu_b = XmCreateOptionMenu (stand_column, "familyMenuButton", NULL, 0);
	XtManageChild (family_menu_b);
	weight_menu_b = XmCreateOptionMenu (stand_column, "weightMenuButton", NULL, 0);
	XtManageChild (weight_menu_b);
	slant_menu_b = XmCreateOptionMenu (stand_column, "slantMenuButton", NULL, 0);
	XtManageChild (slant_menu_b);
	width_menu_b = XmCreateOptionMenu (stand_column, "widthMenuButton", NULL, 0);
	XtManageChild (width_menu_b);
	point_menu_b = XmCreateOptionMenu (stand_column, "pointMenuButton", NULL, 0);
	XtManageChild (point_menu_b);
	resolution_menu_b = XmCreateOptionMenu (stand_column, "resolutionMenuButton", NULL, 0);
	XtManageChild (resolution_menu_b);
	family_menu = XmCreatePulldownMenu (stand_column, "familyMenu", NULL, 0);
	weight_menu = XmCreatePulldownMenu (stand_column, "weightMenu", NULL, 0);
	slant_menu = XmCreatePulldownMenu (stand_column, "slantMenu", NULL, 0);
	width_menu = XmCreatePulldownMenu (stand_column, "widthMenu", NULL, 0);
	point_menu = XmCreatePulldownMenu (stand_column, "pointMenu", NULL, 0);
	resolution_menu = XmCreatePulldownMenu (stand_column, "resolutionMenu", NULL, 0);

/*
 * Creation of buttons
 */
	ok_button = XmCreatePushButtonGadget (form_button, "Ok", NULL, 0);
	XtManageChild (ok_button);
	apply_button = XmCreatePushButtonGadget (form_button, "Apply", NULL, 0);
	XtManageChild (apply_button);
	cancel_button = XmCreatePushButtonGadget (form_button, "Cancel", NULL, 0);
	XtManageChild (cancel_button);

/*
 * Attachments in font selection system
 */
	AttachTop (mode_option, 0);
	AttachLeft (mode_option, 0);
	AttachRight (mode_option, 0);

/*
 * Attachments in non-standard font selection system
 */
	AttachTopWidget (mode_option, XtParent (non_stand_list), 5);
	AttachLeft (XtParent (non_stand_list), 0);
	AttachRight (XtParent (non_stand_list), 0);
	AttachBottom (XtParent (non_stand_list), 0);

/*
 * Attachments in standard font selection system
 */
	AttachTopWidget (mode_option, frame, 5);
	AttachLeft (frame, 0);
	AttachRight (frame, 0);
	AttachBottom (frame, 0);

/*
 * Attachments in buttons form
 */
	XtVaSetValues (form_button, XmNfractionBase, 6, NULL);
	AttachTop (ok_button, 0);
	AttachBottom (ok_button, 0);
	AttachTop (apply_button, 0);
	AttachBottom (apply_button, 0);
	AttachTop (cancel_button, 0);
	AttachBottom (cancel_button, 0);

/*
 * Attachments in global form
 */
	AttachTop (select_form, 10);
	AttachLeft (select_form, 10);
	AttachRight (select_form, 10);
	AttachTopWidget (select_form, text, 10);
	AttachLeft (text, 10);
	AttachRight (text, 10);
	AttachBottomWidget (form_button, text, 10);
	AttachLeft (form_button, 10);
	AttachRight (form_button, 10);
	AttachBottom (form_button, 10);

/*
 * Default values
 */
	XtVaSetValues (family_menu_b, XmNsubMenuId, family_menu, NULL);
	XtVaSetValues (weight_menu_b, XmNsubMenuId, weight_menu, NULL);
	XtVaSetValues (slant_menu_b, XmNsubMenuId, slant_menu, NULL);
	XtVaSetValues (width_menu_b, XmNsubMenuId, width_menu, NULL);
	XtVaSetValues (point_menu_b, XmNsubMenuId, point_menu, NULL);
	XtVaSetValues (resolution_menu_b, XmNsubMenuId, resolution_menu, NULL);
	XmTextSetString (text, "Current_selected_font");
	XtVaSetValues (text, XmNresizeHeight, True, XmNeditMode, XmMULTI_LINE_EDIT, NULL);
	XtVaSetValues (XtParent (non_stand_list), XmNmappedWhenManaged, False, NULL);
	string = XmStringCreateLtoR ("Non standard fonts", XmSTRING_DEFAULT_CHARSET);
	XtVaSetValues (non_stand_fonts_button, XmNlabelString, string, NULL);
	XmStringFree (string);
	string = XmStringCreateLtoR ("Standard fonts", XmSTRING_DEFAULT_CHARSET);
	XtVaSetValues (stand_fonts_button, XmNlabelString, string, NULL);
	XmStringFree (string);
	XtVaSetValues (mode_option, XmNsubMenuId, mode_menu, NULL);
	XtVaSetValues (mode_option, XmNmenuHistory, stand_fonts_button, NULL);

/*
 * Callbacks
 */
	client = (font_box_data *) cmalloc (sizeof (font_box_data));
	XtAddCallback (non_stand_list, XmNbrowseSelectionCallback, (XtCallbackProc) font_box_select_non_stand, client);
	XtAddCallback (stand_fonts_button, XmNactivateCallback, (XtCallbackProc) font_box_switch_to_stand, client);
	XtAddCallback (non_stand_fonts_button, XmNactivateCallback, (XtCallbackProc) font_box_switch_to_non_stand, client);
	XtAddCallback (form, XmNdestroyCallback, (XtCallbackProc) font_box_destroy_action, client);

/*
 * Fill the client structure
 */
	client->non_stand_list = non_stand_list;
	client->is_stand_mode = 1;
	client->frame = frame;
	client->text = text;
	client->family_menu_b = family_menu_b;
	client->weight_menu_b = weight_menu_b;
	client->slant_menu_b = slant_menu_b;
	client->width_menu_b = width_menu_b;
	client->point_menu_b = point_menu_b;
	client->resolution_menu_b = resolution_menu_b;
	client->form = form;
	client->ok_button = ok_button;
	client->apply_button = apply_button;
	client->cancel_button = cancel_button;
	client->buttons_shown = 7;
	client->stand_fonts_button = stand_fonts_button;
	client->non_stand_fonts_button = non_stand_fonts_button;
	font_box_attach_buttons (client);

/*
 * Get the font list of current display
 */
	display = XtDisplay (form);
	fonts_list = XListFonts (display, "*", 10000, &number_fonts);

/*
 * Get the non standard fonts
 */
	number_non_stand = 0;
	for (i = 0; i < number_fonts; i++)
		if ('-' != *(fonts_list [i])) number_non_stand++;
	non_stand_strings = (XmString *) cmalloc (number_non_stand*sizeof (XmString));
	non_stand_fonts_list = (char **) cmalloc (number_non_stand*sizeof (char *));
	for (i = j = 0; i < number_fonts; i++)
		if ('-' != *(fonts_list [i])) {
			non_stand_fonts_list [j] = fonts_list [i];
			non_stand_strings [j++] = XmStringCreate (fonts_list [i], XmSTRING_DEFAULT_CHARSET);
		}
	i = 1;
	while (i)
		for (j = i = 0; j < number_non_stand-1; j++)
			if (strcmp (non_stand_fonts_list [j], non_stand_fonts_list [j+1]) > 0) {
				i = 1;
				tmp_string = non_stand_fonts_list [j];
				non_stand_fonts_list [j] = non_stand_fonts_list [j+1];
				non_stand_fonts_list [j+1] = tmp_string;
				tmp_xm_string = non_stand_strings [j];
				non_stand_strings [j] = non_stand_strings [j+1];
				non_stand_strings [j+1] = tmp_xm_string;
			}
	XmListAddItems (non_stand_list, non_stand_strings, number_non_stand, 1);
	XmListSelectPos (non_stand_list, 1, False);

/*
 * Get the standard fonts
 */
	number_stand = number_fonts-number_non_stand;
	stand_fonts_list = (font_box_font_info **) cmalloc (number_stand*sizeof (font_box_font_info *));
	for (i = j = 0; i < number_fonts; i++)
		if ('-' == *(fonts_list [i])) {
			stand_fonts_list [j++] = font_box_create_font_info (fonts_list [i]);
		}
	number_family = 0;
	number_weight = 0;
	number_slant = 0;
	number_width = 0;
	number_point = 0;
	number_resolution = 0;
	for (i = 0; i < number_stand; i++) {
		font_box_put_item (&(stand_fonts_list [i]->family), &number_family, &family_menu_list);
		font_box_put_item (&(stand_fonts_list [i]->weight), &number_weight, &weight_menu_list);
		font_box_put_item (&(stand_fonts_list [i]->slant), &number_slant, &slant_menu_list);
		font_box_put_item (&(stand_fonts_list [i]->width), &number_width, &width_menu_list);
		font_box_put_item (&(stand_fonts_list [i]->point), &number_point, &point_menu_list);
		font_box_put_item (&(stand_fonts_list [i]->resolution), &number_resolution, &resolution_menu_list);
	}
	font_box_sort_alpha (&number_family, &family_menu_list);
	font_box_sort_alpha (&number_weight, &weight_menu_list);
	font_box_sort_alpha (&number_slant, &slant_menu_list);
	font_box_sort_alpha (&number_width, &width_menu_list);
	font_box_sort_num (&number_point, &point_menu_list);
	font_box_sort_alpha (&number_resolution, &resolution_menu_list);
	font_box_fill_menu (&family_menu_buttons, family_menu, &number_family, &family_menu_list);
	font_box_fill_menu (&weight_menu_buttons, weight_menu, &number_weight, &weight_menu_list);
	font_box_fill_menu (&slant_menu_buttons, slant_menu, &number_slant, &slant_menu_list);
	font_box_fill_menu (&width_menu_buttons, width_menu, &number_width, &width_menu_list);
	font_box_fill_menu (&point_menu_buttons, point_menu, &number_point, &point_menu_list);
	font_box_fill_menu (&resolution_menu_buttons, resolution_menu, &number_resolution, &resolution_menu_list);
	for (i = 0; i < number_family; i++)
		XtAddCallback (family_menu_buttons [i], XmNactivateCallback, (XtCallbackProc) font_box_set_family, client);
	for (i = 0; i < number_weight; i++)
		XtAddCallback (weight_menu_buttons [i], XmNactivateCallback, (XtCallbackProc) font_box_set_weight, client);
	for (i = 0; i < number_slant; i++)
		XtAddCallback (slant_menu_buttons [i], XmNactivateCallback, (XtCallbackProc) font_box_set_slant, client);
	for (i = 0; i < number_width; i++)
		XtAddCallback (width_menu_buttons [i], XmNactivateCallback, (XtCallbackProc) font_box_set_width, client);
	for (i = 0; i < number_point; i++)
		XtAddCallback (point_menu_buttons [i], XmNactivateCallback, (XtCallbackProc) font_box_set_point, client);
	for (i = 0; i < number_resolution; i++)
		XtAddCallback (resolution_menu_buttons [i], XmNactivateCallback, (XtCallbackProc) font_box_set_resolution, client);

/*
 * Fill the client structure
 */
	client->non_stand_fonts_list = non_stand_fonts_list;
	client->stand_fonts_list = stand_fonts_list;
	client->current_font_name = non_stand_fonts_list [0];
	client->current_stand_font = 0;
	client->current_non_stand_font = 0;
	client->family_menu_buttons = family_menu_buttons;
	client->weight_menu_buttons = weight_menu_buttons;
	client->slant_menu_buttons = slant_menu_buttons;
	client->width_menu_buttons = width_menu_buttons;
	client->point_menu_buttons = point_menu_buttons;
	client->resolution_menu_buttons = resolution_menu_buttons;
	client->family_menu_list = family_menu_list;
	client->weight_menu_list = weight_menu_list;
	client->slant_menu_list = slant_menu_list;
	client->width_menu_list = width_menu_list;
	client->point_menu_list = point_menu_list;
	client->resolution_menu_list = resolution_menu_list;
	client->number_stand = number_stand;
	client->number_family = number_family;
	client->number_weight = number_weight;
	client->number_slant = number_slant;
	client->number_width = number_width;
	client->number_point = number_point;
	client->number_resolution = number_resolution;
	client->current_font = NULL;
	client->current_family = client->current_weight = client->current_slant = -1;
	client->current_width = client->current_point = client->current_resolution = -1;
	font_box_set_family (family_menu_buttons [0], client, NULL);

	return (EIF_POINTER) client;
}

EIF_POINTER font_box_form (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	return (EIF_POINTER) (temp->form);
}

EIF_POINTER font_box_ok_button (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	return (EIF_POINTER) (temp->ok_button);
}

EIF_POINTER font_box_apply_button (EIF_POINTER *client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	return (EIF_POINTER) (temp->apply_button);
}

EIF_POINTER font_box_cancel_button (EIF_POINTER *client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	return (EIF_POINTER) (temp->cancel_button);
}

char *font_box_current_font (EIF_POINTER *client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	return temp->current_font_name;
}

void font_box_hide_ok (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	if (!(temp->buttons_shown & 1)) return;
	temp->buttons_shown &= 6;
	font_box_attach_buttons (temp);
	XtUnmanageChild (temp->ok_button);
}

void font_box_show_ok (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	if (temp->buttons_shown & 1) return;
	XtManageChild (temp->ok_button);
	temp->buttons_shown |= 1;
	font_box_attach_buttons (temp);
}

void font_box_hide_apply (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	if (!(temp->buttons_shown & 2)) return;
	temp->buttons_shown &= 5;
	font_box_attach_buttons (temp);
	XtUnmanageChild (temp->apply_button);
}

void font_box_show_apply (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	if (temp->buttons_shown & 2) return;
	XtManageChild (temp->apply_button);
	temp->buttons_shown |= 2;
	font_box_attach_buttons (temp);
}

void font_box_hide_cancel (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	if (!(temp->buttons_shown & 4)) return;
	temp->buttons_shown &= 3;
	font_box_attach_buttons (temp);
	XtUnmanageChild (temp->cancel_button);
}

void font_box_show_cancel (EIF_POINTER client)
{
	font_box_data *temp;

	temp = (font_box_data *) client;
	if (temp->buttons_shown & 4) return;
	XtManageChild (temp->cancel_button);
	temp->buttons_shown |= 4;
	font_box_attach_buttons (temp);
}

void font_box_set_font (char *font_name, EIF_POINTER client)
{
	font_box_data *temp;
	char *f_name;

	if ((char *) 0 == (f_name = cmalloc(strlen(font_name))))
		enomem();
   
	strcpy(f_name, font_name);
	temp = (font_box_data *) client;
	temp->current_font_name = f_name;
	font_box_update_family ((font_box_data*)client);
	temp->current_stand_font = font_box_match_stand_font (temp);
	temp->current_font_name = temp->stand_fonts_list [temp->current_stand_font]->name;
	font_box_show_font (temp);
}

void fb_set_button_fg_color (EIF_POINTER client, EIF_POINTER pix)
{
	font_box_data *fbd = (font_box_data *) client;
	Widget w;

	if (fbd->number_family) {
		w = XtParent((fbd->family_menu_buttons)[0]);
		XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
	}
	if (fbd->number_slant) {
		w = XtParent((fbd->slant_menu_buttons)[0]);
		XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
	}
	if (fbd->number_width) {
		w = XtParent((fbd->slant_menu_buttons)[0]);
		XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
	}
	if (fbd->number_weight) {
		w = XtParent((fbd->weight_menu_buttons)[0]);
		XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
	}
	if (fbd->number_point) {
		w = XtParent((fbd->point_menu_buttons)[0]);
		XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
	}
	if (fbd->number_resolution) {
		w = XtParent((fbd->resolution_menu_buttons)[0]);
		XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
	}
	w = XtParent(fbd->stand_fonts_button);
	XtVaSetValues (w, XmNforeground, (Pixel) pix, NULL);
}

void fb_set_button_bg_color (EIF_POINTER client, EIF_POINTER pix)
{
	font_box_data *fbd = (font_box_data *) client;
	/*  Need to only set the parent color since
		children are gadgets (i.e. gadgets automatically
		get the color of the parent) */

	if (fbd->number_family)
		XmChangeColor (XtParent((fbd->family_menu_buttons)[0]), (Pixel) pix);
	if (fbd->number_slant)
		XmChangeColor (XtParent((fbd->slant_menu_buttons)[0]), (Pixel) pix);
	if (fbd->number_width)
		XmChangeColor (XtParent((fbd->width_menu_buttons)[0]), (Pixel) pix);
	if (fbd->number_weight)
		XmChangeColor (XtParent((fbd->weight_menu_buttons)[0]), (Pixel) pix);
	if (fbd->number_point)
		XmChangeColor (XtParent((fbd->point_menu_buttons)[0]), (Pixel) pix);
	if (fbd->number_resolution)
		XmChangeColor (XtParent((fbd->resolution_menu_buttons)[0]), (Pixel) pix);
	XmChangeColor (XtParent(fbd->stand_fonts_button), pix);
}

void fb_set_text_font (EIF_POINTER client, EIF_POINTER motif_font_list)
{
	font_box_data *fbd = (font_box_data *) client;

	XtVaSetValues (fbd->non_stand_list, XmNfontList, (XmFontList) motif_font_list, NULL);
}

void fb_set_pulldown_font (Widget *menu_buttons, int number, XmFontList motif_font_list)
{
	int i;
	for (i = 0; i < number; i++) {
		XtVaSetValues (menu_buttons[i], XmNfontList, motif_font_list, NULL);
	}
}

void fb_set_button_font (EIF_POINTER client, EIF_POINTER motif_font_list)
{
	font_box_data *fbd = (font_box_data *) client;
	XmFontList fl = (XmFontList) motif_font_list;

	XtVaSetValues (fbd->ok_button, XmNfontList, (XmFontList) fl, NULL);
	XtVaSetValues (fbd->apply_button, XmNfontList, (XmFontList) fl, NULL);
	XtVaSetValues (fbd->cancel_button, XmNfontList, (XmFontList) fl, NULL);
	fb_set_pulldown_font (fbd->family_menu_buttons, fbd->number_family, fl);
	fb_set_pulldown_font (fbd->slant_menu_buttons, fbd->number_slant, fl);
	fb_set_pulldown_font (fbd->width_menu_buttons, fbd->number_width, fl);
	fb_set_pulldown_font (fbd->weight_menu_buttons, fbd->number_weight, fl);
	fb_set_pulldown_font (fbd->point_menu_buttons, fbd->number_point, fl);
	fb_set_pulldown_font (fbd->resolution_menu_buttons, fbd->number_resolution, fl);
	XtVaSetValues (fbd->stand_fonts_button, XmNfontList, (XmFontList) fl, NULL);
	XtVaSetValues (fbd->non_stand_fonts_button, XmNfontList, (XmFontList) fl, NULL);
}

