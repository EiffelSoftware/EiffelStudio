class S_RESULT_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature {NONE}

	make (txt: STRING; t: like type) is
			-- Set id to `s' and set
			-- type to `t'.
		require
			both_not_void: txt = Void implies t /= Void and then
						t = Void implies txt /= Void
		do
			text := txt;
			type := t
		ensure
			id_set: text = txt;
			type_set: type = t
		end;

feature 

	text: STRING;
			-- Text of Current (for bon eg (n)).

	type: S_TYPE_INFO;
			-- Type of Current

end
