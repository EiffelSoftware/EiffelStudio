indexing
	description: "Miscellaneous compiler options"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPILER_ENVIRONMENT

inherit
	WIZARD_EXECUTION_ENVIRONMENT

feature -- Access

	Idl_compiler: STRING is "midl"
			-- IDL compiler command name.
	
	C_compiler: STRING is "Cl"
			-- C compiler command name.
			
	Linker: STRING is "link"
			-- Linker command name.
	
	Common_linker_options:STRING is " /DLL  /WARN:0 /RELEASE %"/INCREMENTAL:NO%""
			-- Linker options.

	Common_c_compiler_options: STRING is 
			-- C compiler options to compile Proxy/Stub.
		once
			Result := "/ML /W0 /Ox /D %"REGISTER_PROXY_DLL%" /D %"WIN32%" /D %"_WIN32_DCOM%" /D %"_WIN32_WINNT=0x0500%" /YX /c /I..\include /I..\..\common\include /I"
			Result.append (Eiffel_installation_dir_name)
			Result.append ("\studio\spec\windows\include /I")
			Result.append (Eiffel_installation_dir_name)
			Result.append ("\library\com\spec\windows\include ")
		end

	Common_idl_compiler_options: STRING is ""
			-- MIDL options.

	Rpc_library: STRING is "%"kernel32.lib%" %"rpcndr.lib%" %"rpcns4.lib%" %"rpcrt4.lib%" %"uuid.lib%" %"oleaut32.lib%""
			-- RPC library to be linked with MIDL generated c files.

end -- class WIZARD_COMPILER_ENVIRONMENT

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
