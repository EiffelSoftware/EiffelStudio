#define EIF_WINDOWS_MINGW
/* -D"RTI64C(x)=CAT2(x,LL)" -D"RTU64C(x)=CAT2(x,ULL)" */
#define RTI64C(x) CAT2(x,LL)
#define RTU64C(x) CAT2(x,ULL)
