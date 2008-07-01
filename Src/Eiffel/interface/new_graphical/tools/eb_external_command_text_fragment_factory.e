indexing
	description: "Factory to create text replacement fragments for external command"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXTERNAL_COMMAND_TEXT_FRAGMENT_FACTORY

inherit
	EB_TEXT_FRAGMENT_FACTORY

feature -- Access

	new_file_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$file_name" fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_path_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_data (a_scanner.t_file_name)
		end

	new_file (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$file" tool buffer selected fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_file_name_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_data (a_scanner.t_file)
		end

	new_path (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$path" tool buffer selected fragment
		do
			Result := new_file_name (a_scanner)
			Result.set_data (a_scanner.t_path)
		end

	new_directory_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$directory_name" fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_directory_name_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_data (a_scanner.t_directory_name)
		end

	new_class_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$class_name" fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_class_name_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent upper_case_text_normalizer)
			Result.set_data (a_scanner.t_class_name)
		end

	new_line (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$line" fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_line_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_data (a_scanner.t_line)
		end

	new_class_buffer (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "{CLASS}" buffer fragment
		local
			l_class: CLASS_I
		do
			l_class := class_with_name (class_name_text_normalizer (a_scanner.text))
			if l_class /= Void then
				create {EB_BUFFER_BASED_TEXT_FRAGMENT}Result.make (
					a_scanner.text,
					agent new_buffer_file_name,
					agent is_class_buffer_name_valid,
					create {EB_BUFFER}.make (file_content (l_class.file_name), temporary_file_name (l_class.base_name))
				)
				Result.set_location (a_scanner.position)
			end
			if Result = Void then
				Result := basic_text_fragment (a_scanner)
			end
			Result.set_normalized_text_function (agent class_name_text_normalizer)
			Result.set_data (a_scanner.t_class_buffer)
		end

	new_group_directory (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT
			-- New "{CLASS}" buffer fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_group_directory_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_data (a_scanner.t_group_directory)
		end

	new_class_buffer_selected (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "@{CLASS}" class buffer selected fragment
		local
			l_editor: EB_SMART_EDITOR
			l_fake_editor: EB_FAKE_SMART_EDITOR
			l_selection: STRING_32
			l_class_name: STRING
			l_class_i: CLASS_I
		do
			l_class_name := class_selected_text_normalizer (a_scanner.text)
			l_class_i := class_with_name (l_class_name)
			if l_class_i /= Void then
				l_editor := editor_for_class (l_class_i)
				if l_editor /= Void then
					l_fake_editor ?= l_editor
					if l_fake_editor /= Void then
						l_editor := Void
					end
				end
				if l_editor /= Void then
					if l_editor.has_selection then
						l_selection := l_editor.wide_string_selection
					else
						l_selection := ""
					end
					create {EB_BUFFER_BASED_TEXT_FRAGMENT}Result.make (
						a_scanner.text,
						agent new_buffer_file_name,
						agent is_class_buffer_name_valid,
						create {EB_BUFFER}.make (l_selection, temporary_file_name (l_class_name + ".sel"))
					)
					Result.set_location (a_scanner.position)
				end
			end
			if Result = Void then
				Result := basic_text_fragment (a_scanner)
			end
			Result.set_normalized_text_function (agent class_selected_text_normalizer)
			Result.set_data (a_scanner.t_class_buffer_selected)
		end

	new_feature_buffer (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "{CLASS}.feature" buffer fragment
		local
			l_class_feature_name: STRING
			l_class_name: STRING
			l_feature_name: STRING
			l_class_i: CLASS_I
			l_dot_index: INTEGER
			l_class_c: CLASS_C
			l_e_feature: E_FEATURE
			l_feature_body_text: STRING
		do
				-- Separate class name and feature name from form "CLASS_NAME.feature_name"
			l_class_feature_name := class_feature_text_normalizer (a_scanner.text)
			l_dot_index := l_class_feature_name.index_of ('.', 1)
			l_class_name := l_class_feature_name.substring (1, l_dot_index - 1)
			l_feature_name := l_class_feature_name.substring (l_dot_index + 1, l_class_feature_name.count)

				-- Get compiled class and feature representation.
			l_class_i := class_with_name (l_class_name)
			if l_class_i /= Void and then l_class_i.is_compiled then
				l_class_c := l_class_i.compiled_class
				l_e_feature := l_class_c.feature_with_name (l_feature_name)
				if l_e_feature /= Void then
					if l_e_feature.written_class.class_id /= l_class_c.class_id then
						l_class_c := l_e_feature.written_class
					end
					l_feature_body_text := l_e_feature.ast.text (match_list_server.item (l_class_c.class_id))
					if l_feature_body_text /= Void then
						l_feature_body_text.replace_substring_all ("%R%N", "%N")
						create {EB_BUFFER_BASED_TEXT_FRAGMENT}Result.make (
							a_scanner.text,
							agent new_buffer_file_name,
							agent is_feature_buffer_name_valid,
							create {EB_BUFFER}.make (
								l_feature_body_text,
								temporary_file_name (l_class_name + "." + l_feature_name)
							)
						)
					end
					Result.set_location (a_scanner.position)
				end
			end
			if Result = Void then
				Result := basic_text_fragment (a_scanner)
			end
			Result.set_normalized_text_function (agent class_feature_text_normalizer)
			Result.set_data (a_scanner.t_feature_buffer)
		end

	new_tool_buffer (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "[Tool name]" tool buffer fragment
		do
			Result := basic_text_fragment (a_scanner)
			Result.set_data (a_scanner.t_tool_buffer)
		end

	new_tool_buffer_selected (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "@[Tool name]" tool buffer selected fragment
		do
			Result := basic_text_fragment (a_scanner)
			Result.set_data (a_scanner.t_tool_buffer_selected)
		end

	class_with_name (a_text: STRING): CLASS_I is
			-- Class with `a_text' as name
			-- Void if no class found.
		require
			a_text_attached: a_text /= Void
		local
			l_classes: LIST [CLASS_I]
		do
			if workbench.system_defined then
				l_classes := universe.classes_with_name (a_text)
				if not l_classes.is_empty then
					Result := l_classes.first
				end
			end
		end

	new_group_name (a_scanner: EB_COMMAND_SCANNER_SKELETON): EB_TEXT_FRAGMENT is
			-- New "$group_name" fragment
		local
			l_fragment: EB_AGENT_BASED_TEXT_FRAGMENT
		do
			create l_fragment.make (a_scanner.text, agent new_group_name_replacement, agent is_true)
			l_fragment.set_location (a_scanner.position)
			Result := l_fragment
			Result.set_normalized_text_function (agent lower_case_text_normalizer)
			Result.set_data (a_scanner.t_group_directory)
		end

feature{NONE} -- Implementation

	is_class_buffer_name_valid (a_class_buffer_name: STRING): BOOLEAN is
			-- Is `a_class_buffer_name' valid?
		require
			a_class_buffer_name_attached: a_class_buffer_name /= Void
		do
			Result := True
		end

	is_feature_buffer_name_valid (a_feature_name: STRING): BOOLEAN is
			-- Is `a_feature_name' valid?
		require
			a_feature_name_attached: a_feature_name /= Void
		do
			Result := True
		end

	new_path_replacement (a_text: STRING): STRING is
			-- New path for `a_text'
			-- Return the file name (with path) of the currently focused class in editor,
			-- if there is no such class, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			l_class_i: CLASS_I
		do
			l_class_i := class_i_from_editor
			if l_class_i /= Void then
				Result := l_class_i.file_name.twin
			else
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	new_file_name_replacement (a_text: STRING): STRING is
			-- New file name  (only the file name part) replacement for `a_text'
			-- Return the file name (with path) of the currently focused class in editor,
			-- if there is no such class, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			l_class_i: CLASS_I
		do
			l_class_i := class_i_from_editor
			if l_class_i /= Void then
				Result := l_class_i.base_name.twin
			else
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	class_i_from_editor: CLASS_I is
			-- CLASS_I from last focused editor
		local
			cv_cst: CLASSI_STONE
			dev: EB_DEVELOPMENT_WINDOW
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				cv_cst ?= dev.stone
				if cv_cst /= Void then
					Result := cv_cst.class_i
				end
			end
		end

	new_directory_name_replacement (a_text: STRING): STRING is
			-- New directory name replacement for `a_text'
			-- Return the directory name of the currently focused class in editor,
			-- if there is no such class, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			cv_cst: CLASSI_STONE
			dev: EB_DEVELOPMENT_WINDOW
			l_path: STRING
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				cv_cst ?= dev.stone
				if cv_cst /= Void then
					Result := cv_cst.class_i.group.location.evaluated_directory.twin
					l_path := cv_cst.class_i.config_class.path.twin
					l_path.replace_substring_all ("/", operating_environment.directory_separator.out)
					Result.append (l_path)
				end
			end
			if Result = Void then
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	new_group_directory_replacement (a_text: STRING): STRING is
			-- New group path replacement for `a_text'
			-- Return the path of the group where the currently focused class in editor is defined,
			-- if there is no such class, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			l_group: CONF_GROUP
		do
			l_group := group_from_current_class
			if l_group /= Void then
				Result := l_group.location.evaluated_directory.twin
			end
			if Result = Void then
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	new_group_name_replacement (a_text: STRING): STRING is
			-- New group name replacement for `a_text'
			-- Return the path of the group where the currently focused class in editor is defined,
			-- if there is no such class, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			l_group: CONF_GROUP
		do
			l_group := group_from_current_class
			if l_group /= Void then
				Result := l_group.name.twin
			end
			if Result = Void then
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	group_from_current_class: CONF_GROUP is
			-- Group from current class in editor
			-- Void if no class is found.
		local
			cv_cst: CLASSI_STONE
			dev: EB_DEVELOPMENT_WINDOW
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				cv_cst ?= dev.stone
				if cv_cst /= Void then
					Result := cv_cst.class_i.group
				end
			end
		end

	new_class_name_replacement (a_text: STRING): STRING is
			-- New class name replacement for `a_text'
			-- Return name of the currently focused class in editor,
			-- If there is no such class, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			dev: EB_DEVELOPMENT_WINDOW
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				Result := dev.class_name
				if Result /= Void and then Result.is_empty then
					Result := Void
				end
			end
			if Result = Void then
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	new_line_replacement (a_text: STRING): STRING is
			-- New line replacement for `a_text'
			-- Return the line number of the cursor in the currently focused editor
			-- If no such line number, return a copy of `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			dev: EB_DEVELOPMENT_WINDOW
			l_text_area: EB_SMART_EDITOR
		do
			dev := Window_manager.last_focused_development_window
			if dev /= Void then
				l_text_area := dev.editors_manager.current_editor
				if l_text_area /= Void and then not l_text_area.is_empty then
					Result := l_text_area.cursor_y_position.out
				end
			end
			if Result = Void then
				Result := a_text.twin
			end
		ensure
			result_attached: Result /= Void
		end

	file_content (a_file_name: STRING): STRING is
			-- Content of file specified by `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
		local
			l_retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
		do
			if not l_retried then
				create l_file.make_open_read (a_file_name)
				l_file.read_stream (l_file.count)
				Result := l_file.last_string.twin
				l_file.close
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		rescue
			l_retried := True
			if l_file /= Void and then l_file.is_open_read then
				l_file.close
			end
			retry
		end

	temporary_file_name (a_base_name: STRING): STRING is
			-- Temporary file name for buffer based on `a_base_name'
		require
			a_base_name_attached: a_base_name /= Void
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string (eiffel_layout.eiffel_home)
			l_file_name.set_file_name ("~" + a_base_name)
			Result := l_file_name
		ensure
			result_attached: Result /= Void
		end

	editor_for_class (a_class_i: CLASS_I): EB_SMART_EDITOR is
			-- Editor for `a_class_i'
			-- Void if no editor found.
		require
			a_class_i_attached: a_class_i /= Void
		do
			if workbench.system_defined and then workbench.is_already_compiled then
				Result := window_manager.last_focused_development_window.editors_manager.editor_with_class (a_class_i.file_name)
			end
		end

	new_buffer_file_name (a_file_name: STRING): STRING is
			-- New file name for `a_file_name' used in external command launching,
			-- If on Windows and `a_file_name' contains space, we srround `a_file_name' with double quotes.
		require
			a_file_name_attached: a_file_name /= Void
		do
			Result := a_file_name.twin
			if {PLATFORM}.is_windows and then a_file_name.index_of (' ', 1) > 0 then
				Result.prepend_character ('%"')
				Result.append_character ('%"')
			end
		ensure
			result_attached: Result /= Void
		end

end
