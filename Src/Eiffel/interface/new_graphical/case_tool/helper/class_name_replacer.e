indexing
	description: "[
		Facility for changing a class name globally.
		Note: Will not replace class names in strings and comments.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_NAME_REPLACER

inherit
	SHARED_EIFFEL_PROJECT

	SHARED_API_ROUTINES

	EB_SHARED_INTERFACE_TOOLS

	EV_SHARED_APPLICATION

feature -- Search and replace

	global_class_name_replace (a_search_string, a_replace_string: STRING; compiled_classes_only: BOOLEAN; a_status_bar: EB_DEVELOPMENT_WINDOW_STATUS_BAR) is
			-- Replace in all compiled classes in the system all class name
			-- `a_search_string' occurrences of `a_search_string' with `a_replace_string'.
			-- Outputted messages are performed via `a_status_bar'.
		require
			a_search_string_not_void: a_search_string /= Void
			a_replace_string_not_void: a_replace_string /= Void
		local
			cl: DS_HASH_SET [CLASS_I]
			l_changed_count: INTEGER
			l_ctm: CLASS_TEXT_MODIFIER
			l_index: INTEGER
			l_class: CLASS_I
		do
			cl := eiffel_universe.all_classes
			a_status_bar.reset_progress_bar_with_range (0 |..| cl.count)

			from
				cl.start
				l_index := 0
			until
				cl.after
			loop
				l_class := cl.item_for_iteration
				a_status_bar.display_progress_value (l_index)
				if not l_class.is_read_only and then (not compiled_classes_only or else l_class.compiled) then
					l_ctm := search_replace_modifier (l_class, a_search_string, a_replace_string)
					if l_ctm /= Void then
						l_ctm.commit_modification
						a_status_bar.display_message (l_class.name_in_upper + " updated, continuing search and replace")
						l_changed_count := l_changed_count + 1
					end
				end
				l_index := l_index + 1
				cl.forth
				process_events_and_idle
			end
			a_status_bar.reset_progress_bar_with_range (0 |..| 100)
			if l_changed_count > 1 then
				a_status_bar.display_message (l_changed_count.out + " classes updated")
			elseif l_changed_count = 1 then
				a_status_bar.display_message (l_changed_count.out + " class updated")
			else
				a_status_bar.display_message ("0 classes updated")
			end
		end

feature -- Status report

	valid_new_class_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' valid for a new class name or generic?
		require
			a_name_not_void: a_name /= Void
		do
			Result := (create {IDENTIFIER_CHECKER}).is_valid (a_name)
			--| FIXME May not be a formal generic in any of the classes involved.
		end

	class_name_in_use (a_name: STRING): BOOLEAN is
			-- Is `a_name' already used in the system?
		do
			Result := class_i_by_name (a_name) /= Void
		end

feature {NONE} -- Implementation

	search_replace_modifier (a_class: CLASS_I; a_search_string, a_replace_string: STRING): CLASS_TEXT_MODIFIER is
			-- Replace in `a_class' all class name occurrences of
			-- `a_search_string' with `a_replace_string'.
			-- Call 'commit_modification' on `Result' to update class text.
			-- If result is Void then no text has to be modified.
		local
			ctm: CLASS_TEXT_MODIFIER
			click_list: CLICK_LIST
			click_item: CLICK_AST
			class_as: CLASS_AS
			cl_type_as: CLASS_TYPE_AS
			s: STRING
			cur_disp, disp: INTEGER
			is_occurrence_found: BOOLEAN
			pr_type_as: PRECURSOR_AS
			st, en: INTEGER
			l_es_class: ES_CLASS
			l_classes: ARRAYED_LIST [ES_CLASS]
		do
				-- Even though we could have more than one development window open with a diagram in it,
				-- we assume there is actually only one doing the diagraming. If there were more than one,
				-- and that `a_class' is in the two window, then the undo/redo might not work properly
				-- since we would have 2 CLASS_TEXT_MODIFIER instance.
			if window_manager.a_development_window /= Void then
				l_classes := window_manager.a_development_window.context_tool.editor.world.model.class_from_interface (a_class)
				if not l_classes.is_empty then
				 	l_es_class := l_classes.first
				end
			end
			if l_es_class /= Void then
				ctm := l_es_class.code_generator
			else
				create ctm.make (a_class)
			end
			ctm.prepare_for_modification
			if ctm.valid_syntax then
				click_list := ctm.class_as.click_list
				disp := a_search_string.count - a_replace_string.count

				from
					click_list.start
				until
					click_list.after
				loop
					click_item := click_list.item
					s := Void
					if click_item.node.is_class then
						cl_type_as ?= click_item.node
						if cl_type_as /= Void then
							s := cl_type_as.class_name
						else
							class_as ?= click_item.node
							if class_as /= Void then
								s := class_as.class_name
							end
						end
						if s /= Void and then s.is_equal (a_search_string) then
							ctm.replace_code (a_replace_string, click_item.start_position + cur_disp, click_item.end_position + cur_disp)
							cur_disp := cur_disp - disp
							is_occurrence_found := True
						end
					elseif click_item.node.is_precursor then
						pr_type_as ?= click_item.node
						if pr_type_as /= Void then
							st := ctm.index_of ('{', click_item.start_position + cur_disp)
							if st > 0 then
								en := ctm.index_of ('}', st)
								if en > 0 then
									s := ctm.code (st + 1, en - 1)
									if s.is_equal (a_search_string) then
										ctm.replace_code (a_replace_string, st + 1, en - 1)
										cur_disp := cur_disp - disp
										is_occurrence_found := True
									end
								end
							end
						end
					end

					click_list.forth
				end
				if is_occurrence_found then
					Result := ctm
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

end -- class CLASS_NAME_REPLACER
