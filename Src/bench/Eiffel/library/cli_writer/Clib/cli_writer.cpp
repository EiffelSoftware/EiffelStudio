#include "cli_writer.h"
#include "cor.h"
#include <objbase.h>

#ifdef _cplusplus
extern "C" {
#endif

rt_private char message [1024];
	/* Error message for exceptions */

rt_private void raise_error (HRESULT hr, char *msg);
	/* Raise error */

#ifdef ASSERTIONS
#define CHECK(hr,msg)	if (hr) raise_error (hr, msg);
#else
#define CHECK(hr,msg)
#endif

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

#ifdef _cplusplus
}
#endif
