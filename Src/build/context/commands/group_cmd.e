
class GROUP_CMD 

inherit

	WINDOWS
	CONTEXT_CMD
		redefine
			work, undo, redo, context
		end;

feature {NONE}

	context: GROUP_C;

	parent: CONTEXT;

	widget_table: HASH_TABLE [WIDGET, CONTEXT];
			-- For each context there is an old_widget (before group)
			-- and new_widget (after grouping). These are stored in
			-- the table and in the context exclusively. Before redo
			-- the table stores the new context wheres the undo
			-- stores the old widgets

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	old_contexts: LINKED_LIST [CONTEXT];
			-- Contexts that were grouped. These contexts
			-- are used before and after grouping with
			-- the widget (in the context) being the only thing
			-- changing for redo/undo
	

	cut_old_command: CONTEXT_CUT_CMD;
			-- Undoable cut command for old_contexts

	c_name: STRING is
		do
			Result := Command_names.cont_group_cmd_name
		end;

feature 

	destroy_widgets is
		do
			context.widget.destroy
		end;

	group_create (group_c: GROUP_C; contexts: LINKED_LIST [CONTEXT]) is
		local
			list: LINKED_LIST [CONTEXT];
			found: BOOLEAN;
			new_contexts: LINKED_LIST [CONTEXT];
		do
			contexts.start;
				-- Duplicate the list since list is referenced
				-- in selection_manager (`grouped' attribute)
			old_contexts := contexts.duplicate (contexts.count);

				-- New contexts created for group
			new_contexts := group_c.subtree;

				-- Each context in `old_context' is inserted into
				-- `widget_table' with widget from `new_contexts'.
			save_widgets (new_contexts);

			context := group_c;
			parent ?= group_c.parent;

				-- Cut the grouped elements
			!! cut_old_command;
			cut_old_command.work (old_contexts.first);

				-- Remove callbacks for the new_widgets
				-- since they are needed to be reseted 
				-- when they are inserted into the old_contexts
				
			from
				new_contexts.start
			until
				new_contexts.after
			loop
				new_contexts.item.remove_callbacks;
				new_contexts.forth
			end;

				-- Change old_context to hold new widgets
				-- and `widget_table' to store old widgets.
			change_widgets;

				-- Erase the new elements
			group_c.hide_tree_elements;

				-- Empty the group_c subtree list
			group_c.subtree.wipe_out;

				-- Use the old context for the new group_c
			from
				old_contexts.start
			until
				old_contexts.after
			loop
				old_contexts.item.set_parent (group_c);
				group_c.add_group_child (old_contexts.item);
				old_contexts.forth
			end;

				-- Undo cut on old_contexts since
				-- they are going to be used for `group_c'.
			undo_cut_old_contexts (True);

				-- Reset the callbacks for the new widgets
				-- that have been inserted into `old_contexts'.
				-- Now both the new and old widgets for `old_contexts'
				-- have there callbacks set.
			from
				old_contexts.start
			until
				old_contexts.after
			loop
				old_contexts.item.reset_callbacks;
				old_contexts.forth
			end;
		end;

	work (argument: ANY) is
		do
			context.select_tree_element_if_parent_selected
		end;

	undo is
		local
			list: LINKED_LIST [CONTEXT];
			cut_new_command: CONTEXT_CUT_CMD;
			mp: MOUSE_PTR
		do
			!!mp;
			mp.set_watch_shape;
			parent.hide_tree_elements;
				--  cut the new group
			!!cut_new_command;
			cut_new_command.work (context);
			context.subtree.wipe_out;

				-- Change old_context to hold old widgets
				-- and `widget_table' to store new widgets.
			change_widgets;
			from
				old_contexts.start
			until
				old_contexts.after
			loop
					-- Reset the parent
				old_contexts.item.set_parent (parent);
				old_contexts.item.set_modified_flags;
					-- Change the widget attributes
				old_contexts.forth
			end;
				-- Restore previous elements
			undo_cut_old_contexts (false);
			parent.show_tree_elements;
			tree.display (old_contexts.first);
			context_catalog.remove_group_type (context.type);
			mp.restore
		end;

	redo is
		local
			mp: MOUSE_PTR
		do
			!!mp;
			mp.set_watch_shape;
			parent.hide_tree_elements;
				-- cut the contexts
			cut_old_command.redo;
				-- undo cut on group_c
			context.set_parent (parent);
			context.undo_cut;
				-- Remove tree element (added by undo_cut) since
				-- `parent.show_tree_elements' below will
				-- add the tree element for context.
			context.remove_tree_element;

				-- Change old_context to hold new widgets
				-- and `widget_table' to store old widgets.
			change_widgets;

			from
				old_contexts.start
			until
				old_contexts.after
			loop
					-- Reset the parent
				old_contexts.item.set_parent (context);
				old_contexts.item.reset_modified_flags;
					-- Change the widget attributes
					-- Reset the group_c list
				context.add_group_child (old_contexts.item);
				old_contexts.forth
			end;
			undo_cut_old_contexts (false);
			parent.show_tree_elements;
			tree.display (old_contexts.first);
			context_catalog.add_new_group (context.group_type);
			context.select_tree_element_if_parent_selected;
			mp.restore
		end;

	
feature {NONE}

	change_widgets is
			-- For each context in `widget_table' replace widget in
			-- context with entry in `widget_table' and replace widget
			-- in `widget_table' with context old widget.
		do
			from
				widget_table.start
			until
				widget_table.off
			loop
				widget_table.key_for_iteration.change_widget (widget_table);
				widget_table.forth
			end;
		end;

	undo_cut_old_contexts (add_tree_element: BOOLEAN) is
		local
			list: LINKED_LIST [CONTEXT];
			group_c: GROUP_C
		do
			from
				list := cut_old_command.context_list;
				list.start
			until
				list.after
			loop
				list.item.undo_cut;
				if add_tree_element then
					group_c ?= list.item;
					if group_c /= Void then
						group_c.group_type.decrement_counter
					end
				else
					list.item.remove_tree_element
				end;
				list.forth
			end;
		end;

	save_widgets (a_list: LINKED_LIST [CONTEXT]) is
			-- Save `a_list' into `widget_table'.
			-- Each context in `old_context' is inserted into
			-- `widget_table' with widget from `a_list'.
		local
			found: BOOLEAN;
		do
			!! widget_table.make (5);
			from
				old_contexts.start;
			until
				old_contexts.after
			loop
				from
					a_list.start
				until
					a_list.after or found
				loop
					if a_list.item.entity_name.is_equal (old_contexts.item.entity_name) then
						old_contexts.item.save_widget (a_list.item, widget_table);
						found := True;
					end;
					a_list.forth
				end;
				found := False;
				old_contexts.forth
			end;
		end;

	context_undo is do end;

	context_work is do end;

end
