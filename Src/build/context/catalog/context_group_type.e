

class CONTEXT_GROUP_TYPE 

inherit

	CONTEXT_TYPE
		rename
			make as context_type_create
		redefine
			dummy_context
		end


creation

	make

	
feature 

	make (a_name: STRING; a_context: GROUP_C) is
			-- create a context type associated with `a_context'
		do
			dummy_context := a_context;
			focus_string := a_name;
			identifier := group.identifier;
		end;

	
feature {NONE}

	dummy_context: GROUP_C;
			-- Reference to a context, descendant of current type

	
feature 

	group: GROUP is
		do
			Result := dummy_context.group_type
		end;

end
