#include "dotnet_loader.h"

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
//#include <stdbool.h>
#include <iostream>

// Provided by the AppHost NuGet package and installed as an SDK pack
#include <nethost.h>

// Header files copied from https://github.com/dotnet/core-setup
#include <coreclr_delegates.h>
#include <hostfxr.h>

#ifdef WINDOWS
#include <Windows.h>

#define STR(s) L ## s
#define CH(c) L ## c
#define DIR_SEPARATOR L'\\'

#else
#include <dlfcn.h>
#include <limits.h>

#define STR(s) s
#define CH(c) c
#define DIR_SEPARATOR '/'
#define MAX_PATH PATH_MAX

#endif

using string_t = std::basic_string<char_t>;

// Globals to hold hostfxr exports
// namespace {
	bool hostfxr_loaded=false;
	hostfxr_initialize_for_runtime_config_fn init_fptr;
	hostfxr_get_runtime_delegate_fn get_delegate_fptr;
	hostfxr_close_fn close_fptr;
	
	// Forward declarations
	bool load_hostfxr();
	load_assembly_and_get_function_pointer_fn get_dotnet_load_assembly(const char_t *assembly);
// } // namespace

int process_nethost_call(char_t* loc, char_t* method_name, char_t* type_name, void *arg, int arg_size_in_bytes)
{
    // Get the current executable's directory
    // This sample assumes the managed assembly to load and its runtime configuration file are next to the host
    char_t host_path[MAX_PATH];

#if WINDOWS
    auto size = ::GetFullPathNameW(loc, sizeof(host_path) / sizeof(char_t), host_path, nullptr);
    assert(size != 0);
#else
    auto resolved = realpath(loc, host_path);
    assert(resolved != nullptr);
#endif

// printf("host_path=%s\n", host_path);

	string_t root_path = STR(""); root_path.append(host_path);
    auto pos = root_path.find_last_of(DIR_SEPARATOR);
    assert(pos != string_t::npos);
    root_path = root_path.substr(0, pos + 1);

// printf("root_path=%s\n", root_path.c_str());

	string_t based_module_path = STR(""); based_module_path.append(host_path);
	pos = based_module_path.find_last_of('.');
    assert(pos != string_t::npos);
    based_module_path = based_module_path.substr(0, pos);

// printf("based_module_path=%s\n", based_module_path.c_str());

    //
    // Load HostFxr and get exported hosting functions
    //
    if (!load_hostfxr())
    {
        assert(false && "Failure: load_hostfxr()");
        return EXIT_FAILURE;
    }

    //
    //  Initialize and start the .NET Core runtime
    //
    const string_t config_path = based_module_path + STR(".runtimeconfig.json");
    load_assembly_and_get_function_pointer_fn load_assembly_and_get_function_pointer = nullptr;
    load_assembly_and_get_function_pointer = get_dotnet_load_assembly(config_path.c_str());
    assert(load_assembly_and_get_function_pointer != nullptr && "Failure: get_dotnet_load_assembly()");

	// 
	// Prepare and call method
	//
    const string_t dotnetlib_path = based_module_path + STR(".dll");
	const char_t *dotnet_type = type_name;
	const char_t *dotnet_type_method = method_name;

	// printf("Get pointer on method [%s] on type [%s] from module %s \n", dotnet_type_method, dotnet_type, dotnetlib_path.c_str());
    component_entry_point_fn custom = nullptr;
    int rc = load_assembly_and_get_function_pointer(
        dotnetlib_path.c_str(),
        dotnet_type,
	    dotnet_type_method,
        nullptr /*delegate_type_name*/, 
        nullptr,
        (void**)&custom);

	// printf("CHECK: rc=%d\n", rc);

    assert(rc == 0 && custom != nullptr && "Failure: load_assembly_and_get_function_pointer()");
	
	if (rc == 0) {
		custom(arg, arg_size_in_bytes);
	} else {
		printf("FAILED: rc=%d \n", rc);
	}

    return EXIT_SUCCESS;
}


/********************************************************************************************
 * Function used to load and activate .NET Core
 ********************************************************************************************/

//namespace {

	// Forward declarations
	void *load_library(const char_t *);
	void *get_export(void *, const char *);

#ifdef WINDOWS
	void *load_library(const char_t *path)
	{
    	HMODULE h = ::LoadLibraryW(path);
    	assert(h != nullptr);
    	return (void*)h;
	}
	void *get_export(void *h, const char *name)
	{
    	void *f = ::GetProcAddress((HMODULE)h, name);
    	assert(f != nullptr);
    	return f;
	}
#else
	void *load_library(const char_t *path)
	{
    	void *h = dlopen(path, RTLD_LAZY | RTLD_LOCAL);
    	assert(h != nullptr);
    	return h;
	}
	void *get_export(void *h, const char *name)
	{
    	void *f = dlsym(h, name);
    	assert(f != nullptr);
    	return f;
	}
#endif

	// <SnippetLoadHostFxr>
	// Using the nethost library, discover the location of hostfxr and get exports
	bool load_hostfxr()
	{
		if (!hostfxr_loaded) {
			hostfxr_loaded = true;
    		//
    		// Pre-allocate a large buffer for the path to hostfxr
    		char_t buffer[MAX_PATH];
    		size_t buffer_size = sizeof(buffer) / sizeof(char_t);
    		int rc = get_hostfxr_path(buffer, &buffer_size, nullptr);
    		if (rc != 0)
        		return false;

    		// Load hostfxr and get desired exports
    		void *lib = load_library(buffer);
    		init_fptr = (hostfxr_initialize_for_runtime_config_fn)get_export(lib, "hostfxr_initialize_for_runtime_config");
    		get_delegate_fptr = (hostfxr_get_runtime_delegate_fn)get_export(lib, "hostfxr_get_runtime_delegate");
    		close_fptr = (hostfxr_close_fn)get_export(lib, "hostfxr_close");
    	}

    	return (init_fptr && get_delegate_fptr && close_fptr);
	}
	// </SnippetLoadHostFxr>

	// <SnippetInitialize>
	// Load and initialize .NET Core and get desired function pointer for scenario
	load_assembly_and_get_function_pointer_fn get_dotnet_load_assembly(const char_t *config_path)
	{
	    // Load .NET Core
	    void *load_assembly_and_get_function_pointer = nullptr;
	    hostfxr_handle cxt = nullptr;
	    int rc = init_fptr(config_path, nullptr, &cxt);
	    if (rc < 0 || cxt == nullptr)
	    {
	        std::cerr << "Init failed: " << std::hex << std::showbase << rc << std::endl;
	        close_fptr(cxt);
	        return nullptr;
	    }
	    // Get the load assembly function pointer
	    rc = get_delegate_fptr(
	        cxt,
	        hdt_load_assembly_and_get_function_pointer,
	        &load_assembly_and_get_function_pointer);
	    if (rc != 0 || load_assembly_and_get_function_pointer == nullptr) {
	        std::cerr << "Get delegate failed: " << std::hex << std::showbase << rc << std::endl;
		}
	
	    close_fptr(cxt);
	    return (load_assembly_and_get_function_pointer_fn)load_assembly_and_get_function_pointer;
	}
	// </SnippetInitialize>

//} // namespace

#ifdef _cplusplus
extern "C" {
#else
#ifdef __cplusplus
extern "C" {
#endif
#endif


#ifdef _cplusplus
}
#else
#ifdef __cplusplus
}
#endif
#endif

