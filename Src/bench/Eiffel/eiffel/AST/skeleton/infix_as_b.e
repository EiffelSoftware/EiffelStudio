-- Abstract description of an Eiffel infixed feature name

class INFIX_AS

inherit

	FEATURE_NAME
		redefine
			is_infix, is_valid, format
		end

feature -- Attributes

	fix_operator: STRING_AS;
			-- Infix notation

feature -- Conveniences

	is_infix: BOOLEAN is
			-- is the feature name an infixed notation ?
		do
			Result := True;
		end; -- is_infix

	infix "<" (other: FEATURE_NAME): BOOLEAN is
		local
			infix_feature: INFIX_AS;
			normal_feature: FEAT_NAME_ID_AS;
		do
			normal_feature ?= other;
			infix_feature ?= other;
			if infix_feature /= void then
				Result := fix_operator < infix_feature.fix_operator
			else
				check
					normal_feature /= void
				end;
				Result := false;
			end;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			fix_operator ?= yacc_arg (0);
				-- (Free) operators are not case sensitive
			fix_operator.value.to_lower;
			is_frozen := yacc_bool_arg (0);
		ensure then
			fix_operator_exists: fix_operator /= Void
		end;


	set_name (s: STRING) is
		do
			!!fix_operator;
			fix_operator.set_value (s);
		end;

feature

	internal_name: ID_AS is
			-- Internal name used by the compiler
		local
			value, to_append: STRING;
		do
			temp_name.clear;
			temp_name.append (Fix_notation);
			value := fix_operator.value;
			to_append := code_table.item (value);
			if to_append = Void then
					-- Free operator
				to_append := value;
			end;
			check
				good_string_to_append: to_append /= Void;
			end;
			temp_name.append (to_append);
			Result := temp_name.twin;
			Result.to_lower;
		end;

	Fix_notation: STRING is
			-- Infix notation prefix for the compiler
		do
			Result := "_infix_";
		end;

	is_valid: BOOLEAN is
			-- Is the fix notation valid ?
		local
			value: STRING;
		do
			value := fix_operator.value;
			Result := code_table.has (value) or else is_free;
		end;

	is_free: BOOLEAN is
			-- Is the fix notation a free notation ?
		local
			value: STRING;
			first_char: CHARACTER;
			i, count: INTEGER;
		do
			value := fix_operator.value;
			first_char := value.item (1);
			if	first_char = '%A'
				or else
				first_char = '%S'
				or else
				first_char = '%V'
				or else
				first_char = '&'
			then
				from
					Result := True;
					i := 2;
					count := value.count;
				until
					i > count
				loop
					Result := value.item (i) /= '%%';
					i := i + 1;
				end;
			end;
		ensure then
			Result implies not code_table.has (fix_operator.value);
		end;


	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			if is_frozen then 
				ctxt.put_keyword ("frozen");
				ctxt.put_string (" ");
			end;
			if is_infix then
				ctxt.put_keyword ("infix");
				ctxt.put_special (" %"");
				ctxt.prepare_for_infix (internal_name, void);
			else
				ctxt.put_keyword ("prefix");
				ctxt.put_special (" %"");
				ctxt.prepare_for_prefix (internal_name);
			end;
			ctxt.put_string (ctxt.new_types.final_name);
			ctxt.put_special ("%"");
			ctxt.commit;
		end;
	
end
