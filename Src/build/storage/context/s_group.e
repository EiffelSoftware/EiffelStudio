

class S_GROUP 

inherit

	S_BULLETIN
		rename
			set_context_attributes as old_set_context_attributes
		undefine
			make, context
		end;

	S_BULLETIN
		undefine
			make
		redefine
			set_context_attributes, context
		select
			set_context_attributes
		end

creation

	make

	
feature 

	make (node: GROUP_C) is
		local
			context_list: LINKED_LIST [CONTEXT];
		do
			save_attributes (node);
			group_type := node.group_type.identifier;
			!!subtree.make (50);
			context_list := node.subtree;
			from
				context_list.start
			until
				context_list.after
			loop
				store_context (context_list.item);
				context_list.forth
			end;
			subtree.trim;
		end;

	context (a_parent: COMPOSITE_C): GROUP_C is
			-- Create the group by creating the
			-- saved group type first and then
			-- modifying the attributes
		do
			!!Result;
			create_context (Result, a_parent);
			Result.set_type_identifier (group_type);
		end;

	set_context_attributes (a_context: GROUP_C) is
		local
			context_list: LINKED_LIST [CONTEXT];
		do
				-- retrieve the modified attributes
			old_set_context_attributes (a_context);

			context_list := a_context.subtree;
			from
				context_list.start
			until
				context_list.after
			loop
				retrieve_attributes (context_list.item);
				context_list.forth
			end;
		end;

	set_group_type (new_type: INTEGER) is
			-- Used by the import mechanism
		do
			group_type := new_type
		end;

	
feature {NONE}

	subtree: EB_TABLE [S_CONTEXT];

	
feature 

	group_type: INTEGER;

	
feature {NONE}

	store_context (a_context: CONTEXT) is
			-- Store the s_context associated with
			-- a_context in the store_context
		do
			subtree.put (a_context.stored_node);
			from
				a_context.child_start
			until
				a_context.child_offright
			loop
				store_context (a_context.child);
				a_context.child_forth;
			end;
		end;

	retrieve_attributes (a_context: CONTEXT) is
		local
			i: INTEGER;
			found: BOOLEAN;
			s_context: S_CONTEXT;
		do
			from
				i := 1
			until
				i > subtree.count or found
			loop
				s_context :=  subtree.item (i);
				if s_context.internal_name.is_equal (a_context.entity_name) then
					found := True
				else
					i := i + 1
				end;
			end;
if not found then
	io.putstring ("Problem in group retrieve%N%N");
end;
			s_context.set_context_attributes (a_context);
			from
				a_context.child_start
			until
				a_context.child_offright
			loop
				retrieve_attributes (a_context.child);
				a_context.child_forth;
			end;
		end;

end

