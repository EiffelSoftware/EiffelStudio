
class PASS3

inherit

	PASS
		redefine
			changed_classes
		end

creation

	make

feature

	changed_classes: LINKED_LIST [PASS3_C];

	level: INTEGER is 3;

	new_controler (a_class: CLASS_C): PASS3_C is
		do
			!!Result.make (a_class)
		end;

end
