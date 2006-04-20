indexing
	description: "Platform specific constants."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	PLATFORM_CONSTANTS

inherit
	OPERATING_ENVIRONMENT

feature -- Access

	Driver: STRING is
			-- Name of `driver' executable used to execute melted code.
		once
			if is_windows then
				create Result.make (15)
				Result.append ((create {EIFFEL_ENV}).Eiffel_c_compiler)
				Result.append ("\driver.exe")
			elseif is_vms then
				Result := "driver.exe"
			else
				Result := "driver"
			end
		end

	Executable_suffix: STRING is
			-- Platform specific executable extension.
		once
			if not is_unix then
				Result := "exe"
			else
				Result := ""
			end
		end

	Finish_freezing_script: STRING is 
			-- Name of post-eiffel compilation processing to launch
			-- C code.
		once
			if is_windows then
				Result := "finish_freezing.exe"
			else
				Result := "finish_freezing"
			end
		end

	Preobj: STRING is
			-- Name of C library used in precompiled library.
		once
			if is_windows then
				Result := "precomp.lib"
			elseif is_unix then
				Result := "preobj.o"
			else
				Result := "preobj.olb"
			end
		end

	is_unix: BOOLEAN is
			-- Is it a Unix platform?
		once
			Result := not (is_vms or is_windows)
		end

	is_vms: BOOLEAN is
			-- Is the platform VMS?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_VMS"
		end

	is_windows: BOOLEAN is
			-- Is the platform a windows platform?
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"EIF_IS_WINDOWS"
		end

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

end -- class PLATFORM_CONSTANTS
