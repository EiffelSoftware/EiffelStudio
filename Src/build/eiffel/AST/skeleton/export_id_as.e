-- Node for single exported feature (no restriction)

class EXPORT_ID_AS

inherit

	EXPORT_AS

feature -- Attributes

	feature_name: FEATURE_NAME;
			-- Exported feature name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void;
		end;

end
