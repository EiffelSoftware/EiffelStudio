
deferred class GROUP_COMPOSITE_C 

inherit

	COMPOSITE_C
		rename
			create_context as old_create_context
		redefine
			is_group_composite, set_size		
		end;

	COMPOSITE_C
		redefine
			create_context, is_group_composite, set_size
		select
			create_context
		end



	
feature 

	is_group_composite: BOOLEAN is
		do
			Result := True
		end;

	create_new_child: CONTEXT is
		do
			Result := context_catalog.toggle_b_type.create_context (Current);
		end;

	create_context (a_parent: COMPOSITE_C): like Current is
			-- Add two children in the group container
			-- after its creation and the insertion in
			-- the history list
		local
			new_context: CONTEXT;
		do
			Result := old_create_context (a_parent);
			new_context := Result.create_new_child;
			new_context := Result.create_new_child;
		end;

	set_size (new_w, new_h: INTEGER) is
            -- Set new size of widget
			-- Create or delete toggle buttons if needed
		local
			children_number: INTEGER;
			new_number: INTEGER;
			command: CONTEXT_CUT_CMD;
			new_context: CONTEXT;
			a_child, previous_child: CONTEXT;
			modification: BOOLEAN;
		do
			widget.set_managed (False);
			widget.set_size (new_w, new_h);
			children_number := arity;
			if children_number = 0 then
					-- Create first child
				children_number := 1;
				new_context := create_new_child;
				modification := True;
			end;
			child_start;
			new_number := new_h // (child.height + 3);
			if (new_number > children_number) then
				from
				until
					children_number = new_number
				loop
					new_context :=  create_new_child;
					children_number := children_number + 1 ;
				end;
				modification := True;
			elseif (new_number >= 1 and then new_number < children_number) then
				from
					child_finish;
					a_child := child
				until
					children_number = new_number
				loop
					previous_child := a_child.left_sibling;
					!!command;
					command.execute (a_child);
					a_child := previous_child;
					children_number := children_number - 1 ;
				end;
				modification := True;
			end;
			if modification then
				realize;
				tree.display (Current);
			end;
			widget.set_managed (True);
		end;

end
