

class S_GROUP 

inherit

	S_BULLETIN
		rename
			set_context_attributes as old_set_context_attributes
		redefine
			make, context, trace
		end;

	S_BULLETIN
		undefine
			make
		redefine
			set_context_attributes, context, trace
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
			!! subtree.make (10);
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
			index, counter: INTEGER;
			rescued: BOOLEAN
		do
			if not rescued then
					-- retrieve the modified attributes
				old_set_context_attributes (a_context);

				context_list := a_context.subtree;
				from
					index := 1;
					counter := 1
					context_list.start
				until
					context_list.after
				loop
					index := retrieve_attributes (context_list.item, index);
					context_list.forth
					counter := counter + 1;
					index := index + 1
				end;
			else
				rescued := False
			end;
		rescue
			rescued := True;
			retry
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

	retrieve_attributes (a_context: CONTEXT; index: INTEGER): INTEGER is
		local
			i, id: INTEGER;
			found: BOOLEAN;
			s_context: S_CONTEXT;
		do
			Result := index;
			debug ("STORER")
				io.error.putstring ("setting attributes for context: ");
				io.error.putstring (a_context.full_name)
				io.error.new_line;
			end;
			s_context := subtree.item (Result);
				-- To indicate on the context side that we
				-- are retrieving from disk
			a_context.set_retrieved_node (s_context);
			s_context.set_context_attributes (a_context);
			a_context.set_retrieved_node (Void);
				-- Update the visual name
			if s_context.visual_name /= Void then
				a_context.set_visual_name (s_context.visual_name)
			end;
				-- Update identifier in a_context and in context_table
			id := s_context.identifier;
			if not for_import.item then
				a_context.set_identifier (s_context.identifier);
			end;
			debug ("STORER_CHECK")
				if context_table.has (a_context.identifier) and then
					(context_table.item (a_context.identifier) /= a_context)
				then
					io.error.putstring ("**** 2 Error: Context already exists: ");
					io.error.putstring (a_context.full_name);
					io.error.putstring (" new id: ")
					io.error.putint (a_context.identifier);
					io.error.putstring (" old id: ")
					io.error.putint (id);
					io.error.putstring (" ****");
					io.error.new_line
				else
					io.error.putstring ("%TCT put (in group)");
					io.error.putstring (a_context.full_name);
					io.error.putstring (" new id: ")
					io.error.putint (a_context.identifier);
					io.error.putstring (" old id: ")
					io.error.putint (id);
					io.error.new_line
				end
			end
				-- Store the old id.
			context_table.put (a_context, id);
			debug ("STORER")
				io.error.putstring ("In c_table: s_cont: ");
				io.error.putstring (s_context.internal_name);
				io.error.putstring ("cont: ");
				io.error.putstring (a_context.entity_name);
				io.error.new_line
			end;
			from
				a_context.child_start
			until
				a_context.child_offright
			loop
				Result := Result + 1;
				Result := retrieve_attributes (a_context.child, Result);
				a_context.child_forth;
			end
		end;

feature -- Debugging

	trace is
		local
			counter: INTEGER
		do
			if full_name /= Void then
				io.error.putstring ("fn: ");
				io.error.putstring (full_name);
			end;
			io.error.putstring (" int: ");
			io.error.putstring (internal_name);
			io.error.putstring (" id: ");
			io.error.putint (identifier);
			if visual_name /= Void then
				io.error.putstring (" vn: ");
				io.error.putstring (visual_name);
			end
			if subtree.count > 0 then
				from
					counter := 1;
				until
					counter > subtree.count
				loop
					io.error.putstring ("%N%T");
					subtree.item (counter).trace;
					counter := counter + 1
				end
			end
		end;

feature {GROUP, S_GROUP}

	update_group_within_group_id (group_table: INT_H_TABLE [INTEGER]) is
			-- Recursive call update_group_within_group_id for groups.
		local
			saved_group: S_GROUP;
			i: INTEGER;
		do
			from
				i := 1
			until
				i > subtree.count
			loop
				saved_group ?= subtree.item (i);
				if (saved_group /= Void) then
					saved_group.set_group_type (group_table.item 
								(saved_group.group_type));
					saved_group.update_group_within_group_id (group_table);
				end;
				i := i + 1;
			end;
		end;


end

