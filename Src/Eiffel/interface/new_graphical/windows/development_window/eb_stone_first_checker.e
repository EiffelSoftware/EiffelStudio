indexing
	description: "[
						Handle stone for development window.
						This class is extract from EB_DEVELOPMENT_WINDOW set_stone_after_first_check.

																										]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_STONE_FIRST_CHECKER

create
	make

feature {NONE} -- Initlization

	make (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Creation method.
		require
			not_void: a_window /= Void
		do
			develop_window := a_window
		ensure
			set: develop_window = a_window
		end

feature -- Command

	set_stone_after_first_check (a_stone: STONE) is
			-- Display text associated with `a_stone', if any and if possible
		local
			l_managed_main_formatters: ARRAYED_LIST [EB_CLASS_TEXT_FORMATTER]
			l_editors_manager: EB_EDITORS_MANAGER
			l_editor_displayer: EB_FORMATTER_EDITOR_DISPLAYER
		do
			old_class_stone ?= develop_window.stone
			feature_stone ?= a_stone
			ef_stone ?= a_stone
			new_class_stone ?= a_stone
			cluster_st ?= a_stone
			l_editors_manager := develop_window.editors_manager
			editor := l_editors_manager.editor_with_stone (a_stone)

			if editor /= Void then
				l_editors_manager.editor_switched_actions.block
				if not has_error_when_error_tool_auto_hide then
					editor.docking_content.set_focus_no_maximized (editor.docking_content.user_widget)
				end
				l_editors_manager.editor_switched_actions.resume
			else
				if l_editors_manager.editor_count = 0 then
					-- FIXIT: remove the following line if we reaaly decided we can have void editor
					l_editors_manager.create_editor
					l_editors_manager.last_created_editor.docking_content.set_focus
				end
			end

			if editor = Void then
				save_needed := True
			end

				-- Update the history.
			conv_brkstone ?= a_stone
			conv_errst ?= a_stone

				-- If it is not cancelled, we set it back in EB_STONE_CHECKER
			develop_window.set_history_moving_cancelled (True)

			if
				conv_brkstone = Void and
				conv_errst = Void and
				ef_stone = Void
			then
				if
					new_class_stone /= Void
				then
					develop_window.history_manager.extend (new_class_stone)
				elseif
					cluster_st /= Void
				then
					develop_window.history_manager.extend (cluster_st)
				end
			end

				-- Refresh editor in main formatters.			
			if l_editors_manager.current_editor /= Void then
				create l_editor_displayer.make (l_editors_manager.current_editor)
				from
					l_managed_main_formatters := develop_window.managed_main_formatters
					l_managed_main_formatters.start
				until
					l_managed_main_formatters.after
				loop
					l_managed_main_formatters.item.set_editor_displayer (l_editor_displayer)
					l_managed_main_formatters.item.set_should_displayer_be_recycled (True)
					l_managed_main_formatters.forth
				end
			end

			if old_class_stone /= Void then
				create test_stone.make (old_class_stone.class_i)
				same_class := test_stone.same_as (a_stone)
					-- We need to compare classes. If `old_class_stone' is a FEATURE_STONE
					-- `same_as' will compare features. Therefore, we need `test_stone' to be sure
					-- we have a CLASSI_STONE.
				if same_class and then feature_stone /= Void then
					same_class := False
						-- if the stone corresponding to a feature of currently opened class is dropped
						-- we attempt to scroll to the feature without asking to save the file
						-- except if it is during a resynchronization, in which case we do not scroll at all.
					if not develop_window.is_text_loaded and then not develop_window.during_synchronization then
						develop_window.scroll_to_feature (feature_stone.e_feature, new_class_stone.class_i)
						develop_window.set_feature_stone_already_processed (True)
					else
						develop_window.set_feature_stone_already_processed (False)
					end
					conv_ferrst ?= feature_stone
					if develop_window.feature_stone_already_processed and conv_ferrst /= Void then
							-- Scroll to the line of the error.
						if not develop_window.during_synchronization and then l_editors_manager.current_editor /= Void then
							l_editors_manager.current_editor.display_line_when_ready (conv_ferrst.line_number, 0, True)
						end
					end
				end
			elseif ef_stone /= Void then
			end

				-- first, let's check if there is already something in this window
				-- if there's nothing, there's no need to save anything...
			if develop_window.stone = Void or else not develop_window.changed or else develop_window.feature_stone_already_processed or else same_class then
				develop_window.set_stone_after_check (a_stone)
				develop_window.set_feature_stone_already_processed (False)
			else
					-- there is something to be saved
					-- if user chooses to save, current file will be parsed
					-- if there is a syntax_error, new file is not loaded
				if save_needed then
					develop_window.save_and (agent develop_window.set_stone_after_check (a_stone))
				else
					develop_window.set_stone_after_check (a_stone)
				end
				if develop_window.text_saved and then not develop_window.syntax_is_correct then
					develop_window.set_text_saved (False)
					develop_window.set_during_synchronization (True)
					develop_window.set_stone_after_check (develop_window.stone)
					develop_window.set_during_synchronization (False)
					develop_window.address_manager.refresh
				end
			end

			if l_editors_manager.current_editor /= Void and then not l_editors_manager.current_editor.has_focus and then not has_error_when_error_tool_auto_hide then
				develop_window.ev_application.do_once_on_idle (agent develop_window.set_focus_to_main_editor)
			end
		end

feature{NONE} -- Implementation

	has_error_when_error_tool_auto_hide: BOOLEAN is
			-- When project has errors and Errors Tools is auto hiding, we should not set focus to editor.
			-- Otherwise the Errors Tools sliding panel will be removed automatically, because it doesn't has focus.
			-- See bug#12765.
		local
			l_tool: ES_TOOL [EB_TOOL]
		do
			l_tool := develop_window.shell_tools.tool ({ES_ERROR_LIST_TOOL})
			if l_tool /= Void and then not l_tool.is_recycled and then l_tool.panel.content /= Void then
				Result := (l_tool.panel.content.state_value = {SD_ENUMERATION}.auto_hide) and (not develop_window.eiffel_project.successful)
			end
		end

	develop_window: EB_DEVELOPMENT_WINDOW
			--Development window associate with.

	feature_stone: FEATURE_STONE
			-- Feature stone if exist.

	old_class_stone: CLASSI_STONE
			-- Old class stone if exist.

	test_stone: CLASSI_STONE
			-- Text stone if exist.

	same_class: BOOLEAN
			-- If old stone and new stone are same class?

	conv_ferrst: FEATURE_ERROR_STONE
			-- Feature errror stone if exist.

	ef_stone: EXTERNAL_FILE_STONE
			-- External file stone if exist.

	cluster_st: CLUSTER_STONE
			-- Cluster stone if exist.

	new_class_stone: CLASSI_STONE
			-- New class stone if exist.

	conv_errst: ERROR_STONE
			-- Error stone if exist.

	conv_brkstone: BREAKABLE_STONE
			-- Breakable stone if exist.

	editor: EB_SMART_EDITOR
			-- Editor related if exist.

	save_needed: BOOLEAN;
			-- If save file needed?

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

end
