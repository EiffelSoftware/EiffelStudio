

class S_MENU_PULL 

inherit

	S_CONTEXT
		redefine
			set_context_attributes
		end


creation

	make

	
feature 

	make (node: MENU_PULL_C) is
		do
			save_attributes (node);
			title := node.title;
			if node.text_modified then
				text := node.text;
			end;
		end;

	context (a_parent: COMPOSITE_C): MENU_PULL_C is
		do
			!!Result;
			create_context (Result, a_parent);
		end;

	set_context_attributes (a_context: MENU_PULL_C) is
		do
			if not (title = Void) then
				a_context.set_title (title)
			end;
			if not (text = Void) then
				a_context.set_text (text)
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	title, text: STRING;

end

