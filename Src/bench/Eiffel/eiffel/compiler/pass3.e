
class PASS3

inherit

	SORTED_PASS
		redefine
			changed_classes
		end

creation

	make

feature

	changed_classes: SORTED_TWO_WAY_LIST [PASS3_C];

	new_controler (a_class: CLASS_C): PASS3_C is
		do
			!!Result.make (a_class)
		end;

end
