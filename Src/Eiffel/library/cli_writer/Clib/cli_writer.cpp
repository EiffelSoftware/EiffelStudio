#define _WIN32_DCOM
#include "cli_writer.h"
#include "vs_support.h"
#include "metadata_consumer.h"
#include <objbase.h>
#include <cor.h>
#include <CorSym.h>
#include <mscoree.h>

#ifdef _cplusplus
extern "C" {
#endif

rt_private char message [1024];
	/* Error message for exceptions */

#ifdef ASSERTIONS
rt_private void raise_error (HRESULT hr, char *msg); /* Raise error */
#define CHECK(hr,msg) if (hr) raise_error (hr, msg);
#else
#define CHECK(hr,msg)
#endif

/*
feature -- COM specific
*/

#ifdef ASSERTIONS
rt_private void raise_error (HRESULT hr, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "0x%x: %s", hr, msg);
	eraise (message, EN_PROG);
}
#endif



#ifdef DBGTRACE_ENABLED
rt_public void trace_event_hr (char* mesg,HRESULT hr)
{
  FILE *out;
  out=fopen("eif_debugger.out","a+");
  fprintf(out,"<HR=%d> %s \n",
					hr,
					mesg
					);
  fclose(out);
}
#define DBGTRACE_HR(msg1,hr) trace_event_hr(msg1, hr);
#else
#define DBGTRACE_HR(msg,hr)
#endif

//rt_public void com_initialize ()
//	/* Initialize COM runtime */
//{
//	HRESULT hr;
//	hr = CoInitialize (NULL);
///*
//	hr = CoInitializeEx(NULL, COINIT_APARTMENTTHREADED);
//	hr = CoInitializeEx(NULL, COINIT_MULTITHREADED);
//*/
//
//	CHECK ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), "CoInitialize failed");
//}

// COM_CACHE_MANAGER---------------------------------------------------------------------

rt_public EIF_POINTER new_cache_manager ()
	/* Create new instance of EiffelSoftware_MetadataConsumer_Interop_Impl_COM_CACHE_MANAGER */
{
	HRESULT hr;
	EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER *pICM = NULL;

	hr = CoCreateInstance (CLSID_EiffelSoftware_MetadataConsumer_Interop_Impl_COM_CACHE_MANAGER, NULL,
		CLSCTX_INPROC_SERVER, IID_EiffelSoftware_MetadataConsumer_Interop_I_COM_CACHE_MANAGER, (void **) & pICM);

	CHECK (hr, "Could not instansiate COM Object CLSID_EiffelSoftware_MetadataConsumer_Interop_Impl_COM_CACHE_MANAGER")

	return pICM;
}

/*
feature -- CorBindToRuntimeEx interface
*/


rt_public EIF_POINTER new_cor_runtime_host (LPWSTR version, DWORD flags)
	/* Create new instance of `ICorRuntimeHost'. */
{
	HRESULT hr = NULL;
	HMODULE mscoree = NULL;
	FARPROC cor_bind_to_runtime_ex = NULL;
	ICorRuntimeHost *pHost = NULL;

	mscoree = LoadLibrary (L"mscoree.dll");
	if (mscoree != NULL) {
		cor_bind_to_runtime_ex = GetProcAddress (mscoree, "CorBindToRuntimeEx");
		if (cor_bind_to_runtime_ex != NULL) {
			hr = (FUNCTION_CAST_TYPE(HRESULT, STDAPICALLTYPE, (LPWSTR, LPWSTR, DWORD, REFCLSID, REFIID, LPVOID *)) cor_bind_to_runtime_ex)
				(version, NULL, flags, CLSID_CorRuntimeHost, IID_ICorRuntimeHost, (void **)&pHost);
		}
	}

	CHECK ((((hr == S_OK) || (hr == S_FALSE)) ? 0 : 1), "Could not create ICorRuntimeHost or already initialized");

	return pHost;
}

/*
feature -- Fusion Support API
*/

//FusionSupport------------------------------------------------------------------------------

