-- Simple type reference class

deferred class CLASS_REF_B 

inherit

	CLASS_C
		redefine
			check_validity
		end;
	SPECIAL_CONST

feature 

	check_validity is
			-- Check validity of a simple type reference class.
		local
			skelet: SKELETON;
			special_error: SPECIAL_ERROR;
		do
				-- First, no generics
			if generics /= Void then
				!!special_error.make (Case_15, Current);
				Error_handler.insert_error (special_error);
			end;
			skelet := types.first.skeleton
			if skelet.count /= 1 or else not valid (skelet.first) then
				!!special_error.make (Case_15, Current);
				Error_handler.insert_error (special_error);
			end;
				-- No creation procedure in such classes
			if not (creators = Void) then
				!!special_error.make (Case_16, Current);
				Error_handler.insert_error (special_error);
			end;
		end;

	valid (desc: ATTR_DESC): BOOLEAN is
			-- Valididty test for unique attribute of class\
		require
			desc_exists: desc /= Void
		deferred
		end;

end
