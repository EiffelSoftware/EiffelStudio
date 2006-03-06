indexing
	description: "Build EAC upon installation and deletes it upon uninstallation."
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

end -- Class CACHE_BROWSER_INSTALLER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------