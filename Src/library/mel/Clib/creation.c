#include "mel.h"
#include <Xm/List.h>
#include <Xm/RowColumn.h>
#include <Xm/Text.h>
#include <Xm/ScrolledW.h>
#include <Xm/MainW.h>

/*
 *
 * These are routines designed to create widgets and setting
 * some resources that can only be set at the creation of the
 * widget.
 *
 */

rt_private Arg auto_unmanage_arg[1];

EIF_POINTER c_auto_unmanage_arg()
{
	XtSetArg (auto_unmanage_arg[0], XmNautoUnmanage, False);
	return (EIF_POINTER) auto_unmanage_arg;
}

EIF_POINTER xm_create_scrolled_list_constant (Widget w, char *a_name)
{
	Arg args[1];

	XtSetArg (args[0], XmNlistSizePolicy, XmCONSTANT);

	return (EIF_POINTER) XmCreateScrolledList (w, a_name, args, 1);
}

EIF_POINTER xm_create_scrolled_list_resize (Widget w, char *a_name)
{
	Arg args[1];

	XtSetArg (args[0], XmNlistSizePolicy, XmRESIZE_IF_POSSIBLE);

	return (EIF_POINTER) XmCreateScrolledList (w, a_name, args, 1);
}


EIF_POINTER xm_create_option_menu_with_label (EIF_POINTER a_parent, char *a_name, EIF_POINTER a_xmstring)
{
	Arg args[1];

	XtSetArg (args[0], XmNlabelString, (XmString) a_xmstring);

	return (EIF_POINTER) XmCreateOptionMenu ((Widget) a_parent, (String) a_name , args, 1);
}

EIF_POINTER xm_create_scrolled_text (EIF_POINTER a_parent, char *a_name)
{
	Arg args[1];

	XtSetArg (args[0], XmNeditMode, XmMULTI_LINE_EDIT);

	return (EIF_POINTER) XmCreateScrolledText ((Widget) a_parent, (String) a_name, args, 1);
}

EIF_POINTER xm_create_scrolled_text_detailed (EIF_POINTER a_parent, char *a_name,
	EIF_BOOLEAN scroll_hor, EIF_BOOLEAN scroll_vert, EIF_BOOLEAN scroll_top,
	EIF_BOOLEAN scroll_left)
{
	Arg args[5];

	XtSetArg (args[0], XmNeditMode, XmMULTI_LINE_EDIT);
	XtSetArg (args[1], XmNscrollHorizontal, (Boolean) scroll_hor);
	XtSetArg (args[2], XmNscrollVertical, (Boolean) scroll_vert);
	XtSetArg (args[3], XmNscrollTopSide, (Boolean) scroll_top);
	XtSetArg (args[4], XmNscrollLeftSide, (Boolean) scroll_left);

	return (EIF_POINTER) XmCreateScrolledText ((Widget) a_parent, (String) a_name, args, 5);
}

EIF_POINTER xm_create_scrolled_window_with_automatic_scrolling
	(a_parent, a_name)
EIF_POINTER a_parent;
char *a_name;
{
	Arg args[1];

	XtSetArg (args[0], XmNscrollingPolicy, XmAUTOMATIC);

	return (EIF_POINTER) XmCreateScrolledWindow ((Widget) a_parent, (String) a_name, args, 1);
}

EIF_POINTER xm_create_main_window_detailed
	(a_parent, a_name, com_below, auto_scroll)
EIF_POINTER a_parent;
char *a_name;
Boolean com_below;
Boolean auto_scroll;
{
	Arg args[2];

	if (com_below != False)
		XtSetArg (args[0], XmNcommandWindowLocation, XmCOMMAND_BELOW_WORKSPACE);
	else
		XtSetArg (args[0], XmNcommandWindowLocation, XmCOMMAND_ABOVE_WORKSPACE);

	if (auto_scroll != False)
		XtSetArg (args[1], XmNscrollingPolicy, XmAUTOMATIC);
	else
		XtSetArg (args[1], XmNscrollingPolicy,XmAPPLICATION_DEFINED);

	return (EIF_POINTER) XmCreateMainWindow ((Widget) a_parent, (String) a_name, args, 2);
}

EIF_POINTER xm_create_check_box
	(a_parent, a_name)
EIF_POINTER a_parent;
char *a_name;
{
	Arg args[4];

	XtSetArg (args[0], XmNnavigationType, XmTAB_GROUP);
	XtSetArg (args[1], XmNradioBehavior, False);
	XtSetArg (args[2], XmNrowColumnType, XmWORK_AREA);
	XtSetArg (args[3], XmNtraversalOn, True);

	return (EIF_POINTER) XmCreateRowColumn ((Widget) a_parent, (String) a_name, args, 4);
}

EIF_POINTER xm_create_main_window_with_automatic_scrolling
	(EIF_POINTER a_parent, char *a_name)
{
	Arg args[1];

	XtSetArg (args[0], XmNscrollingPolicy, XmAUTOMATIC);

	return (EIF_POINTER) XmCreateMainWindow ((Widget) a_parent, (String) a_name, args, 1);
}


EIF_POINTER xt_create_transient_shell (char * a_name, EIF_POINTER a_parent)
{
	return (EIF_POINTER) XtCreatePopupShell (a_name, transientShellWidgetClass, (Widget) a_parent, NULL, 0);
}

EIF_POINTER xt_create_override_shell (char * a_name, EIF_POINTER a_parent)
{
	return (EIF_POINTER) XtCreatePopupShell (a_name, overrideShellWidgetClass, (Widget) a_parent, NULL, 0);
}

EIF_POINTER xt_create_app_shell (char *app_name, char *class_name, 
	EIF_POINTER disp, EIF_POINTER screen)
{
	return (EIF_POINTER) XtVaAppCreateShell (app_name, class_name, 
					applicationShellWidgetClass,
					(Display *) disp,
					XmNscreen, (Screen *) screen,
					NULL);

}

EIF_POINTER xt_create_top_level_shell (char *app_name, char *class_name,
	EIF_POINTER disp, EIF_POINTER screen)
{
	return (EIF_POINTER) XtVaAppCreateShell (app_name, class_name, 
					topLevelShellWidgetClass,
					(Display *) disp,
					XmNscreen, (Screen *) screen,
					NULL);
}

EIF_POINTER xt_create_top_level_popup_shell (char *a_name, EIF_POINTER a_parent, 
	EIF_POINTER a_screen)
{
	Arg an_arg;

	XtSetArg (an_arg, XmNscreen, (Screen *) a_screen);

	return (EIF_POINTER) 
			XtCreatePopupShell (a_name, topLevelShellWidgetClass,
						(Widget) a_parent, &an_arg, 1);
}

