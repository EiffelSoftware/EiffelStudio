indexing
	description: "[
					Configuration settings, read from config file
					File content should look like:

					<?xml version="1.0"?>
					<general>
						<crash_on_error>False</crash_on_error>
						<log_level>1</log_level>
						<log_source_name>Eiffel CodeDom Provider</log_source_name>
						<log_server_name>localhost</log_server_name>
						<log_name>Application</log_name>
					</general>
					<compiler>
						<default_output_assembly>generated</default_output_assembly>
						<precompile></precompile>
					</compiler>
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_CONFIGURATION

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	ECDP_EVENT_LOG_LEVEL
		export
			{NONE} all
		end

create
	reload
	
feature {NONE} -- Initialization

	reload is
			-- Try reading settings from config file, use default values if
			-- config file is not found or reading fails.
		local
			l_retried: BOOLEAN
			l_xml_reader: XML_XML_TEXT_READER
			l_value_name, l_path: STRING
			l_key: REGISTRY_KEY
		do
			if not l_retried then
				l_key := feature {REGISTRY}.local_machine.open_sub_key ("Software\ISE\EiffelCodeDomProvider\Configs", False)
				if l_key = Void then
					(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_configs, [])
				else
					l_path ?= l_key.get_value (feature {SYSTEM_DLL_PROCESS}.get_current_process.process_name)
					if l_path = Void then
						(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_config, [feature {SYSTEM_DLL_PROCESS}.get_current_process.process_name])
						l_path ?= l_key.get_value (Void)
						if l_path = Void then
							(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Missing_default_config, [feature {SYSTEM_DLL_PROCESS}.get_current_process.process_name])
						end
					end
					if l_path /= Void then
						create l_xml_reader.make_from_url (l_path)
						from
						until
							not l_xml_reader.read					
						loop
							if l_xml_reader.node_type = feature {XML_XML_NODE_TYPE}.Element then
								l_value_name := l_xml_reader.name
							elseif l_xml_reader.node_type = feature {XML_XML_NODE_TYPE}.Text then
								config_values.force (l_xml_reader.value, l_value_name)
							end
						end
						l_xml_reader.close
					end
				end
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_retried := True
			retry
		end
	
feature -- Access

	crash_on_error: BOOLEAN is
			-- Should CodeDom stop on error?
			-- Useful for debugging
		do
			Result := config_values.item ("crash_on_error").to_boolean
		end

	log_level: INTEGER is
			-- Log level
			-- See class ECDP_EVENT_LOG_LEVEL for possible values
		do
			Result := config_values.item ("log_level").to_integer
		ensure
			valid_level: is_valid_log_level (Result)
		end

	log_source_name: STRING is
			-- Log source name
		do
			Result := config_values.item ("log_source_name")
		ensure
			non_void_log_source_name: Result /= Void
		end

	log_server_name: STRING is
			-- Log server name
		do
			Result := config_values.item ("log_server_name")
		ensure
			non_void_log_server_name: Result /= Void
		end
	
	log_name: STRING is
			-- Log name
		do
			Result := config_values.item ("log_name")
		ensure
			non_void_log_name: Result /= Void
		end

	default_output_assembly: STRING is
			-- Default output assembly
		do
			Result := config_values.item ("default_output_assembly")
		ensure
			non_void_default_output_assembly: Result /= Void
		end

	precompile: STRING is
			-- Precompile path if any
		do
			Result := config_values.item ("precompile")
		end

feature {NONE} -- Implementation

	config_values: HASH_TABLE [STRING, STRING] is
			-- Configuration values
		once
			create Result.make (10)
			Result.extend ("False", "crash_on_error")
			Result.extend ("1", "log_level")
			Result.extend ("Eiffel CodeDom Provider", "log_source_name")
			Result.extend ("localhost", "log_server_name")
			Result.extend ("Application", "log_name")
			Result.extend ("generated", "default_output_assembly")
		end

invariant
	has_log_source_name: log_source_name /= Void
	has_log_server_name: log_server_name /= Void
	has_log_name: log_name /= Void
	has_default_output_assembly: default_output_assembly /= Void

end -- class ECDP_SHARED_CONFIG

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