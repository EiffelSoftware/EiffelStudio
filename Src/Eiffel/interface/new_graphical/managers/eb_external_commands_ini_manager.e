note
	description: "Manager for external commands which saved in ini file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_EXTERNAL_COMMANDS_INI_MANAGER

inherit
	INI_CALLBACKS

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	INTERFACE_NAMES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initializatin

	make (a_editor: EB_EXTERNAL_COMMANDS_EDITOR)
			-- Creation method
		require
			not_void: attached a_editor
		do
			editor := a_editor
		ensure
			set: editor = a_editor
		end

feature -- Command

	update_from_ini_file
			-- Update `commands' from ini file
		local
			l_parser: INI_FAST_PARSER
			l_content: like file_content
		do
			create l_parser
			l_content := file_content
			if not l_content.is_empty then
				l_parser.parse (l_content, Current)
				editor.shortcut_manager.update_external_commands
			end
		end

	generate_ini
			-- Generate a file from `commands'
		local
			l_printer: INI_PRINTER
			l_retried: BOOLEAN
			l_error_provider: ES_PROMPT_PROVIDER
			l_item: detachable EB_EXTERNAL_COMMAND
			l_key: INTEGER
			l_file: PLAIN_TEXT_FILE
		do
			if not l_retried then
				l_file := file

				l_file.close
				l_file.wipe_out
				l_file.open_read_write

				create l_printer.make (l_file)

				l_printer.put_comment ("External commands used by Eiffel Studio")
				l_printer.put_new_line

				from
					commands.start
				until
					commands.after
				loop
					l_item := commands.item_for_iteration
					l_key := commands.key_for_iteration
					if attached l_item and then l_key >= 0  then
						l_printer.put_property (l_key.out, l_item.resource)
					end

					commands.forth
				end
				l_printer.flush
			else
				create l_error_provider
				l_error_provider.show_error_prompt (l_generating_ini_file_failed, void, void)
			end
		rescue
			l_retried := True
			retry
		end

feature -- Query

	commands: HASH_TABLE [EB_EXTERNAL_COMMAND, INTEGER]
			-- All commands cache
		once
			create Result.make (10)
		end

	editor: EB_EXTERNAL_COMMANDS_EDITOR
			-- External commands edtitor

feature {NONE} -- Implementation

	file_content: STRING_32
			-- Content of ini file
		local
			l_file: PLAIN_TEXT_FILE
			l_content: STRING
			u: UTF_CONVERTER
		do
			create l_file.make_with_path (eiffel_layout.user_external_command_file_name (ini_file_name))
			create l_content.make (l_file.count)
			if l_file.exists then
				from
					l_file.open_read
					l_file.start
				until
					l_file.after
				loop
					l_file.read_line

					l_content.append (l_file.last_string)
					l_content.append ("%N")
				end
					-- The .ini file was generated in UTF-8 encoding.
				Result := u.utf_8_string_8_to_string_32 (l_content)
			else
				create Result.make_empty
			end
		ensure
			not_void: attached Result
		end

	file: PLAIN_TEXT_FILE
			-- File used by `generate_ini'
		local
			l_text_file: PLAIN_TEXT_FILE
		do
			create l_text_file.make_with_path (eiffel_layout.user_external_command_file_name (ini_file_name))
			if not l_text_file.exists then
				l_text_file.create_read_write
			else
				l_text_file.open_read_write
			end
			Result := l_text_file
		end

	ini_file_name: STRING = "external_commands"
			-- File name of ini

feature {INI_FAST_PARSER} -- Actions

	on_start
			-- <Precursor>
		do
		end

	on_finished (a_successful: BOOLEAN)
			-- <Precursor>
		do
		end

	on_section (a_name: READABLE_STRING_32)
			-- <Precursor>
		do
		end

	on_property (a_name: READABLE_STRING_32; a_value: detachable READABLE_STRING_32)
			-- <Precursor>
		local
			l_command: EB_EXTERNAL_COMMAND
			l_string: STRING_32
		do
			if a_name.is_integer then
				create l_string.make_from_string (a_value)
				l_string.left_adjust
				create l_command.make_from_string (editor, l_string)
				if l_command.is_valid then
					l_command.setup_managed_shortcut (editor.accelerators)
					commands.force (l_command, a_name.to_integer)
				end
			else
				check False end	 -- Implied by `generate_ini'
			end
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
