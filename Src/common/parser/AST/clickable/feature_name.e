indexing

	description:
		"AST representation for an Eiffel feature name: id or %
		%infix/prefix notation.";
	date: "$Date$";
	revision: "$Revision$"

deferred class FEATURE_NAME

inherit

	AST_EIFFEL
        undefine
            is_equal
		end
	COMPARABLE
	CLICKABLE_AST
		undefine
			is_equal
		redefine
			is_feature
		end

-- Undefined is_equal of AST_EIFFEL and CLICKABLE_AST because these are
-- not consistent with infix < operator
-- < is defined by the terms of < of feature name and is_equal 
-- (from general is c_standard_is_equal)

feature -- Properties

	is_frozen: BOOLEAN;
			-- Is the name of the feature frozen ?

	is_infix: BOOLEAN is
			-- Is the feature name an infixed notation ?
		do
		end;

	is_prefix: BOOLEAN is
			-- Is the feature name a prefixed notation ?
		do
		end;

	is_valid: BOOLEAN is
			-- is the feature name valid ?
		do
			Result := True;
		end;

	is_feature: BOOLEAN is True
			-- Does the Current AST represent a feature?

	internal_name: ID_AS is
			-- Internal name used by the compiler
		deferred
		end;

	visual_name: STRING is
			-- Named used in Eiffel code
		do	
			Result := internal_name
		end

feature -- Comparison

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		deferred
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_text_item (ti_Frozen_keyword);
				ctxt.put_space
			end;
			ctxt.prepare_for_feature (internal_name, void);
			ctxt.put_normal_feature;
		end;

feature {COMPILER_EXPORTER}

	set_name (s: STRING) is
		require
			s /= void
		deferred
		end;

	set_is_frozen (b: BOOLEAN) is
		do
			is_frozen := b;
		end;

feature {FEATURE_AS} -- Formatting

	offset: INTEGER is
		do
			if is_frozen then
					--| offset for frozen routines
				Result := 7
			end
		end

feature {NONE} -- Implementation

	temp_name: ID_AS is
			-- Buffer for internal name evaluation
		once
			!!Result.make (25);
		end;

	code_table: HASH_TABLE [STRING, STRING] is
			-- Corrsepondance table for infix/prefix notation
		once
			!!Result.make (20);
			Result.put ("plus", "+");
			Result.put ("minus", "-");
			Result.put ("star", "*");
			Result.put ("slash", "/");
			Result.put ("lt", "<");
			Result.put ("gt", ">");
			Result.put ("le", "<=");
			Result.put ("ge", ">=");
			Result.put ("and", "and");
			Result.put ("or", "or");
			Result.put ("implies", "implies");
			Result.put ("xor", "xor");
			Result.put ("not", "not");
			Result.put ("mod", "\\");
			Result.put ("div", "//");
			Result.put ("power", "^");
			Result.put ("and_then", "and then");
			Result.put ("or_else", "or else");
		end

end -- class FEATURE_NAME
