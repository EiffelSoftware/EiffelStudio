indexing
	description: "[
		Facility for changing a class name globally.
		Note: Will not replace class names in strings and comments.
		]"
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
			cur: CURSOR
			classes: HASH_TABLE [CLASS_I, STRING]
			clusters: LIST [CLUSTER_I]
			cl: LINKED_LIST [CLASS_I]
			l_changed_count: INTEGER
			l_ctm: CLASS_TEXT_MODIFIER
		do
			create cl.make
			clusters := Eiffel_universe.clusters
			cur := clusters.cursor
			from
				clusters.start
			until
				clusters.after
			loop
				classes := clusters.item.classes
				from
					classes.start
				until
					classes.after
				loop
					if not compiled_classes_only or else classes.item_for_iteration.compiled then
						cl.extend (classes.item_for_iteration)
					end
					classes.forth
				end
				process_events_and_idle
				clusters.forth
			end
			clusters.go_to (cur)
			a_status_bar.reset_progress_bar_with_range (0 |..| cl.count)
			
			from
				cl.start
			until
				cl.after
			loop
				a_status_bar.display_progress_value (cl.index)
				l_ctm := search_replace_modifier (cl.item, a_search_string, a_replace_string)
				if l_ctm /= Void then
					l_ctm.commit_modification
					a_status_bar.display_message (cl.item.name_in_upper + " updated, continuing search and replace")
					l_changed_count := l_changed_count + 1
				end
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
		do
				-- Even though we could have more than one development window open with a diagram in it,
				-- we assume there is actually only one doing the diagraming. If there were more than one,
				-- and that `a_class' is in the two window, then the undo/redo might not work properly
				-- since we would have 2 CLASS_TEXT_MODIFIER instance.
			if window_manager.a_development_window /= Void then
				l_es_class := window_manager.a_development_window.context_tool.editor.world.model.class_from_interface (a_class)
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

end -- class CLASS_NAME_REPLACER
