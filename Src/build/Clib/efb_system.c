#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pwd.h>
#include <X11/Intrinsic.h>
#include "macros.h"

char * file_to_string (fn)
char * fn;
{

	struct stat sb;
	int nb;
	FILE *f;
	char *s;
	int i;

	stat (fn, &sb);
	nb = (int) sb.st_size;
	f = fopen (fn, "r");
	s = (char *) malloc (sizeof (char) * (nb + 1));
	fread (s, sizeof (char), nb, f); 
	s [nb] = '\0';
	fclose (f);
	return (s);
}

/*
 *      Execute `command' with `input_string' as input.
 *      Create a pipe between the current process and the `command',
 *      send the `message' to the `command' through the pipe,
 *      and then close the pipe.
 *      Return 0 if `command' has been executed successfully.
 */
 
void send_to_command (input_string, command)
char *input_string;
char *command;
{
    FILE *ptr;
 
    if ((ptr = popen (command, "w")) != NULL){
        fputs (input_string, ptr);
        pclose (ptr);
	}
}
 
 
/*
 *      Name of the user
 */
 
char* username ()
{
    return (getpwuid (getuid ())->pw_name);
}


EIF_POINTER c_efb_get_background (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[1];
	Pixel p;

	n = 0;
	XtSetArg (wargs[n], "background", &p); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) p);
}

void c_efb_set_background (w, p)
EIF_POINTER w;
EIF_POINTER p;
{
	int n;
	Arg wargs[1];

	n = 0;
	XtSetArg (wargs[n], "background", (Pixel) p); n++;
	XtSetValues ((Widget) w, wargs, n);
}

EIF_POINTER c_efb_get_foreground (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[1];
	Pixel p;

	n = 0;
	XtSetArg (wargs[n], "foreground", &p); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) p);
}

void c_efb_set_foreground (w, p)
EIF_POINTER w;
EIF_POINTER p;
{
	int n;
	Arg wargs[1];

	n = 0;
	XtSetArg (wargs[n], "foreground", (Pixel) p); n++;
	XtSetValues ((Widget) w, wargs, n);
}

void c_efb_set_bg_pixmap (w, p)
EIF_POINTER w;
EIF_POINTER p;
{
	int n;
	Arg wargs[1];
	
	n = 0;
	XtSetArg (wargs[n], "backgroundPixmap", (Pixmap) p); n++;
	XtSetValues ((Widget) w, wargs, n); 

}	
EIF_POINTER c_efb_get_bg_pixmap (w)
EIF_POINTER w;
{
	int n;
	Arg wargs[1];
	Pixmap p;

	n = 0;
	XtSetArg (wargs[n], "backgroundPixmap", &p); n++;
	XtGetValues ((Widget) w, wargs, n);
	return ((EIF_POINTER) p);
}

extern event_pointer();

EIF_REFERENCE efb_translation_string (code)
EIF_INTEGER code
{
}
