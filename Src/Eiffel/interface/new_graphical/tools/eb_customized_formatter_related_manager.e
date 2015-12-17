note
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

	has_error: BOOLEAN
			-- Did any error occur?
		do
			Result := last_error /= Void
		end

feature -- Storage

	load (a_error_agent: PROCEDURE)
			-- Load information.
			-- `a_error_agent' is the agent invoked when error occurs during loading.
		deferred
		ensure
			loaded: is_loaded
		end

	store
			-- Store information.
		deferred
		end

feature -- Setting

	set_is_loaded (b: BOOLEAN)
			-- Set `is_loaded' with `b'.
		do
			is_loaded := b
		ensure
			is_loaded_set: is_loaded = b
		end

	clear_last_error
			-- Clear `last_error'.
		do
			last_error := Void
		ensure
			not_has_error: not has_error
		end

	set_is_file_readable (b: BOOLEAN)
			-- Set `is_file_readable' with `b'.
		do
			is_file_readable := b
		ensure
			is_file_readable_set: is_file_readable = b
		end

	set_last_error (a_error: like last_error)
			-- Set `last_error' with `a_error'.
		do
			last_error := a_error
		ensure
			last_error_set: last_error = a_error
		end

feature{NONE} -- Implementation

	store_in_file (a_descriptors: LIST [G]; a_root_name: STRING; a_xml_generator: FUNCTION [TUPLE [a_item: G; a_parent: XML_COMPOSITE], XML_ELEMENT]; a_path: PATH; a_file_name: STRING)
			-- Store `a_descritpors' in formatter descriptor `a_file_name' in `a_path'.
			-- If `a_descriptors' doesn't contain any formatter descriptor but formatter file in `a_path exists, remove that file.
			-- `a_error_agent' will be invoked when error occurs.
		require
			a_descriptors_attached: a_descriptors /= Void
			a_root_name_attached: a_root_name /= Void
			a_path_valid: a_path /= Void and then not a_path.is_empty
			a_file_name_valid: a_file_name /= Void and then not a_file_name.is_empty
			a_xml_generator_attached: a_xml_generator /= Void
		local
			l_file: RAW_FILE
			l_retried: BOOLEAN
			l_file_name: PATH
			u: GOBO_FILE_UTILITIES
		do
			if not l_retried then
				l_file_name := a_path.extended (a_file_name)
				if a_descriptors.is_empty then
					create l_file.make_with_path (l_file_name)
					if l_file.exists then
						l_file.delete
					end
				else
					u.create_directory_path (a_path)
					store_xml (xml_document_for_items (a_root_name, a_descriptors, a_xml_generator), l_file_name, agent set_last_error (create {EB_METRIC_ERROR}.make (metric_names.err_file_not_writable (l_file_name.name))))
				end
			end
		rescue
			l_retried := True
			retry
		end

feature{NONE} -- Implementation/Data

	formatter_file_path (a_base_path: PATH): PATH
			-- Path for formatter file based on `a_base_path'
		require
			a_base_path_attached: a_base_path /= Void
		do
			Result := a_base_path.extended ("formatters")
		ensure
			result_attached: Result /= Void
		end

	global_file_path: PATH
			-- Path to store global formatter related file
		do
			Result := formatter_file_path (eiffel_layout.hidden_files_path)
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
