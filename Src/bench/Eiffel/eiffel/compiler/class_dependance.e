-- Description of the supplier of a class: each feature name written in the
-- associated class is associated to a supplier list (list of ids).

class CLASS_DEPENDANCE 

inherit

	EXTEND_TABLE [FEATURE_DEPENDANCE, STRING];
	IDABLE
		undefine
			is_equal, copy
		end;
	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

creation

	make

	
feature 

	id: CLASS_ID;
			-- Id of the associated class

	set_id (i: CLASS_ID) is
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
