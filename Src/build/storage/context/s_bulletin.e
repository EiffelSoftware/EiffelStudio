

class S_BULLETIN 

inherit

	S_CONTEXT


creation

	make

	
feature 

	make (node: CONTEXT) is
		do
			if not (node = Void) then
				save_attributes (node);
			end;
		end;

	save_group_attributes (w, h, nb_children: INTEGER) is
		do
			internal_name := "";
			identifier := 1;
			arity := nb_children;
			width := w;
			height := h;
			size_modified := True;
			position_modified := False;
			x := 0;
			y := 0;
		end;

	context (a_parent: COMPOSITE_C): CONTEXT is
		local
			bulletin_c: BULLETIN_C
		do
			!!bulletin_c;
			create_context (bulletin_c, a_parent);
			Result := bulletin_c;
		end;

end

