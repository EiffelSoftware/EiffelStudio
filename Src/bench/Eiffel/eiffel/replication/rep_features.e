class REP_FEATURES 

inherit

	EXTEND_TABLE [FEATURE_AS, BODY_ID]
		rename
			make as et_make
		end;

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			copy, is_equal
		end;

creation

	make

feature

	class_id: CLASS_ID;
		-- Class id where features are replicated

	set_class_id (i: CLASS_ID) is
		do
			class_id := i
		end;

	make (i: INTEGER; ci: CLASS_ID) is
			-- Make Current with `i' items and with
			-- class_id `ci'.
		do
			et_make (i);
			class_id := ci;
		end;

end
