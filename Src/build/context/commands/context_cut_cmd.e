
class CONTEXT_CUT_CMD 

inherit

	WINDOWS
		export
			{NONE} all
		end;
	CONTEXT_CMD
		redefine
			work, undo, redo
		
		end;
	EDITOR_FORMS
		export
			{NONE} all
		end;
	COMMAND_NAMES
		rename
			C_ut_cmd_name as c_name
		export
			{NONE} all
		end;
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end



	
feature {NONE}

	dispose is
		require else
			deleted_context_not_void: deleted_contexts /= Void;
		do
			if not group_uncreated then
				from
					deleted_contexts.start
				until
					deleted_contexts.after
				loop
					if deleted_contexts.item.widget /= void then
						deleted_contexts.item.widget.destroy;
						deleted_contexts.forth;
					end;
				end;
			end
		end;

	associated_form: INTEGER is
		do
			Result := geometry_form_number
		end;

	group_uncreated: BOOLEAN;

	
feature {GROUP_CMD}
	
	set_group_uncreated (flag: BOOLEAN) is
		do
			group_uncreated := flag;
		end;
feature 

	context_list: LINKED_LIST [CONTEXT];

	
feature {NONE}

	deleted_contexts: LINKED_LIST [CONTEXT];

	parent: COMPOSITE_C;

	
feature 

	work (argument: CONTEXT) is
		local
			void_parent: COMPOSITE_C
		do
			context := argument;
			parent ?= context.parent;
			if (context.parent = Void) or else not context.parent.is_in_a_group then
					-- a group can be destroyed but not its content
				!!context_list.make;
				!!deleted_contexts.make;
				if context.grouped then
					deleted_contexts.merge_right (context.group);
					from
						deleted_contexts.start
					until
						deleted_contexts.after
					loop
						context_list.merge_right (deleted_contexts.item.recursive_cut);
						deleted_contexts.item.set_parent (void_parent);
						deleted_contexts.forth;
					end;
				else
					context_list.merge_right (context.recursive_cut);
					context.set_parent (void_parent);
				end;
			else
				failed := True
			end;
		end;

	undo is
		do
			if deleted_contexts.empty then
				context.set_parent (parent);
			else
				from
					deleted_contexts.start
				until
					deleted_contexts.after
				loop
					deleted_contexts.item.set_parent (parent);
					deleted_contexts.forth;
				end;
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
		local
			void_parent: COMPOSITE_C
		do
			from
				context_list.start
			until
				context_list.after
			loop
				context_list.item.cut;
				context_list.forth;
			end;
			if deleted_contexts.empty then
				context.set_parent (void_parent);
			else
				from
					deleted_contexts.start
				until
					deleted_contexts.after
				loop
					deleted_contexts.item.set_parent (void_parent);
					deleted_contexts.forth;
				end;
			end;
			context.widget.set_managed (False);
			if not (parent = Void) then
				tree.display (parent)
			else
				tree.display (context)
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
