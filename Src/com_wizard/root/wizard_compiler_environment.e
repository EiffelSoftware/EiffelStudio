indexing
	description: "Miscellaneous compiler options"

class
	WIZARD_COMPILER_ENVIRONMENT

feature -- Access

	Idl_compiler: STRING is "midl"
			-- IDL compiler command name
	
	C_compiler: STRING is "Cl"
			-- C compiler command name
			
	Linker: STRING is "link"
			-- Linker command name
	
	Common_linker_options:STRING is "/DLL /WARN:0 /RELEASE /INCREMENTAL:NO"
			-- Linker options

	Common_c_compiler_options: STRING is "/MT /W0 /GD /Ox /D %"NDEBUG%" /D %"REGISTER_PROXY_DLL%" /D %"WIN32%" /YX /c "
			-- C compiler options

	Common_idl_compiler_options: STRING is ""
			-- MIDL options

	Rpc_library: STRING is "rpcrt4.lib"
			-- RPC library to be linked with MIDL generated c files

end -- class WIZARD_COMPILER_ENVIRONMENT
