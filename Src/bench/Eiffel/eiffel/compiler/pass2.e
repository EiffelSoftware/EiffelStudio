
class PASS2

inherit

	SHARED_WORKBENCH;
	SORTED_PASS
		rename
			execute as old_execute,
			make as old_make
		redefine
			changed_classes
		end;
	SORTED_PASS
		redefine
			changed_classes, execute, make
		select
			execute, make
		end

creation

	make

feature

	changed_classes: SORTED_TWO_WAY_LIST [PASS2_C];

	changed_status: SORTED_SET [INTEGER];
			-- Sorted set of all the classes for which the expanded
			-- or deferred status has changed
		
	make is
		do
			old_make;
			!!changed_status.make;
		end;

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
			changed_status.wipe_out;
		end;

	set_expanded_modified (a_class: CLASS_C) is
			-- The expanded status of `a_class' has been modified
		require
			good_argument: a_class /= Void
		local
			pass_c: PASS2_C;
		do
			pass_c ?= controler_of (a_class);
			pass_c.set_expanded_modified
		end;

	set_deferred_modified (a_class: CLASS_C) is
			-- The deferred status of `a_class' has been modified
		require
			good_argument: a_class /= Void
		local
			pass_c: PASS2_C;
		do
			pass_c ?= controler_of (a_class);
			pass_c.set_deferred_modified
		end;

	set_supplier_status_modified (a_class: CLASS_C) is
			-- The status of a supplier has changed
		require
			good_argument: a_class /= Void
		local
			pass_c: PASS2_C
		do
			pass_c ?= controler_of (a_class);
			pass_c.set_supplier_status_modified;
			pass_c.set_new_compilation;
		end;

	add_changed_status (a_class: CLASS_C) is
			-- Record `a_class.id' in `changed_status'
		require
			good_argument: a_class /= Void
		do
			set_supplier_status_modified (a_class);
			changed_status.add (a_class.id)
		end;

feature -- Dino stuff

	set_assertion_prop_list (a_class: CLASS_C; l: LINKED_LIST [INTEGER]) is
		local
			pass_c: PASS2_C
		do
			pass_c ?= controler_of (a_class);
			pass_c.set_assertion_prop_list (l);
		end;
 
end
