/*

 #    #    ##     #####  #    #           ####
 ##  ##   #  #      #    #    #          #    #
 # ## #  #    #     #    ######          #
 #    #  ######     #    #    #   ###    #
 #    #  #    #     #    #    #   ###    #    #
 #    #  #    #     #    #    #   ###     ####

	Externals for class SINGLE_MATH (mathematical operation on REAL).
*/

#include "config.h"
#include "portable.h"
#include <math.h>

rt_public float math_rcos(v)
float v;
{
	/* Real cosine of radian `v' approximated in [-pi/4, +pi/4] */

	return (float) cos((double) v);
}

rt_public float math_rsin(v)
float v;
{
    /* Real sine of radian `v' approximated in [-pi/4, +pi/4] */

	return (float) sin((double) v);
}

rt_public float math_rtan(v)
float v;
{
    /* Real tangent of radian `v' approximated in [-pi/4, +pi/4] */

	return (float) tan((double) v);
}

rt_public float math_racos(v)
float v;
{
	/* Arc cosine of `v' */

	return (float) acos((double) v);
}


rt_public float math_rasin(v)
float v;
{
	/* Arc sine of `v' */

	return (float) asin((double) v);
}

rt_public float math_ratan(v)
float v;
{
	/* Arc tangent of 'v' */

	return (float) atan((double) v);
}

rt_public float math_rsqrt(v)
float v;
{
	/* Real square root of `v' */

	return (float) sqrt((double) v);
}

rt_public float math_rlog(v)
float v;
{
	/* Real natural logarithm of `v' */

	return (float) log((double) v);
}

rt_public float math_rlog10(v)
float v;
{
	/* Real base 10 logarithm of `v' */

	return (float) log10((double) v);
}

rt_public float math_rfloor(v)
float v;
{
	/* Greatest integral value less than or equal to `v' */

	return (float) floor((double) v);
}

rt_public float math_rceil(v)
float v;
{
    /* Least integral value greater than or equal to `v' */

	return (float) ceil((double) v);
}

rt_public float math_rfabs(v)
float v;
{
	/* Absolute value of `v' */

	return (float) fabs ((double) v);
}

rt_public double math_power (v1, v2)
double v1, v2;
{
	/* v1 ** v2*/

	return (double) pow (v1, v2);
}

