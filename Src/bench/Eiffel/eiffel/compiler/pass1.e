
class PASS1

inherit

	SHARED_SERVER;
	PASS
		redefine
			changed_classes
		end

creation

	make

feature -- Access

	changed_classes: LINKED_LIST [PASS1_C];

	Degree_number: INTEGER is 5;

	is_in_tmp_ast_server (a_class: CLASS_C): BOOLEAN is
			-- Is `a_class' ast in the temporary server?
		do
			Result := Tmp_ast_server.has (a_class.id)
		end;

feature -- Element change

	new_controler (a_class: CLASS_C): PASS1_C is
		do
			!!Result.make (a_class)
		end;

	insert_parsed_class (a_class: CLASS_C) is
			-- `a_class' must be processed for the end of degree 1 (parsing
			-- has already been done)
		require
			good_argument: a_class /= Void;
			ast_is_in_server: is_in_tmp_ast_server (a_class)
		local
			pass_c: PASS_C;
		do
			pass_c := controler_of (a_class)
		end;

	insert_changed_class (a_class: CLASS_C) is
		local
			pass1_c: PASS1_C;
		do
			pass1_c ?= controler_of (a_class);
			pass1_c.set_check_suppliers
		end;

end
