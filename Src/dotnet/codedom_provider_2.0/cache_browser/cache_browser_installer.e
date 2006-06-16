indexing
	description: "Build EAC upon installation and deletes it upon uninstallation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

	metadata: create {SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE}.make (True) end

class
	CACHE_BROWSER_INSTALLER

inherit
	CONFIG_INSTALL_INSTALLER
		redefine
			install,
			uninstall,
			commit,
			rollback
		end

	CODE_DOM_PATH
		export
			{NONE} all
		end

feature -- Basic Operations

	install (saved_state: IDICTIONARY) is
			-- Redefine `install' feature.
		local
			l_cache_manager: CACHE_MANAGER
			l_framework_path: SYSTEM_STRING
			l_framework_version: SYSTEM_STRING
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state);
			l_framework_path := {RUNTIME_ENVIRONMENT}.get_runtime_directory
			l_framework_version := {RUNTIME_ENVIRONMENT}.get_system_version
			if Default_metadata_cache_path /= Void and l_framework_path /= Void and l_framework_version /= Void then
				create l_cache_manager.make_with_path (Default_metadata_cache_path)
				l_cache_manager.consume_assembly_from_path (l_framework_path + "System.Web.Services.dll")
				l_cache_manager.consume_assembly_from_path (l_framework_path + "System.Windows.Forms.dll")
				l_cache_manager.consume_assembly_from_path (l_framework_path + "System.Design.dll")
				if not l_framework_version.equals (("v1.0.3705").to_cil) then
					l_cache_manager.consume_assembly_from_path (l_framework_path + "System.Web.Mobile.dll")
				end
			end
		end
	
	uninstall (saved_state: IDICTIONARY) is
			-- Redefine `install' feature.
		local
			l_directory: DIRECTORY
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
			if Default_metadata_cache_path /= Void then
				create l_directory.make (Default_metadata_cache_path)
				if l_directory.exists then
					l_directory.recursive_delete
				end
			end
		end
	
	commit (saved_state: IDICTIONARY) is
			-- Redefine `commit' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
		end
	
	rollback (saved_state: IDICTIONARY) is
			-- Redefine `rollback' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
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
end -- Class CACHE_BROWSER_INSTALLER

