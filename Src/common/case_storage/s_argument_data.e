indexing

	description: "Feature argument.";
	date: "$Date$";
	revision: "$Revision$"

class S_ARGUMENT_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE} -- Initialization

	make (i: STRING; t: like type) is
			-- Set id to `s' and set
			-- type to `t'.
		require
			valid_id: i /= Void; 
			valid_t:  t /= Void 
		do
			id := i;
			type := t
		ensure
			set: id = i and then type = t
		end;

feature -- Properties

	id: STRING;
			-- Id of Current	

	type: S_TYPE_INFO;
			-- Argument type

invariant

	valid_id: id /= Void;
	valid_type: type /= Void

end -- class S_ARGUMENT_DATA
