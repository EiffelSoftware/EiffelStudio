deferred class TREE_HOLE

inherit

	HOLE
         undefine
             process_context
 		select
			init_toolkit
		end;
	EB_BUTTON 

feature {NONE}


	make (a_parent: COMPOSITE) is
		do
			make_visible (a_parent);
			register
		end;

	target: WIDGET is
		do
			Result := Current;
		end;

	stone_type: INTEGER is
		do
			Result := Stone_types.context_type
		end;

end
