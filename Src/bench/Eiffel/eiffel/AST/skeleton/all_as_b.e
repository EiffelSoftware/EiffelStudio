class ALL_AS_B

inherit

	ALL_AS;

	FEATURE_SET_AS_B

feature -- Initialization

	update (export_adapt: EXPORT_ADAPTATION; export_status: EXPORT_I;
														parent: PARENT_C) is
			-- Update `export_adapt' with `export_status'.
		local
			vlel1: VLEL1;
		do
			if export_adapt.all_export = Void then
				export_adapt.set_all_export (export_status);
			else
				!!vlel1;
				vlel1.set_class (System.current_class);
				vlel1.set_parent (parent.parent);
				Error_handler.insert_error (vlel1);
			end;
		end;

end -- class ALL_AS_B
