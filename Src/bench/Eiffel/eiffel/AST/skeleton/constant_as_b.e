indexing

	description:
		"Abstract description of a the content of an Eiffel %
		%constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class CONSTANT_AS_B

inherit

	CONSTANT_AS
		redefine
			value
		end;

	CONTENT_AS_B
		undefine
			is_constant, is_unique
		redefine
			byte_node, type_check
		end

feature -- Attributes

	value: EXPR_AS_B;
			-- Constant value

feature -- Conveniences

	value_i: VALUE_I is
			-- Interface constant value
		require
			is_constant and then not is_unique;
		local
			val: VALUE_AS_B;
		do
			val ?= value;
			Result := val.value_i;
		end;

	type_check is
		do
		ensure then
			False
		end; -- type_check

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
		ensure then
			False
		end;

end -- class CONSTANT_AS_B
