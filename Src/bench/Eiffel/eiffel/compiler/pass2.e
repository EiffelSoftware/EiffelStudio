
class PASS2

inherit

	SHARED_WORKBENCH;
	SHARED_HISTORY_CONTROL;
	SORTED_PASS
		rename
			execute as old_execute
		redefine
			changed_classes
		end;
	SORTED_PASS
		redefine
			changed_classes, execute
		select
			execute
		end

creation

	make

feature

	changed_classes: SORTED_TWO_WAY_LIST [PASS2_C];

	level: INTEGER is 2;

	new_controler (a_class: CLASS_C): PASS2_C is
		do
			!!Result.make (a_class)
		end;

	execute is
			-- Inheritance anlysis on the changed classes. Since the
			-- classes contained in `changed_classes' are sorted by class
			-- id's, it ensures that a class will be treated here once
			-- the treatment of its parents is completed. That's why
			-- we re-sort the list `changed_class' after the topological
			-- sort in order to take advantage of it.
		do
			old_execute;

				-- Transfer history controler data on disk
			history_control.transfer;
		end;

	set_expanded_modified (a_class: CLASS_C) is
			-- The expanded status of `a_class' has been modified
		local
			pass_c: PASS2_C;
		do
			pass_c ?= controler_of (a_class);
			pass_c.set_expanded_modified
		end;

	set_deferred_modified (a_class: CLASS_C) is
			-- The deferred status of `a_class' has been modified
		local
			pass_c: PASS2_C;
		do
			pass_c ?= controler_of (a_class);
			pass_c.set_deferred_modified
		end;

end
