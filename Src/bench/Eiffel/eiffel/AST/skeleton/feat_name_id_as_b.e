-- Node for Eiffel feature name

class FEAT_NAME_ID_AS

inherit

	FEATURE_NAME

feature -- Attributes

	feature_name: ID_AS;
			-- Feature name

feature -- Conveniences

	internal_name: ID_AS is
			-- Internal name used by the compiler
		do
			Result := feature_name
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
			is_frozen := yacc_bool_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void
		end

end
