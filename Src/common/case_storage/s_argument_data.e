class S_ARGUMENT_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE}

	make (i: STRING; t: like type) is
			-- Set id to `s' and set
			-- type to `t'.
		require
			both_not_void: id = Void implies t /= Void and then
						t = Void implies id /= Void
		do
			id := i;
			type := t
		ensure
			id_set: i = id;
			type_set: type = t;
		end;

feature 

	id: STRING;
			-- Id of Current	

	type: S_TYPE_INFO;
			-- Type of Current

end
