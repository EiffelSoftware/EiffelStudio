
class PASS1

inherit

	PASS
		redefine
			changed_classes
		end

creation

	make

feature

	changed_classes: LINKED_LIST [PASS1_C];

	new_controler (a_class: CLASS_C): PASS1_C is
		do
			!!Result.make (a_class)
		end;

	insert_changed_class (a_class: CLASS_C) is
		local
			pass1_c: PASS1_C;
		do
			pass1_c ?= controler_of (a_class);
			pass1_c.set_check_suppliers
		end;

end
