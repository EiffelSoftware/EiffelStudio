-- Description of the supplier of a class: each feature name written in the
-- associated class is associated to a supplier list (list of ids).

class CLASS_DEPENDANCE 

inherit

	HASH_TABLE [SORTED_SET [DEPEND_UNIT], STRING];
	IDABLE
		undefine
			twin
		end;
	SHARED_WORKBENCH
		undefine
			twin
		end

creation

	make

	
feature 

	id: INTEGER;
			-- Id of the associated class

	set_id (i: INTEGER) is
			-- Assign `i' to `id'.
		do
			id := i;
		end; -- set_id

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (id);
		end;

end
