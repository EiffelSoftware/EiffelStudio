indexing

	description: 
		"AST representation of Eiffel feature name.";
	date: "$Date$";
	revision: "$Revision$"

class FEAT_NAME_ID_AS

inherit

	FEATURE_NAME
		redefine
			is_equivalent
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			feature_name ?= yacc_arg (0);
			is_frozen := yacc_bool_arg (0);
		ensure then
			feature_name_exists: feature_name /= Void
		end;

feature -- Properties

	feature_name: ID_AS;
			-- Feature name

	internal_name: like feature_name is
			-- Internal name used by the compiler
		do
			Result := feature_name
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := is_frozen = other.is_frozen and then
				equivalent (feature_name, other.feature_name)
		end

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			normal_feature: like Current;
			infix_feature: INFIX_AS;
		do
			normal_feature ?= other;
			infix_feature ?= other;
			
			if infix_feature /= void then
				Result := true
			elseif feature_name = Void then
				Result := False
			elseif normal_feature.feature_name = Void then
				Result := True
			else
				check
					void_normal_feature: normal_feature /= void
				end;
				Result := feature_name < normal_feature.feature_name
			end;
		end;
		
feature {COMPILER_EXPORTER}

	set_name (s: STRING) is
		do
			!!feature_name.make (0);
			feature_name.load (s);
		end;

end -- class FEAT_NAME_ID_AS
