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

feature -- Search and replace

	global_compiled_class_name_replace (a_search_string, a_replace_string: STRING) is
			-- Replace in all compiled classes in the system all class name
			-- `a_search_string' occurrences of `a_search_string' with `a_replace_string'.
		require
			a_search_string_not_void: a_search_string /= Void
			a_replace_string_not_void: a_replace_string /= Void
		local
			cur: CURSOR
			classes: HASH_TABLE [CLASS_I, STRING]
			clusters: LIST [CLUSTER_I]
			cl: LINKED_LIST [CLASS_I]
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
					if classes.item_for_iteration.compiled then
						cl.extend (classes.item_for_iteration)
					end
					classes.forth
				end
				clusters.forth
			end
			clusters.go_to (cur)
			Progress_dialog.set_title ("Renaming in compiled classes")
			perform_replacing (cl, a_search_string, a_replace_string)
		end

	global_class_name_replace (a_search_string, a_replace_string: STRING) is
			-- Replace in all classes in the system all class name
			-- `a_search_string' occurrences of `a_search_string' with `a_replace_string'.
		require
			a_search_string_not_void: a_search_string /= Void
			a_replace_string_not_void: a_replace_string /= Void
		local
			cur: CURSOR
			classes: HASH_TABLE [CLASS_I, STRING]
			clusters: LIST [CLUSTER_I]
			cl: LINKED_LIST [CLASS_I]
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
					cl.extend (classes.item_for_iteration)
					classes.forth
				end
				clusters.forth
			end
			clusters.go_to (cur)
			Progress_dialog.set_title ("Renaming in universe")
			perform_replacing (cl, a_search_string, a_replace_string)
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

	perform_replacing (cl: LIST [CLASS_I]; s, r: STRING) is
			-- Perform search/replace on `cl'.
		do
			Progress_dialog.set_title ("Progress")
			Progress_dialog.set_degree ("Renaming:")
			Progress_dialog.set_current_degree (s + " to " + r)
			Progress_dialog.set_entity ("Class:")
			Progress_dialog.set_to_go_label ("Classes to go:")
			Progress_dialog.set_to_go (cl.count.out)
			Progress_dialog.disable_cancel
			Progress_dialog.start (cl.count)
			from
				cl.start
			until
				cl.after
			loop
				Progress_dialog.set_current_entity (cl.item.name_in_upper)
				Progress_dialog.set_value (cl.index)
				Progress_dialog.set_to_go ((cl.count - cl.index).out)
				search_replace (cl.item, s, r)
				cl.forth
			end
			Progress_dialog.hide
		end

	search_replace (a_class: CLASS_I; a_search_string, a_replace_string: STRING) is
			-- Replace in `a_class' all class name occurrences of
			-- `a_search_string' with `a_replace_string'.
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
			
		do
			create ctm.make (a_class)
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
					ctm.commit_modification
					ctm.reset_date
				end
			end
		end

end -- class CLASS_NAME_REPLACER
