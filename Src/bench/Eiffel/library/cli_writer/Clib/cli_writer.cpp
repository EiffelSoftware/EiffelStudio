#include "cli_writer.h"
#include "vs_support.h"
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
#define CHECK(hr,msg)	if (hr) raise_error (hr, msg);
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

rt_public EIF_POINTER c_get_gac_assemblies (EIF_POINTER i_fusion_support)
	/* Call `GetGacAssemblies()' */
{
	IFusionSupport * fusion_support = (IFusionSupport *) i_fusion_support;
	IEnumAssemblies *iea;
	HRESULT hr;

	hr = fusion_support->GetGacAssemblies ((IEnumAssemblies **) &iea);

	CHECK (hr, "Could not get IEnumAssemblies")

	return iea;
}

rt_public EIF_BOOLEAN c_signed (EIF_POINTER i_fusion_support, EIF_POINTER a_path)
	/* Call `GetGacAssemblies()' */
{
	IFusionSupport * fusion_support = (IFusionSupport *) i_fusion_support;
	BOOL is_signed;
	HRESULT hr;
	BSTR pBStr;

	pBStr = SysAllocString ((LPWSTR) a_path);

	hr = fusion_support->IsAssemblySigned (pBStr, (VARIANT_BOOL*) &is_signed);

	SysFreeString (pBStr);

	CHECK (hr, "Could not get IsAssemblySigned")

	return (EIF_BOOLEAN) is_signed;
}

rt_public EIF_POINTER c_get_assembly_info_from_assembly (EIF_POINTER i_fusion_support, EIF_POINTER a_path)
	/* Call `GetGacAssemblies()' */
{
	IFusionSupport * fusion_support = (IFusionSupport *) i_fusion_support;
	IAssemblyInfo *iai;
	HRESULT hr;
	BSTR pBStr;

	pBStr = SysAllocString ((LPWSTR) a_path);

	hr = fusion_support->GetAssemblyInfoFromAssembly (pBStr, (IAssemblyInfo **) &iai);

	SysFreeString (pBStr);

	CHECK (hr, "Could not get IsAssemblySigned")

	return iai;
}

//IEnumAssemblies----------------------------------------------------------------------------

rt_public EIF_POINTER c_ith (EIF_POINTER i_enum_assemblies, EIF_INTEGER index)
	/* Call `IEnumAssemblies->IthItem(index)' */
{
	IEnumAssemblies * enum_assemblies = (IEnumAssemblies *) i_enum_assemblies;
	IAssemblyInfo *iai;
	HRESULT hr;

	hr = enum_assemblies->IthItem (index, (IAssemblyInfo **) &iai);

	CHECK (hr, "Could not get IAssembyInfo")

	return iai;
}

rt_public EIF_INTEGER c_count (EIF_POINTER i_enum_assemblies)
	/* Call `IEnumAssemblies->Count()' */
{
	IEnumAssemblies * enum_assemblies = (IEnumAssemblies *) i_enum_assemblies;
	long count;
	HRESULT hr;

	hr = enum_assemblies->get_Count (&count);

	CHECK (hr, "Could not get Count")

	return count;
}

//IAssemblyInfo----------------------------------------------------------------------------------

rt_public EIF_INTEGER c_name (EIF_POINTER i_assembly_info, EIF_POINTER a_str)
	/* Call `IAssemblyInfo->assembly_name() */
{
	IAssemblyInfo* assembly_info = (IAssemblyInfo *) i_assembly_info;
	HRESULT hr;

	hr = assembly_info->AssemblyName ((LPWSTR *) a_str);

	CHECK (hr, "Could not get Name")

	return hr;
}

rt_public EIF_INTEGER c_version (EIF_POINTER i_assembly_info, EIF_POINTER a_str)
	/* Call `IAssemblyInfo->assembly_version() */
{
	IAssemblyInfo* assembly_info = (IAssemblyInfo *) i_assembly_info;
	HRESULT hr;

	hr = assembly_info->Version ((LPWSTR *) a_str);

	CHECK (hr, "Could not get Version")

	return hr;
}

rt_public EIF_INTEGER c_culture (EIF_POINTER i_assembly_info, EIF_POINTER a_str)
	/* Call `IAssemblyInfo->assembly_culture() */
{
	IAssemblyInfo* assembly_info = (IAssemblyInfo *) i_assembly_info;
	HRESULT hr;

	hr = assembly_info->Culture ((LPWSTR *) a_str);

	CHECK (hr, "Could not get Culture")

	return hr;
}

rt_public EIF_INTEGER c_public_key_token (EIF_POINTER i_assembly_info, EIF_POINTER a_str)
	/* Call `IAssemblyInfo->assembly_public_key_token() */
{
	IAssemblyInfo* assembly_info = (IAssemblyInfo *) i_assembly_info;
	HRESULT hr;

	hr = assembly_info->PublicKeyToken ((LPWSTR *) a_str);

	CHECK (hr, "Could not get Public Key Token")

	return hr;
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
