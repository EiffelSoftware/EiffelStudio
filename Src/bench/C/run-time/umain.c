/*

 #    #  #    #    ##       #    #    #           ####
 #    #  ##  ##   #  #      #    ##   #          #    #
 #    #  # ## #  #    #     #    # #  #          #
 #    #  #    #  ######     #    #  # #   ###    #
 #    #  #    #  #    #     #    #   ##   ###    #    #
  ####   #    #  #    #     #    #    #   ###     ####

	User's main entry point.

	This entry point may be defined by the user to do any required
	initializations. For instance, when interfacing with a data base,
	one may wish to run special initialization procedures which have
	to happen BEFORE the program enters in the main creation routine.

	At the time umain() is called, the Eiffel run-time is set up
	properly, but the root object is not created yet.
*/

/*
doc:<file name="umain.c" header="eif_umain.h" version="$Id$" summary="User's main entry point">
*/

#include "eif_umain.h"

void umain(int argc, char **argv, char **envp)
{
	/* Empty by default, but may be overwritten by user */
}

/*
doc:</file>
*/
