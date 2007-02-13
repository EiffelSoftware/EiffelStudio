indexing
	description: "Specialized configiration for Microsoft Platform/WindowsSDK's."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	WSDK_CONFIG

inherit
	MSCL_CONFIG
		redefine
			batch_file_arguments, batch_file_options
		end

	EIFFEL_LAYOUT

create
	make

feature {NONE} -- Access

	batch_file_name: STRING is
			-- Absolute path to an environment configuration batch script
		local
			l_layout: FINISH_FREEZING_EIFFEL_LAYOUT
		do
			l_layout ?= eiffel_layout
			check layout_not_void: l_layout /= Void end
			create Result.make (256)
			Result.append (l_layout.config_eif_path)
			Result.append ("\windows_sdk_v6.0.bat")
		end

	batch_file_arguments: STRING is
			-- Arguments for `batch_file_name' execution
		do
			create Result.make (10)
			Result.append ("%"" + install_path + "%"")
			Result.append (" /Release ")
			if use_32bit then
				Result.append ("/x86")
			else
				Result.append ("/x64")
			end
		end

	batch_file_options: STRING is
			-- Option to the COMSPEC DOS prompt.
		do
			Result := "/V:ON"
		end

	full_product_reg_path: STRING is
			-- Absolute product registry location
		do
			create Result.make (256)
			Result.append ("HKEY_LOCAL_MACHINE\SOFTWARE\")
			Result.append (product_reg_path)
		end

	install_path_value_name: STRING = "InstallationFolder"
			-- Key value name for install location

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end
