
#include <eif_eiffel.h>
#include <eif_except.h>
#include <stddef.h>

/* Return a pointer to newly allocated memory of at least `size' bytes
   which won't be garbage collected or moved by the Eiffel garbage
   collector.  If the allocation fails, raise an exception. */

EIF_POINTER allocate_nongc_memory (EIF_INTEGER size) {
  EIF_POINTER result;

  result = (EIF_POINTER) malloc((unsigned) size);
  if (result == NULL) {
    enomem();
  }
  return result;
}

/* Free memory pointed to by `ptr' which is not subject to garbage
   collection by the Eiffel garbage collector. */

void free_nongc_memory (EIF_POINTER ptr) {
  (void) free ((char *) ptr);
}

