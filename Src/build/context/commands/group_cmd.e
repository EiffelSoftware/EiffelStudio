
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

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	old_contexts: LINKED_LIST [CONTEXT];

	cut_old_command: CONTEXT_CUT_CMD;

	c_name: STRING is
		do
			Result := Command_names.cont_group_cmd_name
		end;

feature 

	destroy_widgets is
		do
			cut_old_command.destroy_widgets;
			from
				old_contexts.start
			until
				old_contexts.after
			loop
				old_contexts.item.widget.destroy
				old_contexts.forth
			end;
			context.widget.destroy
		end;

	group_create (group_c: GROUP_C; contexts: LINKED_LIST [CONTEXT]) is
		local
			list: LINKED_LIST [CONTEXT];
			found: BOOLEAN;
			new_contexts: LINKED_LIST [CONTEXT];
		do
			contexts.start;
			old_contexts := contexts.duplicate (contexts.count);
			new_contexts := group_c.subtree;

			save_widgets (new_contexts);

			context := group_c;
			parent ?= group_c.parent;

				-- Cut the grouped elements
			!! cut_old_command;
			cut_old_command.work (old_contexts.first);

			from
				new_contexts.start
			until
				new_contexts.after
			loop
				new_contexts.item.remove_callbacks;
				new_contexts.forth
			end;

			change_widgets;
				-- Erase the new elements
			group_c.hide_tree_elements;
			!!new_contexts.make;
				--merge empties the group_c subtree list
			new_contexts.merge_right (group_c.subtree);
				-- Reset parent
			from
				old_contexts.start
			until
				old_contexts.after
			loop
				old_contexts.item.set_parent (group_c);
				group_c.add_group_child (old_contexts.item);
				old_contexts.forth
			end;
				-- undo cut on old_contexts
			undo_cut_old_contexts;

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
			undo_cut_old_contexts;
			parent.show_tree_elements;
			tree.display (old_contexts.first);
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
					-- change widget_attributes set parent
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
			undo_cut_old_contexts;
			parent.show_tree_elements;
			tree.display (old_contexts.first);
			mp.restore
		end;

	
feature {NONE}

	change_widgets is
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

	undo_cut_old_contexts is
		local
			list: LINKED_LIST [CONTEXT]
		do
			from
				list := cut_old_command.context_list;
				list.start
			until
				list.after
			loop
				list.item.undo_cut;
				list.forth
			end;
		end;

	widget_table: HASH_TABLE [WIDGET, CONTEXT];

	save_widgets (a_list: LINKED_LIST [CONTEXT]) is
		local
			found: BOOLEAN;
		do
			!!widget_table.make (5);
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
