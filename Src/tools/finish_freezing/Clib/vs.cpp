#include <windows.h>
#include <crtdbg.h>
#include <comip.h>
#include <comdef.h>
#include <comutil.h>

#include <algorithm>
#include <iostream>
#include <memory>
#include <vector>
#include <string>

#include "Setup.Configuration.h"
#include "Helpers.h"

#include "eif_eiffel.h"

_COM_SMARTPTR_TYPEDEF(ISetupInstance, __uuidof(ISetupInstance));
_COM_SMARTPTR_TYPEDEF(ISetupInstance2, __uuidof(ISetupInstance2));
_COM_SMARTPTR_TYPEDEF(IEnumSetupInstances, __uuidof(IEnumSetupInstances));
_COM_SMARTPTR_TYPEDEF(ISetupConfiguration, __uuidof(ISetupConfiguration));
_COM_SMARTPTR_TYPEDEF(ISetupConfiguration2, __uuidof(ISetupConfiguration2));
_COM_SMARTPTR_TYPEDEF(ISetupHelper, __uuidof(ISetupHelper));
_COM_SMARTPTR_TYPEDEF(ISetupPackageReference, __uuidof(ISetupPackageReference));

#define CHECK_HR(hr) if (hr) { goto failed; }

module_ptr GetQuery(_Out_ ISetupConfiguration** ppQuery)
{
	typedef HRESULT(CALLBACK* LPFNGETCONFIGURATION)(_Out_ ISetupConfiguration** ppConfiguration, LPVOID pReserved);

	const WCHAR wzLibrary[] = L"Microsoft.VisualStudio.Setup.Configuration.Native.dll";
	const CHAR szFunction[] = "GetSetupConfiguration";

	// As with COM, make sure we return a NULL pointer on error.
	_ASSERT(ppQuery);
	*ppQuery = NULL;

	ISetupConfigurationPtr query;

	// Try to create the CoCreate the class; if that fails, likely no instances are registered.
	auto hr = query.CreateInstance(__uuidof(SetupConfiguration));
	if (SUCCEEDED(hr)) {
		*ppQuery = query;
		return nullptr;
	} else if (REGDB_E_CLASSNOTREG != hr) {
		return nullptr;
	}

	// We can otherwise attempt to load the library from the PATH.
	auto hConfiguration = ::LoadLibraryW(wzLibrary);
	if (!hConfiguration) {
		return nullptr;
	}

	// Make sure the module is freed when it falls out of scope.
	module_ptr lib(&hConfiguration);

	auto fnGetConfiguration = reinterpret_cast<LPFNGETCONFIGURATION>(::GetProcAddress(hConfiguration, szFunction));
	if (!fnGetConfiguration) {
		return nullptr;
	}

	hr = fnGetConfiguration(ppQuery, NULL);
	if (FAILED(hr)) {
		return nullptr;
	}

	return lib;
}

using namespace std;

static EIF_REFERENCE c_vs_get_installation_path_impl(int version)
{
	const wstring VCCompilerType(L"Component");
	const wstring VCCompilerID(L"Microsoft.VisualStudio.Component.VC.Tools.x86.x64");

	CoInitializer init;

	ISetupConfigurationPtr query;
	auto lib = GetQuery(&query);
	if (!query) return 0;

	ISetupConfiguration2Ptr query2(query);
	ISetupHelperPtr helper(query);
	IEnumSetupInstancesPtr e;

	CHECK_HR(query2->EnumAllInstances(&e));
	ISetupInstance* pInstances[1] = {};
	auto hr = e->Next(1, pInstances, NULL);
	while (S_OK == hr) {
		// Wrap instance without AddRef'ing.
		ISetupInstancePtr instance(pInstances[0], false);
		bstr_t bstrVersion;
		CHECK_HR(instance->GetInstallationVersion(bstrVersion.GetAddress()));
		ULONGLONG ullVersion;
		CHECK_HR(helper->ParseVersion(bstrVersion, &ullVersion));
		// get the major version number
		ullVersion >>= 48L;
		if (ullVersion == version) {
			ISetupInstance2Ptr instance2(instance);
			LPSAFEARRAY psa = NULL;
			CHECK_HR(instance2->GetPackages(&psa));
			safearray_ptr psa_ptr(&psa);
			// Lock the SAFEARRAY to get the raw pointer array.
			CHECK_HR(::SafeArrayLock(psa));

			auto rgpPackages = reinterpret_cast <ISetupPackageReference** >(psa->pvData);
			auto cPackages = psa->rgsabound[0].cElements;

			if (0 != cPackages) {
				vector <ISetupPackageReference* > packages(rgpPackages, rgpPackages + cPackages);
				ISetupPackageReference *pPackage;
				size_t i = 0;
				for (; i < packages.size(); i++)
				{
					pPackage = packages[i];
					bstr_t bstrType;
					CHECK_HR(pPackage->GetType(bstrType.GetAddress()));
					bstr_t bstrID;
					CHECK_HR(pPackage->GetId(bstrID.GetAddress()));
					if (VCCompilerType == wstring(bstrType) && VCCompilerID == wstring(bstrID)) {
						bstr_t bstrInstallationPath;
						instance2->GetInstallationPath(bstrInstallationPath.GetAddress());
						return RTMS_EX((const char *)((const wchar_t *) bstrInstallationPath), bstrInstallationPath.length() * 2);
					}
				}
			}
		}

		hr = e->Next(1, pInstances, NULL);
	}
	
	return NULL;

failed:
	return NULL;
}

#ifdef __cplusplus
extern "C" {
#endif

rt_public EIF_REFERENCE c_vs_get_installation_path(int version) {
	return c_vs_get_installation_path_impl(version);
}

#ifdef __cplusplus
}
#endif
