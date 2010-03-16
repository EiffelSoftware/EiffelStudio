#ifdef EWG_FFCALL

#ifndef EWG_FFCALL__
#define EWG_FFCALL__
// This struct is needed by the generated C code
// for FFCALL callbacks

struct ewg_ffcall_callback_entry
{
        void* class;
        void* feature;
};
#endif

#endif
