#ifndef _rt_msc_ver_mismatch_
#define _rt_msc_ver_mismatch_

#ifdef _MSC_VER
/* We need to define _ALLOW_MSC_VER_MISMATCH on Windows because if we don't we get a linker
 * error if the linker is a different version from the one used to compile the runtime. This
 * only happens when the C++ code we compile use some standard libraries.
 *
 * Because all our C++ code is only being used inside the runtime (no exchange with the
 * outside world) and because our testing via eweasel shows this to work, we define
 * the following macro to prevent the linker for raising a version mismatch.
 */
#define _ALLOW_MSC_VER_MISMATCH

/* We also disable the unreferenced local function warnings. */
#pragma warning (disable:4505)

#endif

#endif
