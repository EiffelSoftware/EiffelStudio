-- Error when a result entity in used in a precondition

class VEEN2A 

inherit

	VEEN
		redefine
			build_explain, subcode
		end;

feature

	subcode: INTEGER is 21;

	build_explain is
		do
		end;
end
