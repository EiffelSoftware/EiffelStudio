
class CONTEXT_CUT_CMD 

inherit

	WINDOWS;
	CONTEXT_CMD
		redefine
			work, undo, redo
		end;

feature {GROUP_CMD, HISTORY_WND}

	destroy_widgets is
			-- This is called by the history mechanism 
			-- before it is removed from the list so 
			-- the contexts can free the external widgets.
		do
			from
				context_list.start
			until
				context_list.after
			loop
				context_list.item.widget.destroy;
				context_list.forth
			end
		end;

feature {GROUP_CMD}

	context_list: LINKED_LIST [CONTEXT];

feature {NONE}

	set_parent_contexts: LINKED_LIST [CONTEXT];
		-- Contexts deleted

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_cut_cmd_name
		end;

	parent: COMPOSITE_C;

feature 

	work (argument: CONTEXT) is
			-- Do not record into history
		do
			context := argument;
			parent ?= context.parent;
			if (context.parent = Void) or else not context.parent.is_in_a_group then
					-- a group can be destroyed but not its content
				!!context_list.make;
				!!set_parent_contexts.make;
				if context.grouped then
					set_parent_contexts.merge_right (context.group);
					from
						set_parent_contexts.start
					until
						set_parent_contexts.after
					loop
						context_list.merge_right 
								(set_parent_contexts.item.cut_list);
						set_parent_contexts.forth;
					end;
				else
					context_list.merge_right (context.cut_list);
					set_parent_contexts.put_front (context)
				end;
				redo;
			else
				failed := True
			end;
		end;

	undo is
		do
			from
				set_parent_contexts.start
			until
				set_parent_contexts.after
			loop
				set_parent_contexts.item.set_parent (parent);
				set_parent_contexts.forth;
			end;
			from
				context_list.start
			until
				context_list.after
			loop
				context_list.item.undo_cut;
				context_list.forth;
			end;
			tree.display (context);
		end;

	redo is
		do
			from
				context_list.start
			until
				context_list.after
			loop
				context_list.item.cut;
				context_list.forth;
			end;
			from
				set_parent_contexts.start
			until
				set_parent_contexts.after
			loop
				set_parent_contexts.item.set_parent (Void);
				set_parent_contexts.forth;
			end;
			if parent = Void then
				tree.display (context)
			else
				tree.display (parent)
			end;
		end;

	
feature {NONE}

	context_work is
		do
		end;

	context_undo is
		do
		end;

end
