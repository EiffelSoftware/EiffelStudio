deferred class FEATURE_SET_AS_B

inherit

	FEATURE_SET_AS;

	AST_EIFFEL_B

feature -- Export status computing

	update (	export_adapt: EXPORT_ADAPTATION;
				export_status: EXPORT_I;
				parent: PARENT_C)
		is
			-- Update `export_adapt' with `export_status'.
		require
			good_argument1: export_adapt /= Void;
			good_argument2: export_status /= Void;
		deferred
		end;

end -- class FEATURE_SET_AS_B
