indexing

	description: "Node for Eiffel feature name.";
	date: "$Date$";
	revision: "$Revision$"

class FEAT_NAME_ID_AS

inherit

	FEATURE_NAME

feature -- Attributes

	feature_name: ID_AS;
			-- Feature name

feature -- Conveniences

	internal_name: like feature_name is
			-- Internal name used by the compiler
		do
			Result := feature_name
		end;

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			normal_feature: like Current;
			infix_feature: INFIX_AS;
		do
			normal_feature ?= other;
			infix_feature ?= other;
			
			if infix_feature /= void then
				Result := true
			else
				check
					normal_feature /= void
				end;
				Result := feature_name < normal_feature.feature_name
			end;
		end;
		

feature -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
			is_frozen := yacc_bool_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void
		end;

	set_name (s: STRING) is
		do
			!!feature_name.make (0);
			feature_name.load (s);
		end;
		

end -- class FEAT_NAME_ID_AS
