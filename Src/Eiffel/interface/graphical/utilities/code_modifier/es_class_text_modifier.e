indexing
	description: "[
		A general purpose Eiffel code class modifier, associated with an Eiffel class {CLASS_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_TEXT_MODIFIER

inherit
	ES_MODIFIABLE
		redefine
			internal_recycle
		end

inherit {NONE}
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE}
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: like context_class)
			-- Initialize a class text modifier using a context class.
			--
			-- `a_class': Associated context class to modify class text for.
		local
			l_editor: like active_editor_for_class
			l_text: ?STRING
		do
			context_class := a_class

				-- Fetch original text
			l_editor := active_editor_for_class (a_class)
			if l_editor = Void then
					-- There's no open editor, use the class text from disk instead.
				l_text := a_class.text
			else
				l_text := l_editor.text
			end
			if l_text = Void then
				create l_text.make_empty
			end
			original_text ?= l_text
			original_file_date := a_class.file_date

			modified_data := create_modified_data
		ensure
			context_class_set: context_class = a_class
			not_is_dirty: not is_dirty
		end

feature -- Clean up

	internal_recycle
			-- <Precursor>
		do

		end

feature -- Access

	original_text: !STRING
			-- Original class text.

	context_class: !CLASS_I
			-- Context class.

	text: !STRING
			-- Modified class text, valid only when prepared.
			-- Note: For preformance reasons, the result is not twined.
		require
			is_interface_usable: is_interface_usable
		local
			l_text: ?STRING
		do
			l_text := modified_data.text
			if l_text /= Void then
				Result ?= l_text
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Access

	original_file_date: INTEGER
			-- Last modified file date

	modified_data: !ES_CLASS_TEXT_MODIFIER_DATA
			-- Active modified class text data

feature -- Status report

	is_prepared: BOOLEAN
			-- Indicates if Current has been prepared for special modifications.
		require
			is_interface_usable: is_interface_usable
		do
			Result := modified_data.is_prepared
		ensure
			modified_data_attached: Result implies modified_data.is_prepared
		end

	is_modifiable: BOOLEAN
			-- Indicates if the context class can be modified, or if any modifications can be performed.
		require
			is_interface_usable: is_interface_usable
		do
			Result := not context_class.is_read_only
		ensure
			context_class_is_writeable: Result implies not context_class.is_read_only
		end

	is_commit_deferred: BOOLEAN
			-- Indicates if modiciations commits deferred until the end of batch processing.

feature {NONE} -- Status report

	is_committing: BOOLEAN
			-- Indicates if modiciations commits are being performed.

feature -- Query

	initial_whitespace (a_pos: INTEGER): !STRING_8
			-- Retrieve the initial whitespace at a given position on `text'
			--
			-- `a_pos': Orginal position in `original_text' to retrieve the whitespace for.
			-- `Result': The initial whitespace string.
		require
			is_interface_usable: is_interface_usable
			a_pos_non_negative: a_pos > 0
			a_pos_small_enough: a_pos <= text.count
		local
			l_text: like text
			l_pos: INTEGER
			i: INTEGER
		do
			l_text := text
			l_pos := modified_data.adjusted_position (a_pos) - 1
			from i := l_pos until i <= 0 or not l_text.item (i).is_space or l_text.item (i) = '%N' loop
				i := i - 1
			end

			if i >= 0 and i < l_pos then
				Result ?= l_text.substring (i + 1, l_pos)
				from
					i := 1
					l_pos := Result.count
				until
					i > l_pos
				loop
					if not Result.item (i).is_space then
							-- Replace any characters with spaces.
						Result.put (' ', i)
					end
					i := i + 1
				end
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Query

	active_editor_for_class (a_class: !CLASS_I): ?EB_SMART_EDITOR
			-- Attempts to retrieve the most applicable editor for a given class.
			--
			-- `a_class': The class to retrieve the most applicable editor for.
			-- `Result': An editor which the supplied class is edited using, or Void if not being edited.
		require
			is_interface_usable: is_interface_usable
		local
			l_editor: EB_SMART_EDITOR
			l_editors: DS_ARRAYED_LIST [EB_SMART_EDITOR]
		do
			l_editors := active_editors_for_class (a_class)
			if not l_editors.is_empty then
				from l_editors.start until l_editors.after loop
					l_editor := l_editors.item_for_iteration
					if Result = Void then
						Result := l_editor
					elseif l_editor.text_displayed.is_modified then
							-- Use modified version
						Result := l_editor
					end
					l_editors.forth
				end
			end
		ensure
			result_is_editable: Result /= Void implies Result.is_editable
		end

	active_editors_for_class (a_class: !CLASS_I): !DS_ARRAYED_LIST [EB_SMART_EDITOR]
			-- Retrieves all applicable editors for a given class.
			--
			-- `a_class': The class to retrieve the most applicable editors for.
			-- `Result': A list of editors editing the supplied class.
		require
			is_interface_usable: is_interface_usable
		local
			l_windows: BILINEAR [EB_WINDOW]
			l_editor_manager: EB_EDITORS_MANAGER
			l_editor: EB_SMART_EDITOR
			l_editors: ARRAYED_LIST [EB_SMART_EDITOR]
		do
			create Result.make_default

			l_windows := window_manager.windows
			from l_windows.start until l_windows.after loop
				if {l_dev_window: EB_DEVELOPMENT_WINDOW} l_windows.item_for_iteration then
					l_editor_manager := l_dev_window.editors_manager
					if l_editor_manager /= Void then
						l_editors := l_editor_manager.editor_editing (a_class)
						if l_editors /= Void and then not l_editors.is_empty then
							from l_editors.start until l_editors.after loop
								l_editor := l_editors.item_for_iteration
								if l_editor /= Void and then l_editor.is_editable then
									Result.force_last (l_editor)
								end
								l_editors.forth
							end
						end
					end
				end
				l_windows.forth
			end
		ensure
			result_contains_attached_items: not Result.has (Void)
			result_contains_editable_items: Result.for_all (agent {EB_SMART_EDITOR}.is_editable)
		end

feature {NONE} -- Helpers

	frozen logger: !SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service.
		once
			create Result
		end

feature -- Basic operations

	prepare
			-- Prepare class text modifier for special modification.
		require
			is_interface_usable: is_interface_usable
			not_is_dirty: not is_dirty
		do
			original_text ?= modified_data.text.twin
			modified_data.prepare
		ensure
			not_is_dirty: not is_dirty
			is_prepared: is_prepared
			original_text_set: original_text.is_equal (modified_data.text)
		end

	commit
			-- Commits modifications.
			-- Note: The side affect if calling commit is that all you will need to call prepare again to make
			--       further special modifications.
		require
			is_interface_usable: is_interface_usable
			is_dirty: is_dirty
			is_modifiable: is_modifiable
			not_is_commit_deferred: not is_commit_deferred
		local
			l_editors: like active_editors_for_class
			l_editor: EB_SMART_EDITOR
			l_recent_editor: EB_SMART_EDITOR
			l_text: SMART_TEXT
			l_new_text: !STRING
			l_first_line: INTEGER
			l_line: INTEGER
			l_col: INTEGER
			l_line_count: INTEGER
			l_cursor: EIFFEL_EDITOR_CURSOR
			l_set_in_editor: BOOLEAN
			l_save: EB_SAVE_FILE
		do
			check
				not_is_committing: not is_committing
			end
			is_committing := True

			l_editors := active_editors_for_class (context_class)
			if not l_editors.is_empty then
					-- There are editors available, attempt to set to the active editor(s).
				from l_editors.start until l_editors.after or l_recent_editor /= Void loop
					l_editor := l_editors.item_for_iteration
					if l_editor.is_editable and then l_editor.text_is_fully_loaded and then l_editor.text_displayed.is_modified then
							-- There is an editor that has been modified, make this the most recent.
						l_recent_editor := l_editor
					else
						l_editors.forth
					end
				end

				from l_editors.start until l_editors.after loop
					l_editor := l_editors.item_for_iteration
					if l_editor.is_editable then
						l_editor.no_save_before_next_load

							-- Fetch position information.
						l_first_line := l_editor.first_line_displayed
						l_text := l_editor.text_displayed
						if l_text /= Void then
							l_line := l_text.cursor.y_in_lines
							l_col := l_text.cursor.x_in_characters
						end

							-- Set text, always using a merge.
						l_new_text := merge_text (l_text.text)

							-- Set text to `modified_data' for use in `prepare'
						if l_recent_editor = l_editor then
								-- Set modified data text to the most recent editor
							modified_data.text := l_new_text
						elseif l_recent_editor = Void and then l_editors.is_last then
								-- No recent editor, just use the last editor's text
							modified_data.text := l_new_text
						end

						l_editor.set_editor_text (l_new_text)
						l_set_in_editor := True

						if logger.is_service_available then
								-- Log change
							logger.service.put_message_format ("Modified class {1} using {2} in IDE editor", [context_class.name, generating_type], {ENVIRONMENT_CATEGORIES}.editor)
						end

							-- Reset position information.
						l_line_count := l_editor.number_of_lines
						l_editor.set_first_line_displayed (l_first_line.min (l_line_count), True)
						l_cursor := l_editor.text_displayed.cursor
						if l_line > 0 and then l_line_count > 0 then
							l_cursor.set_y_in_lines (l_line.min (l_line_count))
						end
						if l_col > 0 then
							l_cursor.set_x_in_characters (l_col)
						end
					end
					l_editors.forth
				end
			end

			if not l_set_in_editor then
				if (create {RAW_FILE}.make (context_class.file_name)).exists and then original_file_date /= context_class.file_date then
						-- Need to use merge
					l_new_text ?= context_class.text
					l_new_text.prune_all ('%R')
					l_new_text := merge_text (l_new_text)
				else
					l_new_text := text
				end
					-- Set text to `modified_data' for use in `prepare'
				modified_data.text := l_new_text

					-- No editors, save directly to disk.
				create l_save
				l_save.save (context_class.file_name, l_new_text)

					-- Update class file data time stamp
				original_file_date := context_class.file_date

				if logger.is_service_available then
						-- Log change
					logger.service.put_message_format ("Modified class {1} using {2} on disk.", [context_class.name, generating_type], {ENVIRONMENT_CATEGORIES}.editor)
				end
			end

				-- Reset cached data
			original_text := text.twin
			modified_data.reset

			set_is_dirty (False)
			is_committing := False
		ensure
			not_is_dirty: not is_dirty
			not_is_prepared: not is_prepared
			text_is_equal_original_text: text.is_equal (original_text)
			is_committing_unchanged: is_committing = old is_committing
		rescue
			is_committing := False
		end

	rollback
			-- Reverts back the last changes made to the last state as determine when Current was initialized.
		require
			is_interface_usable: is_interface_usable
			is_dirty: is_dirty
		do
			check
				not_is_committing: not is_committing
			end

			modified_data := create_modified_data
			set_is_dirty (False)
		ensure
			not_is_dirty: not is_dirty
			not_is_prepared: not is_prepared
		end

