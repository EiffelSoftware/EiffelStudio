-- `dynamic' option to specify whether a feature call might be
-- statically bound or not in the DR-system of DLE.

class DYNAMIC_ALL_I inherit

	DYNAMIC_I
		redefine
			is_all
		end

feature -- Status report

	is_all: BOOLEAN is
			-- Must all features of the current class be dynamically bound?
		do
			Result := true
		end;

	is_dynamic (feat_name: STRING): BOOLEAN is
			-- Must feature `feat_name' be dynamically bound?
		do
			Result := true
		end;

end -- class DYNAMIC_ALL_I
