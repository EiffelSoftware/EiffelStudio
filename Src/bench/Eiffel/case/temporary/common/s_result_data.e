indexing

	description: 
		"Data representing the declaration of result types for features.";
	date: "$Date$";
	revision: "$Revision $"

class S_RESULT_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE} -- Initialization

	make (txt: STRING; t: like type) is
			-- Set id to `s' and set
			-- type to `t'.
		require
			t_not_viod: t /= Void 
		do
			text := txt;
			type := t
		ensure
			id_set: text = txt;
			type_set: type = t
		end;

feature -- Properties

	text: STRING;
			-- Text of Current (for bon eg (n)).

	type: S_TYPE_INFO;
			-- Type of Current

invariant

	has_type: type /= Void

end -- class S_RESULT_DATA
