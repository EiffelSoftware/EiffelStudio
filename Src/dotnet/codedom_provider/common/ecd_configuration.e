indexing
	description: "[
					Configuration settings, read from config file
					File content should look like:

					<?xml version="1.0"?>
					<configuration>
						<general>
							<crash_on_error>False</crash_on_error>
							<log_level>1</log_level>
							<log_source_name>Eiffel CodeDom Provider</log_source_name>
							<log_server_name>localhost</log_server_name>
							<log_name>Eiffel CodeDom Provider</log_name>
						</general>
						<compiler>
							<default_root_class>ANY</default_root_class>
							<precompile></precompile>
						</compiler>
					</configuration>
					]"
	date: "$Date$"
	revision: "$Revision$"
	note: "Class ECDM_CONFIGURATION from the Eiffel Codedom Provider Manager application%
			%inherits from this class. Any changes made to the schema of the configuration%
			%file needs to be propagated to ECDM_CONFIGURATION."

class
	ECD_CONFIGURATION

inherit
	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	ECD_EVENT_LOG_LEVEL
		export
			{NONE} all
		end

	ECD_SHARED_EVENT_MANAGER
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
			l_path: STRING
		do
			l_path := (create {ECD_REGISTRY_SETTINGS}).current_process_config_path
			if l_path /= Void and then (create {RAW_FILE}.make (l_path)).exists then
				load (l_path)
			end
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
			-- See class ECD_EVENT_LOG_LEVEL for possible values
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

	precompile: STRING is
			-- Precompile path if any
		do
			Result := config_values.item ("precompile")
		end

	default_root_class: STRING is
			-- Default root class name
		do
			Result := config_values.item ("default_root_class")
		end

feature -- Basic Operations

	load (a_config_file: STRING) is
			-- Load configuration file `a_config_file'.
		require
			non_void_config_file: a_config_file /= Void
			valid_config_file: (create {RAW_FILE}.make (a_config_file)).exists
		local
			l_xml_reader: XML_XML_TEXT_READER
			l_value_name: STRING
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_xml_reader.make_from_url (a_config_file)
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
		rescue
			Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	config_values: HASH_TABLE [STRING, STRING] is
			-- Configuration values
		do
			if internal_config_values = Void then
				initialize_default_values
				reload
			end
			Result := internal_config_values
		end

	initialize_default_values is
			-- Initialize fields to default values.
		do
			create internal_config_values.make (10)
			internal_config_values.extend ("False", "crash_on_error")
			internal_config_values.extend ("1", "log_level")
			internal_config_values.extend ("Application", "log_source_name")
			internal_config_values.extend ("localhost", "log_server_name")
			internal_config_values.extend ("Application", "log_name")
			internal_config_values.extend ("generated", "default_system_name")
			internal_config_values.extend ("NONE", "default_root_class")
		end
		
	internal_config_values: HASH_TABLE [STRING, STRING]
			-- Internal object for once per object implementation

invariant
	has_log_source_name: log_source_name /= Void
	has_log_server_name: log_server_name /= Void
	has_log_name: log_name /= Void

end -- class ECD_SHARED_CONFIG

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