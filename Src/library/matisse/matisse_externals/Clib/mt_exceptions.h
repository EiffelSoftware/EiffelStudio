/*
 * mt_exceptions.h
 */

#ifndef __MT_EXCEPTIONS__
#define __MT_EXCEPTIONS__


#define CHECK_STS(MtFunc) \
{\
	MtSTS status;\
	if (MtFailure(status = MtFunc)){              \
		EIF_MT_LOG(MtError());  /** temporary **/ \
		EIF_MT_LOG("\n");                         \
		raise_mt_exception(status);               \
		/* eraise (MtError(), status);*/          \
	}	/** Raise Eiffel exception **/            \
}


/*
 * Check return status.
 * Ignore an error specified by an argument
 */
#define CHECK_STS_IGNERR(MtFunc, sts_to_be_ignored) \
{\
	MtSTS status;\
	status = MtFunc; \
	if (status != sts_to_be_ignored) {   \
		if (MtFailure(status)){         \
			EIF_MT_LOG("sts ignored mode\n");    \
			EIF_MT_LOG(MtError());           \
			EIF_MT_LOG("\n");                \
			raise_mt_exception(status);      \
		}	/** Raise Eiffel exception **/   \
	} \
}

void raise_mt_exception(int status);

#endif
