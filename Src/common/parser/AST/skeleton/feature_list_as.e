class FEATURE_LIST_AS

inherit

	FEATURE_SET_AS

feature -- Attributes

	features: EIFFEL_LIST [FEATURE_NAME];
			-- List of feature names

feature -- Initialization

	set is
			-- Yacc initialization
		do
			features ?= yacc_arg (0);
		end;

feature -- Export status computing

	update (	export_adapt: EXPORT_ADAPTATION;
				export_status: EXPORT_I;
				parent: PARENT_C)
		is
			-- Update `export_adapt' with `export_status'.
		local
			feature_name: STRING;
			vlel3: VLEL3;
		do
			from
				features.start
			until
				features.offright
			loop
				feature_name := features.item.internal_name;
				if not export_adapt.has (feature_name) then
					export_adapt.put (export_status, feature_name);
				else
					!!vlel3;
					vlel3.set_class_id (System.current_class.id);
					vlel3.set_parent_id (parent.parent_id);
					vlel3.set_feature_name (feature_name);
					Error_handler.insert_error (vlel3);
				end;
				features.forth;
			end;
		end;

end
