-- `dynamic' option to specify whether a feature call might be
-- statically bound or not in the DR-system of DLE.

deferred class DYNAMIC_I

feature -- Status report

	is_all: BOOLEAN is
			-- Must all features of the current class be dynamically bound?
		do
		end;

	is_no: BOOLEAN is
			-- May the features of the current class be statically bound?
		do
		end;

	is_partial: BOOLEAN is
			-- Must some features of the current class be dynamically bound?
		do
		end;

	is_dynamic (feat_name: STRING): BOOLEAN is
			-- Must feature `feat_name' be dynamically bound?
		require
			feat_name_not_void: feat_name /= Void
		deferred
		end;

end -- class DYNAMIC_I
