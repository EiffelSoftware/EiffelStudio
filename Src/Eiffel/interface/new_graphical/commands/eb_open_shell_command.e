indexing
	description	: "Command to open a shell with an editor."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_OPEN_SHELL_COMMAND

inherit
	EB_DEVELOPMENT_WINDOW_COMMAND
		redefine
			initialize
		end

	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			new_sd_toolbar_item,
			tooltext
		end

	SHARED_EIFFEL_PROJECT

	SHARED_SERVER

	SYSTEM_CONSTANTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_CONSTANTS

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Enable `Current'.
		do
			is_sensitive := True
		end

feature -- Basic operations

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_BUTTON is
			-- Create a new toolbar button for this command.
		do
			Result := Precursor (display_text)
			Result.drop_actions.extend (agent execute_with_stone (?))
			Result.drop_actions.set_veto_pebble_function (agent is_droppable)
		end

feature -- Access

	execute_with_stone (s: STONE) is
		local
			cs: CLASSI_STONE
			fs: FEATURE_STONE
			ls: LINE_STONE
			ast: AST_STONE
			cl_syntax_s: CL_SYNTAX_STONE
		do
			fs ?= s
			if fs /= Void then
				process_feature (fs)
			else
				cl_syntax_s ?= s
				if cl_syntax_s /= Void then
					process_class_syntax (cl_syntax_s)
				else
					ast ?= s
					if ast /= Void then
						process_ast (ast)
					else
						cs ?= s
						if cs /= Void then
							process_class (cs)
						else
							ls ?= s
							if ls /= Void then
								process_line (ls)
							end
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	process_feature (fs: FEATURE_STONE) is
			-- Process feature stone.
		require
			fs_not_void: fs /= Void
		local
			req: COMMAND_EXECUTOR
		do
				-- feature text area
			create req
			req.execute (preferences.misc_data.external_editor_cli (fs.file_name, fs.line_number))
		end

	process_class (cs: CLASSI_STONE) is
			-- Process class stone.
		require
			cs_not_void: cs /= Void
		local
			req: COMMAND_EXECUTOR
			conv_f: FEATURE_STONE
		do
			conv_f ?= cs
			if conv_f = Void then
				create req
				req.execute (preferences.misc_data.external_editor_cli (cs.file_name, 1))
			end
		end

	process_line (ls: LINE_STONE) is
			-- Process line stone.
		require
			ls_not_void: ls /= Void
		local
			req: COMMAND_EXECUTOR
			cl: CLASS_C
		do
			cl := ls.class_c
			if cl /= Void then
				create req
				req.execute (preferences.misc_data.external_editor_cli (cl.file_name, ls.line_number))
			end
		end

	process_ast (s: AST_STONE) is
			-- Process AST stone
		require
			ast_not_void: s /= Void
		local
			req: COMMAND_EXECUTOR
			fn: STRING
			ln: INTEGER
		do
			fn := s.file_name
			if fn /= Void then
				ln := s.line_position
				create req
				req.execute (preferences.misc_data.external_editor_cli (fn, ln.max (1)))
			end
		end

	process_class_syntax (syn: CL_SYNTAX_STONE) is
			-- Process class syntax stone.
		require
			syn_not_void: syn /= Void
		local
			req: COMMAND_EXECUTOR
		do
			create req
			req.execute (preferences.misc_data.external_editor_cli (syn.file_name, syn.syntax_message.line))
		end

	execute is
			-- Redefine
		local
			req: COMMAND_EXECUTOR
			line_nb, first_line, cursor_line: INTEGER
			development_window: EB_DEVELOPMENT_WINDOW
			editor: EB_SMART_EDITOR
		do
			development_window := target
			editor := development_window.editors_manager.current_editor
			if editor /= Void and then not editor.is_empty then
					-- We ensure that we target the editor line to the cursor position, however if the cursor
					-- is not visible we take the `first_line_displayed'.
				cursor_line := editor.cursor_y_position
				first_line := editor.first_line_displayed
				if first_line > cursor_line then
					line_nb := first_line
				elseif
					first_line < cursor_line and
					cursor_line < first_line + editor.number_of_lines_displayed
				then
					line_nb := cursor_line
				else
					line_nb := first_line
				end
			end
			create req
			req.execute (preferences.misc_data.external_editor_cli (window_file_name, line_nb.max (1)))
		end

	window_file_name: STRING is
			-- Provides the filename of the current edited element, if possible.
		local
			fs: FILED_STONE
		do
			fs ?= target.stone
			if fs /= Void then
				Result := fs.file_name
			end
		end

feature {NONE} -- Implementation properties

	menu_name: STRING_GENERAL is
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_external_editor
		end

	pixmap: EV_PIXMAP is
			-- Pixmaps representing the command.
		do
			Result := pixmaps.icon_pixmaps.command_send_to_external_editor_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.command_send_to_external_editor_icon_buffer
		end

	tooltip: STRING_GENERAL is
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.e_shell
		end

	tooltext: STRING_GENERAL is
			-- Textp for the toolbar button.
		do
			Result := Interface_names.b_shell
		end

	description: STRING_GENERAL is
			-- Description for this command.
		do
			Result := Interface_names.e_shell
		end

	name: STRING is "Open_shell"
			-- Name of the command. Used to store the command in the
			-- preferences.

	is_droppable (st: ANY): BOOLEAN is
			-- Can `st' be dropped?
		local
			conv_st: STONE
			l_ex: CLASSI_STONE
			l_ex_c: CLASSC_STONE
			l_fs: FEATURE_STONE
			l_syntax: CL_SYNTAX_STONE
		do
			conv_st ?= st
			Result := conv_st /= Void and then conv_st.is_storable and then conv_st.is_valid
			if Result then
					-- If it is an external class, then we cannot drop.
				l_ex ?= st
				if l_ex /= Void then
					Result := not l_ex.class_i.is_external_class
				else
					l_ex_c ?= st
					if l_ex_c /= Void then
						Result := not l_ex_c.e_class.is_true_external
					else
						l_fs ?= st
						Result := l_fs /= Void
						if not Result then
							l_syntax ?= st
							Result := l_syntax /= Void
						end
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_OPEN_SHELL_CMD
