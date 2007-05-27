// FFCALL support C code

#ifdef EWG_FFCALL

#include "ewg_ffcall.h"

void* ewg_ffcall_alloc_callback (void* a_function, void* a_data)
{
  return alloc_callback (a_function, a_data);
}

void ewg_ffcall_free_callback (void* a_function)
{
  free_callback (a_function);
}

#endif
