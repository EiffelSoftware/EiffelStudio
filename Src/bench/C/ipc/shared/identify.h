/*

    #    #####   ######  #    #   #####     #    ######   #   #          #    #
    #    #    #  #       ##   #     #       #    #         # #           #    #
    #    #    #  #####   # #  #     #       #    #####      #            ######
    #    #    #  #       #  # #     #       #    #          #     ###    #    #
    #    #    #  #       #   ##     #       #    #          #     ###    #    #
    #    #####   ######  #    #     #       #    #          #     ###    #    #

	Identify parent, to make sure we are started via the ised wrapper.

	For Windows:
		Well actually check we were launched from a legitimate launcher.

		We need to uudecode the arguments that come down.

		We use the real command line usng GetCommandLine - this may cause a
		problem if WEL ever encapsulates this call rather than using the
		command line pointer it uses now.

		dummy console handles are (re)created at this point - this will
		need looking at for non windowed apps.
*/

#ifndef _identify_h_
#define _identify_h_

extern int identify();

#endif /* _identify_h_ */
