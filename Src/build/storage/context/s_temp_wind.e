

class S_TEMP_WIND 

inherit

	S_BULLETIN
		undefine
			make
		redefine
			set_context_attributes, context
		end


creation

	make

	
feature 

	make (node: TEMP_WIND_C) is
		do
			save_attributes (node);
			if node.title_modified then
				title := node.title
			end;
			resize_policy_disabled := node.resize_policy_disabled;
			resize_policy_modified := node.resize_policy_modified;
		end;

	context (a_parent: COMPOSITE_C): TEMP_WIND_C is
		local
			void_composite_c: COMPOSITE_C;
		do
			!!Result;
			create_context (Result, void_composite_c);
		end;

	set_context_attributes (a_context: PERM_WIND_C) is
		do
			if not (title = Void) then
				a_context.set_title (title)
			end;
			if resize_policy_modified then
				a_context.disable_resize_policy (resize_policy_disabled)
			end;
			set_attributes (a_context);
		end;

	
feature {NONE}

	title: STRING;

	resize_policy_disabled: BOOLEAN;

	resize_policy_modified: BOOLEAN;

end

