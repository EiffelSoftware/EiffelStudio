indexing

	description: "Node for Eiffel feature name. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class FEAT_NAME_ID_AS_B

inherit

	FEAT_NAME_ID_AS
		undefine
			temp_name, associated_feature_name
		redefine
			feature_name, internal_name, infix "<"
		end;

	FEATURE_NAME_B

feature -- Attributes

	feature_name: ID_AS_B;
			-- Feature name

feature -- Conveniences

	internal_name: ID_AS_B is
			-- Internal name used by the compiler
		do
			Result := feature_name
		end;

	infix "<" (other: FEATURE_NAME_B): BOOLEAN is
		local
			normal_feature: like Current;
			infix_feature: INFIX_AS_B;
		do
			normal_feature ?= other;
			infix_feature ?= other;
			check
				void_normal_feature: normal_feature = void implies infix_feature /= Void
				void_infix_feature: infix_feature = void implies normal_feature /= Void
			end

			if infix_feature /= void then
				Result := true
			elseif feature_name = Void then
				Result := False
			elseif normal_feature.feature_name = Void then
				Result := True
			else
				Result := feature_name < normal_feature.feature_name
			end;
		end;
		
end -- class FEAT_NAME_ID_AS_B
