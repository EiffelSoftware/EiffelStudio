indexing
	description: "Miscellaneous compiler options"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPILER_ENVIRONMENT

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Access

	Idl_compiler: STRING is "midl"
			-- IDL compiler command name
	
	C_compiler: STRING is "Cl"
			-- C compiler command name
			
	Linker: STRING is "link"
			-- Linker command name
	
	Common_linker_options:STRING is " /DLL  /WARN:0 /RELEASE %"/INCREMENTAL:NO%""
			-- Linker options

	Common_standard_c_compiler_options: STRING is 
			-- C compiler options to compile generated code (Client and Server folders)
		once
			Result := "/W0 /Ox /D %"_WIN32_DCOM%" /c /I..\include /I..\..\common\include /I"
			Result.append (get (Eiffel4))
			Result.append ("\bench\spec\windows\include /I")
			Result.append (get (Eiffel4))
			Result.append ("\library\com\include ")
		end

	Client_standard_c_compiler_options: STRING is 
			-- C compiler options to compile generated code (Common folders for client)
		once
			Result := "/W0 /Ox /D %"_WIN32_DCOM%" /c /I..\include /I..\..\client\include /I"
			Result.append (get (Eiffel4))
			Result.append ("\bench\spec\windows\include /I")
			Result.append (get (Eiffel4))
			Result.append ("\library\com\include ")
		end

	Server_standard_c_compiler_options: STRING is 
			-- C compiler options to compile generated code (Common folders for server)
		once
			Result := "/W0 /Ox /D %"_WIN32_DCOM%" /c /I..\include /I..\..\server\include /I"
			Result.append (get (Eiffel4))
			Result.append ("\bench\spec\windows\include /I")
			Result.append (get (Eiffel4))
			Result.append ("\library\com\include ")
		end

	Common_c_compiler_options: STRING is 
			-- C compiler options to compile Proxy/Stub
		once
			Result := "/ML /W0 /GD /Ox /D %"REGISTER_PROXY_DLL%" /D %"WIN32%" /D %"_WIN32_DCOM%" /YX /c /I..\include /I..\..\common\include /I"
			Result.append (get (Eiffel4))
			Result.append ("\bench\spec\windows\include /I")
			Result.append (get (Eiffel4))
			Result.append ("\library\com\include ")
		end

	Eiffel4: STRING is "EIFFEL4"
			-- Eiffel4 environmnent variable

	Common_idl_compiler_options: STRING is ""
			-- MIDL options

	Rpc_library: STRING is "%"kernel32.lib%" %"rpcndr.lib%" %"rpcns4.lib%" %"rpcrt4.lib%" %"uuid.lib%""
			-- RPC library to be linked with MIDL generated c files

end -- class WIZARD_COMPILER_ENVIRONMENT

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
