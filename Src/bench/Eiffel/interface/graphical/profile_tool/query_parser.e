indexing

	description:
		"Parse a query text";
	date: "$Date$";
	revision: "$Revision$"

class QUERY_PARSER

feature -- Parsing

	parse (str: STRING; sqv: SHARED_QUERY_VALUES) is
			-- Parse `str' and put results in
			-- 'sqv'.
		require
			string_not_void: str /= Void;
			string_not_empty: not str.empty;
			shared_query_values_not_void: sqv /= Void
		do
			real_parse (str, sqv)
		end

feature {NONE} -- Implementation

	real_parse (str: STRING; sqv: SHARED_QUERY_VALUES) is
			-- Real parsing feature.
		local
			col_name, operator, value, boolean_op: STRING;
			old_index, index: INTEGER;
			end_of_query, error: BOOLEAN;
			subquery: SUBQUERY;
			sub_operator: SUBQUERY_OPERATOR;
			index_ref: INTEGER_REF
		do
			from
				index := 1;
				str.to_lower;
				str.left_adjust;
				str.right_adjust;
			until
				error or else
				end_of_query
			loop
				col_name := column_name (str, index);
				if col_name = Void then
					error := True
				elseif col_name.is_equal ("EOQ") then
					end_of_query := True
				else
					index := index + col_name.count;
					index := index + white_space_length (str, index);
						operator := operator_str (str, index);
					index := index + operator.count;
					index := index + white_space_length (str, index);
						!! index_ref;
					index_ref.set_item (index);
					value := value_str (str, index_ref);
					index := index_ref.item;
						if value = Void then
						error := True
					else
						!! subquery.make (col_name, operator, value);
						sqv.subqueries.extend (subquery);
						if index < str.count then
							index := index + white_space_length (str, index);
							boolean_op := boolean_operator (str, index);
							if boolean_op = void then
								error := True
							elseif boolean_op.is_equal ("EOQ") then
								end_of_query := True
							else
								index := index + boolean_op.count;
								index := index + white_space_length (str, index);
								!! sub_operator.make (boolean_op);
								sqv.subquery_operators.extend (sub_operator);
								index := index + white_space_length (str, index)
							end
						else
							end_of_query := True
						end
					end
				end
			end
		end

	column_name (str: STRING; idx: INTEGER): STRING is
			-- Get the column name in `str' at position `idx'
		do
			if idx < str.count then
				if str @ idx = 'f' then
					Result := "featurename"
				elseif str @ idx = 'c' then
					Result := "calls"
				elseif str @ idx = 't' then
					Result := "total"
				elseif str @ idx = 's' then
					Result := "self"
				elseif str @ idx = 'p' then
					Result := "percentage"
				elseif str @ idx = 'd' then
					Result := "descendents"
				else
					Result := Void
				end
			else
				Result := "EOQ"
			end
		end

	operator_str (str: STRING; idx: INTEGER): STRING is
			-- Get operator str from `str' at position `idx'.
		local
			index: INTEGER
		do
			from
				index := idx
			until
				str @ index /= '<' and then
				str @ index /= '>' and then
				str @ index /= '=' and then
				str @ index /= '/' and then
				str @ index /= 'i' and then
				str @ index /= 'n'
			loop
				index := index + 1
			end;
			Result := str.substring (idx, index - 1);
		end;

	value_str (str: STRING; idx_ref: INTEGER_REF): STRING is
			-- Get value str from `str' at position `idx'.
		local
			tmp: STRING
			index, wsl: INTEGER
		do
			index := idx_ref.item
			Result := single_value (str, index);
			index := index + Result.count;
			wsl := white_space_length (str, index);
			if index + wsl < str.count then
				if has_range_operator (str, index + wsl) then
					Result.extend ('-');
					index := index + wsl + 1;
					index := index + white_space_length (str, index);
					tmp := single_value (str, index);
					index := index + tmp.count;
					Result.append (tmp)
				end
			end;
			idx_ref.set_item (index)
		end;

	single_value (str: STRING; idx: INTEGER): STRING is
			-- Get a single value
			-- (Not `single_value' "-" `single_value')
		local
			index, old_index: INTEGER
		do
			from
				index := idx
			until
				(str @ index).is_digit or else
				str @ index = 'm' or else
				str @ index = 'a'
			loop
				index := index + 1
			end;
			if str @ index = 'a' then
				Result := "avg"
			elseif str @ index = 'm' then
				if str @ (index + 1) = 'i' then
					Result := "min"
				elseif str @ (index + 1) = 'a' then
					Result := "max"
				else
					Result := Void
				end
			else
				from
					old_index := index
				until
					not ((str @ index).is_digit) and then
					str @ index /= '.'
				loop
					index := index + 1
				end;
				Result := str.substring (old_index, index - 1)
			end;
		end;

	boolean_operator (str: STRING; idx: INTEGER): STRING is
			-- Get boolean operator in `str' at `idx'.
		do
			if
				idx > str.count
			then
				Result := "EOQ"
			elseif
				str @ idx = 'o' and then
				str @ (idx + 1) = 'r'
			then
				Result := "or"
			elseif
				str @ idx = 'a' and then
				str @ (idx + 1) = 'n' and then
				str @ (idx + 2) = 'd'
			then
				Result := "and"
			else
				Result := Void
			end
		end

	white_space_length (str: STRING; idx: INTEGER): INTEGER is
			-- Length of white space starting at `idx' in `str'
		local
			index: INTEGER
		do
			from
				index := idx
			until
				not chis_space (str @ index)
			loop
				Result := Result + 1;
				index := index + 1
			end
		end;

	has_range_operator (str: STRING; idx: INTEGER): BOOLEAN is
			-- Is there a '-' at or after `idx' in `str'?
		do
			Result := str @ idx = '-'
		end

feature {NONE} -- Externals

	chis_space (c: CHARACTER): BOOLEAN is
		external
			"C [macro %"ctype.h%"] (char): EIF_CHARACTER"
		alias
			"isspace"
		end

end -- class QUERY_PARSER
