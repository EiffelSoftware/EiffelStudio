indexing
	description: "Implement all features to install and uninstall the Eiffel CodeDom Provider."
	date: "$Date$"
	revision: "$Revision$"

	metadata: create {SYSTEM_DLL_RUN_INSTALLER_ATTRIBUTE}.make (True) end

class
	ECDP_INSTALLER

inherit
	CONFIG_INSTALL_INSTALLER
		undefine
			to_string,
			equals,
			finalize,
			get_hash_code
		redefine
			install,
			uninstall,
			commit,
			rollback
		end

	ANY
	
feature {SYSTEM_OBJECT} -- Redefined features.

	install (saved_state: IDICTIONARY) is
			-- Redefine `install' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state);
			add_entry
		end
	
	uninstall (saved_state: IDICTIONARY) is
			-- Redefine `install' feature.
		do
			Precursor {CONFIG_INSTALL_INSTALLER}(saved_state)
			remove_entry
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
	
	add_entry is
			-- Add Eiffel CodeDom provider to list of CodeDom providers
			-- in configuration file "machine.config"
		local
			l_compilers_node, l_node: XML_XML_NODE
			l_res: SYSTEM_OBJECT
		do
			remove_entry
			l_compilers_node := compilers_node
			l_node := l_compilers_node.first_child.clone
			l_node.attributes.item (0).set_value (Eiffel_language_keyword)
			l_node.attributes.item (1).set_value (Eiffel_extension)
			l_node.attributes.item (2).set_value (Eiffel_codedom_provider_fully_qualified_name)
			l_res := l_compilers_node.append_child (l_node)
			machine_config.save_string (Machine_config_path)
		end
		
	remove_entry is
			-- Remove Eiffel CodeDom provider from list of CodeDom providers
			-- in configuration file "machine.config" if present
			-- otherwise do nothing.
		local
			l_compilers_node: XML_XML_NODE
			l_compilers: XML_XML_NODE_LIST
			i, l_count: INTEGER
			l_res: SYSTEM_OBJECT
			l_found: BOOLEAN
		do
			l_compilers_node := compilers_node
			if l_compilers_node /= Void then
				l_compilers := l_compilers_node.child_nodes
				from
					i := 0
					l_count := l_compilers.count
				until
					i >= l_count or l_found
				loop
 					if l_compilers.item (i).attributes.item (0).value.equals (Eiffel_language_keyword.to_cil) then
						l_res := l_compilers_node.remove_child (l_compilers.item (i))
						l_count := l_count - 1
						l_found := True
					else
						i := i + 1
					end
				end
			end
			machine_config.save_string (Machine_config_path)
		end
		
	compilers_node: XML_XML_NODE is
			-- CodeDom compilers node in config file "machine.config"
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				create machine_config.make
				machine_config.load_string (Machine_config_path)
				Result := machine_config.get_elements_by_tag_name ("compilers").item (0)
			end
		ensure
			non_void_machine_config: machine_config /= Void
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_retried := True
			retry
		end

feature {NONE} -- Implementation
	
	machine_config: SYSTEM_DLL_CONFIG_XML_DOCUMENT
			-- Machine configuration file content

	Machine_config_path: STRING is
			-- Path to "machine.config" configuration file
		once
			Result := feature {RUNTIME_ENVIRONMENT}.get_runtime_directory 
			Result.append ("\CONFIG\machine.config")
		end

feature {NONE} -- Eiffel CodeDOM assembly parameters.

	Eiffel_language_keyword: STRING is "Eiffel"
			-- Keyword that distinguish an Eiffel asp page to C# page.

	Eiffel_extension: STRING is ".e"
			-- Eiffel files extension.

	Eiffel_codedom_provider_fully_qualified_name: STRING is
			-- Eiffel CodeDom provider assembly fully qualified name
		once
			Result := (create {ECDP_PROVIDER}).get_type.assembly_qualified_name
		ensure
			non_void_Eiffel_codedom_provider_fully_qualified_name: Result /= Void
			not_empty_Eiffel_codedom_provider_fully_qualified_name: not Result.is_empty
		end

end -- Class ECDP_INSTALLER

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