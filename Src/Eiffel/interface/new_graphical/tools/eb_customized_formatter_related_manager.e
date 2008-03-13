indexing
	description: "Manager for customized formatter/tool"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CUSTOMIZED_FORMATTER_RELATED_MANAGER [G]

inherit
	EB_XML_DOCUMENT_HELPER [G]

	SHARED_WORKBENCH

	EB_CUSTOMIZED_FORMATTER_XML_CONSTANTS

--inherit {NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	last_error: EB_METRIC_ERROR
			-- Last recorded error

feature -- Status report

	is_loaded: BOOLEAN
			-- has information been loaded?

	is_file_readable: BOOLEAN
			-- Is file readable when the last time `parse_file' is called?

	has_error: BOOLEAN is
			-- Did any error occur?
		do
			Result := last_error /= Void
		end

feature -- Storage

	load (a_error_agent: PROCEDURE [ANY, TUPLE]) is
			-- Load information.
			-- `a_error_agent' is the agent invoked when error occurs during loading.
		deferred
		ensure
			loaded: is_loaded
		end

	store is
			-- Store information.
		deferred
		end

feature -- Setting

	set_is_loaded (b: BOOLEAN) is
			-- Set `is_loaded' with `b'.
		do
			is_loaded := b
		ensure
			is_loaded_set: is_loaded = b
		end

	clear_last_error is
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			not_has_error: not has_error
		end

	set_is_file_readable (b: BOOLEAN) is
			-- Set `is_file_readable' with `b'.
		do
			is_file_readable := b
		ensure
			is_file_readable_set: is_file_readable = b
		end

	set_last_error (a_error: like last_error) is
			-- Set `last_error' with `a_error'.
		do
			last_error := a_error
		ensure
			last_error_set: last_error = a_error
		end

feature{NONE} -- Implementation

	create_formatter_file_dir (a_path: FILE_NAME) is
			-- Create dir `a_path' if not exists.
		require
			a_path_attached: a_path /= Void
		local
			l_dir: DIRECTORY
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_dir.make (a_path)
				if not l_dir.exists then
					l_dir.create_dir
				end
			end
		rescue
			l_retried := True
			retry
		end

	store_in_file (a_descriptors: LIST [G]; a_root_name: STRING; a_xml_generator: FUNCTION [ANY, TUPLE [a_item: G; a_parent: XM_COMPOSITE], XM_ELEMENT]; a_path: FILE_NAME; a_file_name: STRING) is
			-- Store `a_descritpors' in formatter descriptor `a_file_name' in `a_path'.
			-- If `a_descriptors' doesn't contain any formatter descriptor but formatter file in `a_path exists, remove that file.
			-- `a_error_agent' will be invoked when error occurs.
		require
			a_descriptors_attached: a_descriptors /= Void
			a_descriptors_valid: not a_descriptors.has (Void)
			a_root_name_attached: a_root_name /= Void
			a_path_valid: a_path /= Void and then not a_path.is_empty
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_xml_generator_attached: a_xml_generator /= Void
		local
			l_file: RAW_FILE
			l_retried: BOOLEAN
			l_file_name: STRING
		do
			if not l_retried then
				l_file_name := absolute_file_name (a_path, a_file_name)
				if a_descriptors.is_empty then
					create l_file.make (l_file_name)
					if l_file.exists then
						l_file.delete
					end
				else
					create_formatter_file_dir (a_path)
					store_xml (xml_document_for_items (a_root_name, a_descriptors, a_xml_generator), l_file_name, agent set_last_error (create {EB_METRIC_ERROR}.make (metric_names.err_file_not_writable (l_file_name))))
				end
			end
		rescue
			l_retried := True
			retry
		end

feature{NONE} -- Implementation/Data

	formatter_file_path (a_base_path: STRING): FILE_NAME is
			-- Path for formatter file based on `a_base_path'
		require
			a_base_path_attached: a_base_path /= Void
		do
			create Result.make_from_string (a_base_path)
			Result.extend ("formatters")
		ensure
			result_attached: Result /= Void
		end

	global_file_path: FILE_NAME is
			-- Path to store global formatter related file
		do
			Result := formatter_file_path (eiffel_layout.user_settings_path)
		ensure
			result_attached: Result /= Void
		end

end
