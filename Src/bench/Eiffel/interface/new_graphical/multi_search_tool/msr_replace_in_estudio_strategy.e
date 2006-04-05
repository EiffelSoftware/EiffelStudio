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
			all_item_replaced
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

	make (a_multi_search_tool: EB_MULTI_SEARCH_TOOL) is
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
			l_string: STRING
			l_text: SMART_TEXT
		do
			l_item ?= replace_items.item
			if l_item /= Void then
				class_i ?= l_item.data
				if class_i /= Void then
					if is_class_i_editing (class_i) and search_tool.check_class_succeed and not search_tool.is_item_source_changed (l_item) then
						l_text ?= editor.text_displayed
						check
							l_text_is_smart_text: l_text /= Void
						end
						l_string := actual_replacement (l_item)
						if l_item.end_index_in_unix_text + 1 = l_item.start_index_in_unix_text then
							l_text.cursor.go_to_position (l_item.end_index_in_unix_text + 1)
							editor.deselect_all
							if not actual_replacement (l_item).is_empty then
								search_tool.set_changed_by_replace (true)
								l_text.insert_string (l_string)
								search_tool.set_changed_by_replace (true)
								if not l_string.is_empty then
									editor.select_region (l_item.start_index_in_unix_text, l_item.start_index_in_unix_text + l_string.count)
								end
							end
						else
							editor.select_region (l_item.start_index_in_unix_text, l_item.end_index_in_unix_text + 1)
							if editor.has_selection then
								search_tool.set_changed_by_replace (true)
								if not l_string.is_empty then
									editor.replace_selection (l_string)
									editor.select_region (l_item.start_index_in_unix_text, l_item.start_index_in_unix_text + l_string.count)
								else
									l_text.delete_selection
								end
								search_tool.set_changed_by_replace (true)
							end
						end
						editor.redraw_current_line
						replace_current_item (true)
						search_tool.force_not_changed
					end
				 end
			end
			is_replace_launched_internal := true
		end

feature {NONE} -- Implementation

	item_replaced is
			-- One item replaced when replacing all.
		do
			smart_text.history_item_bind
		end

	all_item_replaced is
			-- Replace all is done.
		do
			smart_text.history_item_unbind
		end

	one_cluster_item_replaced (a_item: MSR_TEXT_ITEM) is
			-- When replacing all, all items of a cluster are replaced.
			-- Typically all texts in one file are replaced.
			-- a_item is one of these items.
		local
			class_i: CLASS_I
		do
			class_i ?= a_item.data
			if class_i /= Void then
				save (class_i.file_name.out, a_item.source_text)
					-- Notify Eiffel Studio.
				editor.dev_window.eiffel_system.workbench.change_class (class_i)
			end
		end

	is_current_replaced_as_cluster (a_item: MSR_TEXT_ITEM) : BOOLEAN is
			-- When replacing all, should a_item replaced as in cluster mode?
		local
			class_i: CLASS_I
		do
			class_i ?= a_item.data
			if class_i /= Void then
				Result := not (is_class_i_editing (class_i))
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
		do
			l := window_manager.development_windows_with_class (a_class.name)
			if not l.is_empty then
				from
					l.start
				until
					l.after
				loop
					l_editor := l.item.editor_tool.text_area
					from
						process_events_and_idle
					until
						editor.text_is_fully_loaded
					loop
						ev_application.idle_actions.call ([])
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
					Result := true
				elseif unchanged_editor /= Void then
					Result := true
				else
					Result := false
				end
			else
				Result := false
			end
		end

	editor : EB_EDITOR

	smart_text: SMART_TEXT is
			-- Smart text in editor.
		do
			Result ?= editor.text_displayed
			check
				is_smart_text: Result /= Void
			end
		end

	search_tool: EB_MULTI_SEARCH_TOOL;

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
