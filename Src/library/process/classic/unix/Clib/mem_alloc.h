
#ifndef	__mem_alloc_h
#define	__mem_alloc_h


/* Byte and address manipulation */

#define offset(addr,n) (((char *) (addr)) + (n))
#define pointer_size (sizeof (void *))
#define nth_pointer(addr,n) (((void **) addr)[n])

/* Memory manipulation macros. */

#define copy_nongc_memory(src,dest,size) \
  memcpy((char *) (dest), (char *) (src), (int) (size))

#define store_pointer(p,dest,offset) \
  ((void **) (dest))[offset] = ((void *) p)

#endif
