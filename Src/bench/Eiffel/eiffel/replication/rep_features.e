class REP_FEATURES 

inherit

	EXTEND_TABLE [FEATURE_AS_B, INTEGER]
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

	class_id: INTEGER;
		-- Class id where features are replicated

	set_class_id (i: INTEGER) is
		do
			class_id := i
		end;

	make (i: INTEGER; ci: INTEGER) is
			-- Make Current with `i' items and with
			-- class_id `ci'.
		do
			et_make (i);
			class_id := ci;
		end;

end
