-- Abstract class for an Eiffel feature name: id or infix/prefix notation

deferred class FEATURE_NAME

inherit

	AST_EIFFEL
		redefine
			format
		end;
	STONABLE;
	COMPARABLE

feature -- Conveniences

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



feature -- Internal name computing


	infix "<" (other: FEATURE_NAME): BOOLEAN is
		deferred
		end;

	internal_name: ID_AS is
			-- Internal name used by the compiler
		deferred
		end;

	temp_name: ID_AS is
			-- Buffer for internal name evaluation
		once
			!!Result.make (25);
		end;

	set_name (s: STRING) is
		require
			s /= void
		deferred
		end;

	set_is_frozen (b: BOOLEAN) is
		do
			is_frozen := b;
		end;


	code_table: HASH_TABLE [STRING, STRING] is
			-- Corepondance table for infix/prefix notation
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

feature -- stoning
 
	stone (reference_class: CLASS_C): FEATURE_STONE is
		local
			a_feature_i: FEATURE_I
		do
			a_feature_i := reference_class.feature_named (internal_name);
			if a_feature_i /= Void then
				Result := a_feature_i.stone (reference_class)
			else
--io.error.putstring ("error in making feature stone ");
--io.error.putstring (internal_name);
--io.error.new_line;
				!!Result.make (Void, reference_class, 0, 0);
			end
		end

feature -- Formatting

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_keyword ("frozen");
				ctxt.put_string (" ")
			end;
			ctxt.prepare_for_feature (internal_name, void);
			ctxt.put_current_feature;
		end;

	main_feature_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			if is_frozen then
				ctxt.put_keyword ("frozen");
				ctxt.put_string (" ")
			end;
			ctxt.prepare_for_main_feature;
			ctxt.put_current_feature;
	   end;

	offset: INTEGER is
		do
			if is_frozen then
					--| offset for frozen routines
				Result := 7
			end
		end

end