rt_public EIF_POINTER new_fusion_support ()
	/* Create new instance of IFusionSupport */
{
	HRESULT hr;
	IFusionSupport *ifs;

	hr = CoCreateInstance (CLSID_FusionSupport, NULL,
		CLSCTX_INPROC_SERVER, IID_IFusionSupport, (void **) & ifs);

	CHECK (hr, "Could not create IFusionSupport")

	return ifs;
}

/*
feature -- Unmanaged Metadata API
*/

rt_public EIF_POINTER new_md_dispenser ()
	/* Create new instance of IMetaDataDispenser */
{
	HRESULT hr;
	IMetaDataDispenser *imdd;

	hr = CoCreateInstance (CLSID_CorMetaDataDispenser, NULL,
		CLSCTX_INPROC_SERVER, IID_IMetaDataDispenser, (void **) & imdd);

	CHECK (hr, "Could not create IMetaDataDisepenser")

	return imdd;
}

rt_public void c_define_option_for_md_emit (EIF_POINTER md_dispenser, EIF_INTEGER val)
	/* Call `SetOption' */
{
	IMetaDataDispenser *dispenser = (IMetaDataDispenser *) md_dispenser;
	IMetaDataDispenserEx * iex;
	HRESULT hr = 0;

	if (!dispenser->QueryInterface(IID_IMetaDataDispenserEx, (void **)&iex)) {
		VARIANT value;
		value.vt = VT_UI4;

			/* Check for duplicates of some tokens */
/*		value.ulVal = MDDupSignature|MDDupMemberRef|MDDupModuleRef|MDDupTypeRef;
		iex->SetOption(MetaDataCheckDuplicatesFor	, &value);
		CHECK (hr, "Could not set Option")
*/

			/* Give error if emitting out of order */
		value.ulVal = val;
		hr = iex->SetOption(MetaDataErrorIfEmitOutOfOrder, &value);
		CHECK (hr, "Could not set Option")

		iex->Release();
	} else {
		CHECK (hr, "Could not get IMetaDataDispenserEx")
	}
}

rt_public EIF_POINTER c_define_scope_for_md_emit (EIF_POINTER md_dispenser)
	/* Call `DefineScope (CLSID_CorMetaDataRuntime, 0, IID_IMetaDataEmit, (IUnknown **) &imde)' */
{
	IMetaDataDispenser *dispenser = (IMetaDataDispenser *) md_dispenser;
	IMetaDataEmit *imde;
	HRESULT hr;

	hr = dispenser->DefineScope (CLSID_CorMetaDataRuntime,
		0, IID_IMetaDataEmit, (IUnknown **) &imde);

	CHECK (hr, "Could not get IMetaDataEmit")

	return imde;
}

rt_public EIF_POINTER c_query_assembly_emit (EIF_POINTER md_emit)
	/* Call `QueryInterface(IID_IMetaDataAssemblyEmit, (void **)&imda)' */
{
	IMetaDataEmit *emit = (IMetaDataEmit *) md_emit;
	IMetaDataAssemblyEmit *imda;
	HRESULT hr;

	hr = emit->QueryInterface(IID_IMetaDataAssemblyEmit, (void **)&imda);

	CHECK (hr, "Could not get IMetaDataAssemblyEmit");

	return imda;
}

/*
feature -- Debuggin information
*/

const CLSID CLSID_CorSymWriter = {0x108296C1,0x281E,0x11d3,{0xBD,0x22,0x00,0x00,0xF8,0x08,0x49,0xBD}};
const IID IID_ISymUnmanagedWriter = {0xED14AA72,0x78E2,0x4884,{0x84,0xE2,0x33,0x42,0x93,0xAE,0x52,0x14}};

rt_public EIF_POINTER new_sym_writer ()
	/* Create new instance of ISymUnmanagedWriter */
{
	HRESULT hr;
	ISymUnmanagedWriter *writer;

	hr = CoCreateInstance (CLSID_CorSymWriter, NULL,
		CLSCTX_INPROC_SERVER, IID_ISymUnmanagedWriter, (void **) & writer);

	CHECK (hr, "Could not create ISymUnmanagedWriter")

	return writer;
}

#ifdef _cplusplus
}
#endif
