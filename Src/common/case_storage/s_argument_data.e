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
			valid_id: i /= Void; 
			valid_t:  t /= Void 
		do
			id := i;
			type := t
		end;

feature 

	id: STRING;
			-- Id of Current	

	type: S_TYPE_INFO;
			-- Type of Current

invariant

	valid_id: id /= Void;
	valid_type: type /= Void

end
