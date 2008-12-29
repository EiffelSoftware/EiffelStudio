note

	description:
		"Parse a query text"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class QUERY_PARSER

feature -- Parsing

	parse (str: STRING; sqv: SHARED_QUERY_VALUES): BOOLEAN
			-- Parse `str', put results in 'sqv' and 
			-- return 'true' if the query has a good syntax
		require
			string_not_void: str /= Void;
			string_not_empty: not str.is_empty;
			shared_query_values_not_void: sqv /= Void
		do
			Result := real_parse (str, sqv)
		end

feature {NONE} -- Implementation

	real_parse (str: STRING; sqv: SHARED_QUERY_VALUES): BOOLEAN
			-- Real parsing feature.
		local
			col_name, operator, value, boolean_op: STRING;
			index, end_index: INTEGER;
			end_of_query, error: BOOLEAN;
			subquery: SUBQUERY;
			sub_operator: SUBQUERY_OPERATOR;
			-- index_ref: INTEGER_REF
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
				init_expected_values; --| Guillaume - 09/18/97
				col_name := column_name (str, index);
				if col_name = Void then
					error := True
				elseif col_name.is_equal ("EOQ") then
					end_of_query := True
				else
					index := index + col_name.count;
					-- index := index + 1; --| Guillaume - 09/17/97
					index := index + white_space_length (str, index);
					operator := operator_str (str, index);
					if operator = Void then
						error := true
					else
						index := index + operator.count;
						index := index + white_space_length (str, index);
						--!! index_ref;
						--index_ref.set_item (index);
						if index <= str.count then
							end_index := stricly_positive_min (str.substring_index (" and ", index), str.substring_index (" or ", index), str.count); 
							value := value_str (str, index, end_index);
							index := end_index;
						else
							value := void
						end
						
						if value = Void then
							error := True
						else
							create subquery.make (col_name, operator, value);
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
									create sub_operator.make (boolean_op);
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
			if error then
				Result := false;
			else
				Result := true;
			end
		end

	init_expected_values
		do
			expects_int := true;
			expects_real := true;
			expects_string := true;
			expects_bounded := true
		end --| Guillaume 09/18/97

	column_name (str: STRING; idx: INTEGER): STRING
			-- Get the column name in `str' at position `idx'
		do
			if idx < str.count then
				if str.substring(idx, idx + ("featurename").count - 1).is_equal("featurename") then
					Result := "featurename";
					expects_real := false;
					expects_int := false;
					expects_bounded := false; --| Guillaume - 09/18/97
				elseif str.substring(idx, idx + ("calls").count - 1).is_equal("calls") then
					Result := "calls";
					expects_string := false; --| Guillaume - 09/18/97
				elseif str.substring(idx, idx + ("total").count - 1).is_equal("total") then
					Result := "total";
					expects_string := false; --| Guillaume - 09/18/97
				elseif str.substring(idx, idx + ("self").count - 1).is_equal("self") then
					Result := "self";
					expects_string := false; --| Guillaume - 09/18/97
				elseif str.substring(idx, idx + ("percentage").count - 1).is_equal("percentage") then
					Result := "percentage";
					expects_string := false; --| Guillaume - 09/18/97
				elseif str.substring(idx, idx + ("descendants").count - 1).is_equal("descendants") then
					Result := "descendants";
					expects_string := false; --| Guillaume - 09/18/97
				else
					Result := Void
				end
			else
				Result := "EOQ"
			end
		end

	operator_str (str: STRING; idx: INTEGER): STRING
			-- Get operator str from `str' at position `idx'.
		local
			operator: STRING
		do
			create operator.make(0)
			create Result.make(0)
			operator := str.substring (idx, idx + 1)
			
			if operator.is_equal("<=") 
			   or else operator.is_equal(">=") 
			   or else operator.is_equal("/=") 
			then
				Result := operator
				expects_bounded := false;
				
			elseif operator.item (1).is_equal('>') 
					or else operator.item (1).is_equal('<') 
					or else operator.item (1).is_equal('=') then
				Result.extend ( operator.item(1) )
				expects_bounded := false

			elseif operator.is_equal("in") then
				Result := operator
				expects_real := false
				expects_int := false
				expects_string := false
			else
				Result := void
			end
		end; --| Guillaume - 09/18/97

	value_str (str: STRING; index, end_index: INTEGER): STRING
			-- Get value str from `str' beetween position 'index' and 'end_index'
		do
			create Result.make (0);
			Result := str.substring (index, end_index);
			Result.left_adjust;
			Result.right_adjust;
			if is_expected_value (Result) then
				Result.prune_all(' ');
			else
				Result := void;
			end
		end;

	is_expected_value ( value: STRING ) : BOOLEAN
			-- Is the 'value' string an expected value
		do
			Result := (expects_int and value.is_integer) or else (expects_int and is_computed_value(value))
					or else (expects_real and value.is_real) or else (expects_real and is_computed_value(value))
					or else (expects_string and not value.has (' ')) or else (expects_bounded and is_bounded(value))
		end
			
	is_computed_value ( value: STRING ) : BOOLEAN
		do
			if value.is_equal("max") or else value.is_equal("min") or else value.is_equal("avg") then
				Result := true;
			else
				Result := false
			end
		end
		
	is_bounded ( value: STRING ) : BOOLEAN
		local
			range_position : INTEGER;
			lower_value, upper_value: STRING
		do
			range_position := value.index_of ('-', 1);
			if range_position = 0 then
				Result := false
			else
				lower_value := value.substring ( 1, range_position-1 );
				upper_value := value.substring (range_position+1, value.count);
				lower_value.right_adjust;
				lower_value.left_adjust;
				upper_value.right_adjust;
				upper_value.left_adjust;
				if lower_value.is_real or else lower_value.is_integer then
					if upper_value.is_real or else upper_value.is_integer then
						Result := true
					end
				else
					Result := false
				end
			end
		end  --| Guillaume - 09/18/97
	
	boolean_operator (str: STRING; idx: INTEGER): STRING
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

	white_space_length (str: STRING; idx: INTEGER): INTEGER
			-- Length of white space starting at `idx' in `str'
		do
			from
				Result := 0
			until
				idx + Result > str.count or else not chis_space ( str.item( idx + Result ) )
			loop
				Result := Result + 1;
			end
		end;

	has_range_operator (str: STRING; idx: INTEGER): BOOLEAN
			-- Is there a '-' at or after `idx' in `str'?
		do
			Result := str @ idx = '-'
		end
		
	stricly_positive_min (a, b, c : INTEGER): INTEGER
			-- The min of a, b and c that is not zero
			-- a < c and b < c
		do
			if a > 0 then
				if b > 0 then
					if a < b then
						Result := a
					else
						Result := b
					end
				else
					Result := a
				end
			else
				if b > 0 then
					Result := b
				else
					Result := c
				end
			end
		end

feature {NONE} -- Externals

	chis_space (c: CHARACTER): BOOLEAN
		external
			"C [macro %"ctype.h%"] (char): EIF_CHARACTER"
		alias
			"isspace"
		end

feature {NONE} -- Attributes

	expects_int,
		-- The expected type of the subquery 'value' is a integer
		
	expects_real,
		-- The expected type of the subquery 'value' is a real
	
	expects_string,
		-- The expected type of the subquery 'value' is a string
	
	expects_bounded: BOOLEAN;
		-- The expected type of the subquery 'value' is a bounded value
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class QUERY_PARSER