feature {NONE} -- Basic operations

	merge_text (a_current_text: STRING): !like text
			-- Retrieves the merged text, using a modified source as the base.
			--
			-- `a_current_text': The text currently found on disk or in an editor.
			-- `Result': The result of a merge
		require
			is_interface_usable: is_interface_usable
			is_dirty: is_dirty
			a_current_text_attached: a_current_text /= Void
		local
			l_diff: DIFF_TEXT
			l_patch: STRING
		do
			create l_diff
			l_diff.set_text (original_text, text)
			l_diff.compute_diff
			l_patch := l_diff.unified
			if l_patch /= Void and then not l_patch.is_empty then
				Result ?= l_diff.patch (a_current_text, l_patch, False)
			else
				Result ?= text
			end

			if logger.is_service_available then
					-- Log merge
				logger.service.put_message_format_with_severity ("A class text merge was perform because {1} was modified.", [context_class.name], {ENVIRONMENT_CATEGORIES}.editor, {PRIORITY_LEVELS}.low)
			end
		end

feature -- Batch processing

	begin_batch_modifications (a_prepare: BOOLEAN)
			-- Begins batch modifications.
			--
			-- `a_prepare': True to prepare for special modifications; False otherwise.
		require
			is_interface_usable: is_interface_usable
			not_is_commit_deferred: not is_commit_deferred
			is_modifiable: is_modifiable
		do
			is_commit_deferred := True
			if a_prepare and not is_prepared then
				prepare
			end
		ensure
			is_commit_deferred: is_commit_deferred
			is_prepared: is_prepared
		end

	end_batch_modifications (a_commit: BOOLEAN)
			-- End batch modifications.
			--
			-- `a_commit': True to commit any modifications; False otherwise.
		require
			is_interface_usable: is_interface_usable
			is_commit_deferred: is_commit_deferred
			is_modifiable: is_modifiable
		do
			if a_commit and is_dirty then
				commit
			end
			is_commit_deferred := False
		ensure
			not_is_commit_deferred: not is_commit_deferred
			not_is_dirty: a_commit implies not is_dirty
		end

	rollback_batch_modifications
			-- Rollback any modifications made since the last commit during batch modifications.
		require
			is_interface_usable: is_interface_usable
			is_commit_deferred: is_commit_deferred
			is_modifiable: is_modifiable
		do
			if is_dirty then
				rollback
			end
			end_batch_modifications (False)
		ensure
			not_is_commit_deferred: not is_commit_deferred
			not_is_dirty: not is_dirty
		end

	execute_batch_modifications (a_action: !PROCEDURE [ANY, TUPLE]; a_prepare: BOOLEAN; a_commit: BOOLEAN)
			-- Performs modifications in deferred-commit mode.
			--
			-- `a_action': Action to call during batch modifications.
			-- `a_prepare': True to prepare for special modifications; False otherwise.
			-- `a_commit': True to commit any modifications; False otherwise.
		require
			is_interface_usable: is_interface_usable
			not_is_commit_deferred: not is_commit_deferred
			is_modifiable: is_modifiable
		do
			begin_batch_modifications (a_prepare)
			a_action.call (Void)
			end_batch_modifications (a_commit)
		ensure
			not_is_commit_deferred: not is_commit_deferred
		rescue
			end_batch_modifications (a_commit)
		end

feature -- Modifications (positional)

	insert_code (a_pos: INTEGER; a_code: ?STRING_GENERAL)
			-- Inserts code at a given position.
			--
			-- `a_pos': Original position, in characters to insert code into.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			a_pos_positive: a_pos > 0
			a_pos_small_enough: a_pos <= original_text.count
			a_code_attached: a_code /= Void
			not_a_code_is_empty: not a_code.is_empty
		local
			l_data: !like modified_data
			l_pos: INTEGER
		do
			l_data := modified_data
			l_pos := l_data.adjusted_position (a_pos)
			l_data.text.insert_string (a_code.as_string_8, l_pos)
			l_data.adjust_position (a_pos, a_code.count)
			set_is_dirty (True)
		ensure
			text_count_increased: text.count = old text.count + a_code.count
			text_inserted: a_code.as_string_8.is_equal (text.substring (a_pos, a_pos + a_code.count - 1))
			is_dirty: is_dirty
		end

	replace_code (a_start_pos: INTEGER; a_end_pos: INTEGER; a_code: ?STRING_GENERAL)
			-- Replaces a region of code at a given position.
			--
			-- `a_start_pos': Original position, in characters to start the code replacement.
			-- `a_end_pos': Original position, in characters to end the code replacement.
			-- `a_code': Code to replace.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			a_start_pos_non_negative: a_start_pos >= 0
			a_start_pos_small_enough: a_start_pos < original_text.count
			a_end_pos_big_enough: a_end_pos > a_start_pos
			a_end_pos_small_enough: a_start_pos <= original_text.count
			a_code_attached: a_code /= Void
			not_a_code_is_empty: not a_code.is_empty
		local
			l_data: !like modified_data
			l_start_pos: INTEGER
			l_end_pos: INTEGER
		do
			l_data := modified_data
			l_start_pos := l_data.adjusted_position (a_start_pos)
			l_end_pos := l_data.adjusted_position (a_end_pos)
			l_data.text.replace_substring (a_code.as_string_8, l_start_pos, l_end_pos)
			l_data.adjust_position (a_start_pos, (a_end_pos - a_start_pos) + a_code.count)
			set_is_dirty (True)
		ensure
			text_count_increased: text.count = old text.count + a_code.count - (a_end_pos - a_start_pos - 1)
			text_inserted: a_code.as_string_8.is_equal (text.substring (a_start_pos, a_code.count))
			is_dirty: is_dirty
		end

	remove_code (a_start_pos: INTEGER; a_end_pos: INTEGER)
			-- Remove a region of code.
			--
			-- `a_start_pos': Original position, in characters to start the code removal.
			-- `a_end_pos': Original position, in characters to end the code removal.
		require
			is_interface_usable: is_interface_usable
			is_prepared: is_prepared
			a_start_pos_non_negative: a_start_pos >= 0
			a_start_pos_small_enough: a_start_pos < original_text.count
			a_end_pos_big_enough: a_end_pos > a_start_pos
			a_end_pos_small_enough: a_start_pos <= original_text.count
		local
			l_data: !like modified_data
			l_start_pos: INTEGER
			l_end_pos: INTEGER
		do
			l_data := modified_data
			l_start_pos := l_data.adjusted_position (a_start_pos)
			l_end_pos := l_data.adjusted_position (a_end_pos)
			l_data.text.replace_substring ("", l_start_pos, l_end_pos)
			l_data.adjust_position (a_start_pos, a_end_pos - a_start_pos)
			set_is_dirty (True)
		ensure
			text_count_increased: text.count = old text.count - (a_end_pos - a_start_pos + 1)
			is_dirty: is_dirty
		end

feature {NONE} -- Factory

	create_modified_data: like modified_data
			-- Creates a new class modifier data object based on Current's state
		require
			is_interface_usable: is_interface_usable
		local
			l_class: !like context_class
			l_editor: like active_editor_for_class
			l_text: !STRING
		do
			l_class := context_class
			l_editor := active_editor_for_class (l_class)
			if l_editor = Void then
					-- There's no open editor, use the class text from disk instead.
				l_text := original_text
			else
				l_text ?= l_editor.text
			end
			create Result.make (l_class, l_text)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
