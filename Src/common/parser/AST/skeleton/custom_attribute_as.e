indexing
	description: "Description of a custom attribute."
	date: "$Date$"
	revision: "$Revision$"

class CUSTOM_ATTRIBUTE_AS

inherit
	ATOMIC_AS
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like creation_expr; t: like tuple; k_as: KEYWORD_AS) is
			-- Create a new UNIQUE AST node.
		require
			c_not_void: c /= Void
		do
			creation_expr := c
			tuple := t
			end_keyword := k_as
		ensure
			creation_expr_set: creation_expr = c
			tuple_set: tuple = t
			end_keyword_set: end_keyword = k_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_custom_attribute_as (Current)
		end

feature -- Roundtrip

	end_keyword: KEYWORD_AS
			-- Keyword "end" in current AST node

	set_end_keyword (a_keyword: KEYWORD_AS) is
			--- Set `end_keyword' with `a_keyword'.
		do
			end_keyword := a_keyword
		ensure
			end_keyword_set: end_keyword = a_keyword
		end

feature -- Access

	creation_expr: CREATION_EXPR_AS
			-- Creation of Custom attribute.

	tuple: TUPLE_AS
			-- Tuple for addition custom attribute settings.

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := creation_expr.complete_start_location (a_list)
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if tuple /= Void then
					Result := tuple.complete_end_location (a_list)
				else
					Result := creation_expr.complete_end_location (a_list)
				end
			else
				Result := end_keyword.complete_end_location (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := creation_expr.is_equivalent (other.creation_expr)
		end

feature -- Output

	string_value: STRING is ""

invariant
	creation_expr_not_void: creation_expr /= Void

end -- class CUSTOM_ATTRIBUTE_AS
