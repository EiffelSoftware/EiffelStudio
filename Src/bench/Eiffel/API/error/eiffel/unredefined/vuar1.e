-- Error for calling a feature with the wrong number of arguments

class VUAR1 

inherit

	VUAR
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 1;

	build_explain is
		do
			print_called_feature;
		end;

end
