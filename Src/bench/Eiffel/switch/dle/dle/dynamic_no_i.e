-- `dynamic' option to specify whether a feature call might be
-- statically bound or not in the DR-system of DLE.

class DYNAMIC_NO_I inherit

	DYNAMIC_I
		redefine
			is_no
		end

feature -- Status report

	is_no: BOOLEAN is
			-- May the features of the current class be statically bound?
		do
			Result := true
		end;

	is_dynamic (feat_name: STRING): BOOLEAN is
			-- Must feature `feat_name' be dynamically bound?
		do
		end;

end -- class DYNAMIC_NO_I
