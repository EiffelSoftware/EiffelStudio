#include "eif_eiffel.h"

rt_public EIF_INTEGER eif_packet_size (void)
{
#ifdef __SCO__
	return 100;
#else
	return 200;
#endif
}

