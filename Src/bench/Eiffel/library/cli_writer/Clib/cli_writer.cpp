#include "cli_writer.h"
#include "vs_support.h"
#include "ise_cache_manager.h"
#include <objbase.h>
#include <cor.h>
#include <CorSym.h>

#ifdef _cplusplus
extern "C" {
#endif

rt_private char message [1024];
	/* Error message for exceptions */

rt_private void raise_error (HRESULT hr, char *msg);
	/* Raise error */

#ifdef ASSERTIONS
#define CHECK(hr,msg) if (hr) raise_error (hr, msg);
#else
#define CHECK(hr,msg)
#endif

/*
feature -- COM specific
*/

rt_private void raise_error (HRESULT hr, char *msg)
	/* Raise an Eiffel exception */
{
	sprintf (message, "0x%x: %s", hr, msg);
	eraise (message, EN_PROG);
}

rt_public void com_initialize ()
	/* Initialize COM runtime */
{
	HRESULT hr;
	hr = CoInitialize (NULL);

	CHECK (hr, "CoInitialize failed");
}

// ISE_COM_CACHE_MANAGER---------------------------------------------------------------------

rt_public EIF_POINTER new_ise_cache_manager ()
	/* Create new instance of ISE_Cache_ISE_COM_CACHE_MANAGER */
{
	HRESULT hr;
	ISE_Cache_COM_ISE_CACHE_MANAGER *pICM = NULL;

	hr = CoCreateInstance (CLSID_ISE_Cache_Impl_COM_ISE_CACHE_MANAGER, NULL,
		CLSCTX_INPROC_SERVER, IID_ISE_Cache_COM_ISE_CACHE_MANAGER, (void **) & pICM);

	CHECK (hr, "Could not instansiate COM Object ISE_Cache_ISE_COM_CACHE_MANAGER")

	return pICM;
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
