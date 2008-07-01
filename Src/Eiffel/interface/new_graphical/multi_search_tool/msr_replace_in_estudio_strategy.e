indexing
	description: "[
				Replacing directly functions in a editor if a class is loaded. Or functions the file.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_REPLACE_IN_ESTUDIO_STRATEGY

inherit
	MSR_REPLACE_STRATEGY
		redefine
			replace,
			one_cluster_item_replaced,
			is_current_replaced_as_cluster,
			item_replaced,
			all_item_replaced,
			item_writable
		end

	EB_SHARED_MANAGERS
		undefine
			default_create
		end

	EB_CLASS_TEXT_MANAGER
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SAVE_FILE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_multi_search_tool: ES_MULTI_SEARCH_TOOL_PANEL) is
			-- Initializewith an EB_EDITOR
		require
			a_multi_search_tool_not_void: a_multi_search_tool /= Void
		do
			search_tool := a_multi_search_tool
			editor := a_multi_search_tool.editor
		ensure
			search_tool_not_void: search_tool = a_multi_search_tool
		end

feature -- Status report

	is_editor_set : BOOLEAN is
			-- Is editor set?
		do
			Result := (editor /= Void)
		end

	is_editor_editable: BOOLEAN is
			-- Is editor editable?
		do
			if editor /= Void then
				Result:= editor.is_editable
			end
		end

feature -- Element change

	set_editor (a_editor: like editor) is
			-- Set `editor'
		require
			a_editor_not_void: a_editor /= Void
		do
			editor := a_editor
		ensure
			editor_not_void: editor /= Void
		end

feature -- Basic operation

	replace is
			-- Launch replacement one time, replace current item.
		require else
			replace_items_set: is_replace_items_set
			replace_string_set: is_replace_string_set
			replace_item_not_off: not replace_items.off
			is_editor_set: is_editor_set
			editor_is_editable: is_editor_editable
		local
			l_item : MSR_TEXT_ITEM
			class_i: CLASS_I
			editors_manager: EB_EDITORS_MANAGER
			l_editors: ARRAYED_LIST [EB_SMART_EDITOR]
			l_string: STRING_32
			l_text: SMART_TEXT
		do
			l_item ?= replace_items.item
			if l_item /= Void then
				class_i ?= l_item.data
				if class_i /= Void then
					editors_manager := search_tool.develop_window.editors_manager
					l_editors := editors_manager.editor_editing (class_i)
					if not l_editors.is_empty then
						editor := l_editors @ 1
					end
					if not l_editors.is_empty and search_tool.check_class_succeed and not search_tool.is_item_source_changed (l_item) then
						l_text ?= editor.text_displayed
						check
							l_text_is_smart_text: l_text /= Void
						end
						l_string := actual_replacement (l_item)
						if l_item.end_index_in_unix_text + 1 = l_item.start_index_in_unix_text then
							l_text.cursor.go_to_position (l_item.end_index_in_unix_text + 1)
							editor.deselect_all
							if not actual_replacement (l_item).is_empty then
								search_tool.set_changed_by_replace (True)
								l_text.insert_string (l_string)
								search_tool.set_changed_by_replace (True)
								if not l_string.is_empty then
									editor.select_region (l_item.start_index_in_unix_text,
														l_item.start_index_in_unix_text + l_string.count)
								end
							end
						else
							editor.select_region (l_item.start_index_in_unix_text,
													l_item.end_index_in_unix_text + 1)
							if editor.has_selection then
								search_tool.set_changed_by_replace (True)
								if not l_string.is_empty then
									editor.replace_selection (l_string)
									editor.select_region (l_item.start_index_in_unix_text,
														l_item.start_index_in_unix_text + l_string.count)
								else
									l_text.delete_selection
								end
								search_tool.set_changed_by_replace (True)
							end
						end
						editor.redraw_current_line
						replace_current_item (True)
						search_tool.force_not_changed
					end
				 end
			end
			is_replace_launched_internal := True
		end

feature {NONE} -- Implementation

	item_replaced is
			-- One item replaced when replacing all.
		do
			if smart_text /= Void then
				smart_text.history_item_bind
			end
		end

	all_item_replaced is
			-- Replace all is done.
		do
			if smart_text /= Void then
				smart_text.history_item_unbind
			end
		end

	one_cluster_item_replaced (a_item: MSR_TEXT_ITEM) is
			-- When replacing all, all items of a cluster are replaced.
			-- Typically all texts in one file are replaced.
			-- a_item is one of these items.
		local
			class_i: CLASS_I
			l_encoding: ENCODING
		do
			class_i ?= a_item.data
			if class_i /= Void then
				l_encoding ?= class_i.encoding
				save (class_i.file_name.out, a_item.source_text, l_encoding)
					-- Notify Eiffel Studio.
				editor.dev_window.eiffel_system.workbench.change_class (class_i)
				editor.dev_window.eiffel_system.workbench.set_changed
			end
		end

	is_current_replaced_as_cluster (a_item: MSR_TEXT_ITEM) : BOOLEAN is
			-- When replacing all, should a_item replaced as in cluster mode?
		local
			class_i: CLASS_I
		do
			class_i ?= a_item.data
			if class_i /= Void then
				Result := not (search_tool.develop_window.editors_manager.is_class_editing (class_i.file_name))
			end
		end

	is_class_i_editing (a_class : CLASS_I): BOOLEAN is
			-- If class_i is being editing in the editor.
		require
			a_class_not_void: a_class /= Void
		local
			l: LIST [EB_DEVELOPMENT_WINDOW]
			unchanged_editor, changed_editor: EB_DEVELOPMENT_WINDOW
			l_editor: EB_SMART_EDITOR
			l_app: like ev_application
		do
			l := window_manager.development_windows_with_class (a_class.name)
			if not l.is_empty then
				from
					l_app := ev_application
					l.start
				until
					l.after
				loop
					from
						l_editor := l.item.editors_manager.current_editor
					until
						editor.text_is_fully_loaded
					loop
						l_app.process_events
					end
					if l_editor.is_editable then
						if l.item.changed then
							changed_editor := l.item
						else
							unchanged_editor := l.item
						end
					end
					l.forth
				end
				if changed_editor /= Void then
					Result := True
				elseif unchanged_editor /= Void then
					Result := True
				else
					Result := False
				end
			else
				Result := False
			end
		end

	item_writable (a_item: MSR_ITEM): BOOLEAN is
			-- Is text representation of `a_item' writable?
		local
			l_class: CLASS_I
		do
			if a_item /= Void then
				l_class ?= a_item.data
				if l_class /= Void then
					Result := not l_class.is_read_only
				end
			end
		end

	editor : EB_EDITOR
			-- Current editor

	smart_text: SMART_TEXT is
			-- Smart text in editor.
		do
			if editor /= Void then
				Result ?= editor.text_displayed
			end
		end

	search_tool: ES_MULTI_SEARCH_TOOL_PANEL;
			-- Search tool

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
