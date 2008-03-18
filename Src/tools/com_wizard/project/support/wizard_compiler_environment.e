indexing
	description: "Miscellaneous compiler options"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	Common_linker_options:STRING is " /DLL /RELEASE %"/INCREMENTAL:NO%""
			-- Linker options.

	Common_c_compiler_options: STRING is
			-- C compiler options to compile Proxy/Stub.
		once
			Result := "/MT /W0 /Ox /D %"REGISTER_PROXY_DLL%" /D %"WIN32%" /D %"_WIN32_DCOM%" /D %"_WIN32_WINNT=0x0500%" /c /I..\include /I..\..\common\include /I%""
			Result.append (eiffel_layout.install_path.string)
			Result.append ("\studio\spec\")
			Result.append (eiffel_layout.eiffel_platform)
			Result.append ("\include%" /I%"")
			Result.append (eiffel_layout.eiffel_library)
			Result.append ("\library\com\spec\windows\include%" ")
		end

	Common_idl_compiler_options: STRING is ""
			-- MIDL options.

	Rpc_library: STRING is "%"kernel32.lib%" %"rpcndr.lib%" %"rpcns4.lib%" %"rpcrt4.lib%" %"uuid.lib%" %"oleaut32.lib%"";
			-- RPC library to be linked with MIDL generated c files.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class WIZARD_COMPILER_ENVIRONMENT

