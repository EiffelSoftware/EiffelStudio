
class PASS4

inherit

	SORTED_PASS
		redefine
			changed_classes
		end

creation

	make

feature

	changed_classes: SORTED_TWO_WAY_LIST [PASS4_C];

	level: INTEGER is 4;

	new_controler (a_class: CLASS_C): PASS4_C is
		do
			!!Result.make (a_class)
		end;

end
