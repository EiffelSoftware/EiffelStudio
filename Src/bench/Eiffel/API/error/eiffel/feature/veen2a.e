-- Error when a result entity in used in a precondition

class VEEN2A 

inherit

	VEEN
		redefine
			build_explain
		end;

feature

	build_explain is
		do
			put_string ("Identifier: Result%N")
		end;
end
