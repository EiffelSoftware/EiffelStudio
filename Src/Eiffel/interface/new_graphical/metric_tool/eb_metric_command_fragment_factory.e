note
	description: "[
			Factory to create text replacement fragments for placeholders 
			such as $file_name in metric external command criterion"
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_COMMAND_FRAGMENT_FACTORY

inherit
	EB_TEXT_FRAGMENT_FACTORY

feature -- Access

	item: QL_ITEM
			-- Query language item currently worked on

feature -- Setting

	set_item (a_item: like item)
			-- Set `item' with `a_item'.
		require
			a_item_attached: a_item /= Void
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

feature -- Access

	new_file_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$file_name" fragment			
		do
			create {EB_AGENT_BASED_TEXT_FRAGMENT} Result.make (a_scanner.text, agent path (item, ?), agent is_true)
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_location (a_scanner.position)
		end

	new_file (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$file" tool buffer selected fragment
		do
			create {EB_AGENT_BASED_TEXT_FRAGMENT} Result.make (a_scanner.text, agent file (item, ?), agent is_true)
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_location (a_scanner.position)
		end

	new_path (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$path" tool buffer selected fragment
		do
			Result := new_file_name (a_scanner)
		end

	new_directory_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$directory_name" fragment
		do
			create {EB_AGENT_BASED_TEXT_FRAGMENT} Result.make (a_scanner.text, agent directory_name (item, ?), agent is_true)
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_location (a_scanner.position)
		end

	new_group_directory (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$group_path" fragment
		do
			create {EB_AGENT_BASED_TEXT_FRAGMENT} Result.make (a_scanner.text, agent group_directory (item, ?), agent is_true)
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_location (a_scanner.position)
		end

	new_class_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$class_name" fragment
		do
			create {EB_AGENT_BASED_TEXT_FRAGMENT} Result.make (a_scanner.text, agent class_name (item, ?), agent is_true)
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_location (a_scanner.position)
		end

	new_line (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$line" fragment
		do
			Result := basic_text_fragment (a_scanner)
		end

	new_class_buffer (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "{CLASS}" buffer fragment
		do
			Result := basic_text_fragment (a_scanner)
		end

	new_class_buffer_selected (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "@{CLASS}" class buffer selected fragment
		do
			Result := basic_text_fragment (a_scanner)
		end

	new_feature_buffer (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "{CLASS}.feature" buffer fragment
		do
			Result := basic_text_fragment (a_scanner)
		end

	new_tool_buffer (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "[Tool name]" tool buffer fragment
		do
			Result := basic_text_fragment (a_scanner)
		end

	new_tool_buffer_selected (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "@[Tool name]" tool buffer selected fragment
		do
			Result := basic_text_fragment (a_scanner)
		end

	new_group_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "$group_name" fragment
		do
			create {EB_AGENT_BASED_TEXT_FRAGMENT} Result.make (a_scanner.text, agent group_name (item, ?), agent is_true)
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_location (a_scanner.position)
		end

feature{NONE} -- Implementation

	path (a_item: QL_ITEM; a_text: STRING_32): STRING_32
			-- File name of `a_item'
		require
			a_item_attached: a_item /= Void
			a_text_attached: a_text /= Void
		local
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_line: QL_LINE
			l_group: QL_GROUP
		do
			if a_item.is_code_structure then
				l_code_item ?= a_item
				Result := l_code_item.class_i.file_name.name
			elseif a_item.is_line then
				l_line ?= a_item
				l_code_item ?= l_line.parent
				if l_code_item /= Void then
					Result := l_code_item.class_i.file_name.name
				end
			elseif a_item.is_group then
				l_group ?= a_item
				Result := l_group.group.location.evaluated_path.name
			else
				Result := a_text.twin
			end
		end

	file (a_item: QL_ITEM; a_text: STRING_32): STRING_32
			-- File name of `a_item'
		require
			a_item_attached: a_item /= Void
			a_text_attached: a_text /= Void
		local
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_line: QL_LINE
			l_group: QL_GROUP
		do
			if a_item.is_code_structure then
				l_code_item ?= a_item
				Result := l_code_item.class_i.base_name.twin
			elseif a_item.is_line then
				l_line ?= a_item
				l_code_item ?= l_line.parent
				if l_code_item /= Void then
					Result := l_code_item.class_i.base_name.twin
				end
			elseif a_item.is_group then
				l_group ?= a_item
				Result := l_group.group.location.evaluated_file.twin
			else
				Result := a_text.twin
			end
		end

	class_name (a_item: QL_ITEM; a_text: STRING_32): STRING_32
			-- Class name of `a_item' if `a_item' is a code structure item,
			-- otherwise return a copy of `a_text'.
		require
			a_item_attached: a_item /= Void
			a_text_attached: a_text /= Void
		do
			if a_item.is_code_structure then
				Result := a_item.name
			else
				Result := a_text.twin
			end
		end

	group_directory (a_item: QL_ITEM; a_text: STRING_32): STRING_32
			-- Directory name of `a_item'
		require
			a_item_attached: a_item /= Void
			a_text_attached: a_text /= Void
		local
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_line: QL_LINE
			l_group: QL_GROUP
			l_conf_group: CONF_GROUP
		do
			if a_item.is_code_structure then
				l_code_item ?= a_item
				l_conf_group := l_code_item.class_i.group
			elseif a_item.is_line then
				l_line ?= a_item
				l_code_item ?= l_line.parent
				if l_code_item /= Void then
					l_conf_group := l_code_item.class_i.group
				end
			elseif a_item.is_group then
				l_group ?= a_item
				l_conf_group := l_group.group
			end
			if l_conf_group /= Void then
				Result := l_conf_group.location.evaluated_directory.name
			else
				Result := a_text.twin
			end
		end

	group_name (a_item: QL_ITEM; a_text: STRING_32): STRING_32
			-- Group name of `a_item'
		require
			a_item_attached: a_item /= Void
			a_text_attached: a_text /= Void
		local
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_line: QL_LINE
			l_group: QL_GROUP
			l_conf_group: CONF_GROUP
		do
			if a_item.is_code_structure then
				l_code_item ?= a_item
				l_conf_group := l_code_item.class_i.group
			elseif a_item.is_line then
				l_line ?= a_item
				l_code_item ?= l_line.parent
				if l_code_item /= Void then
					l_conf_group := l_code_item.class_i.group
				end
			elseif a_item.is_group then
				l_group ?= a_item
				l_conf_group := l_group.group
			end
			if l_conf_group /= Void then
				Result := l_conf_group.name.twin
			else
				Result := a_text.twin
			end
		end

	directory_name (a_item: QL_ITEM; a_text: STRING_32): STRING_32
			-- Directory name of `a_item'
		require
			a_item_attached: a_item /= Void
			a_text_attached: a_text /= Void
		local
			l_code_item: QL_CODE_STRUCTURE_ITEM
			l_line: QL_LINE
			l_group: QL_GROUP
			l_conf_class: CONF_CLASS
		do
			if a_item.is_code_structure then
				l_code_item ?= a_item
				l_conf_class := l_code_item.class_i.config_class
				Result := l_conf_class.group.location.build_path (l_conf_class.path, "").name
			elseif a_item.is_line then
				l_line ?= a_item
				l_code_item ?= l_line.parent
				if l_code_item /= Void then
					l_conf_class := l_code_item.class_i.config_class
					Result := l_conf_class.group.location.build_path (l_conf_class.path, "").name
				end
			elseif a_item.is_group then
				l_group ?= a_item
				Result := l_group.group.location.evaluated_directory.name
			else
				Result := a_text.twin
			end
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
