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
			l_cache_writer: CACHE_WRITER
			l_framework_path: SYSTEM_STRING
			l_framework_version: SYSTEM_STRING
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state);
			l_framework_path := feature {RUNTIME_ENVIRONMENT}.get_runtime_directory
			l_framework_version := feature {RUNTIME_ENVIRONMENT}.get_system_version
			if Default_metadata_cache_path /= Void and l_framework_path /= Void and l_framework_version /= Void then
				l_cache_writer := (create {CACHE_MANAGER}.make_with_path (Default_metadata_cache_path, l_framework_version)).cache_writer
				from
					assemblies.start
				until
					assemblies.after
				loop
					l_cache_writer.add_assembly (l_framework_path + assemblies.item)
					assemblies.forth
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

feature {NONE} -- Implementation

	assemblies: LIST [STRING] is
			-- File names of assemblies that need to be consumed
		once
			create {ARRAYED_LIST [STRING]} Result.make (10)
			Result.extend ("mscorlib.dll")
			Result.extend ("system.dll")
			Result.extend ("system.drawing.dll")
			Result.extend ("system.xml.dll")
			Result.extend ("system.web.dll")
			Result.extend ("system.web.regularexpressions.dll")
			Result.extend ("system.web.services.dll")
			Result.extend ("system.enterpriseservices.dll")
			Result.extend ("system.data.dll")
		end

end -- Class CACHE_BROWSER_INSTALLER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------