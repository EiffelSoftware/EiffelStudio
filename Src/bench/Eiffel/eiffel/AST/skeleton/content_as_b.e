indexing

	description:
			"Abstract description of the content of a %
			%feature. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class CONTENT_AS_B

inherit

	CONTENT_AS;

	AST_EIFFEL_B
		redefine
			byte_node
		end

feature -- Type check and byte code

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
		end;

	local_table (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
		require
			good_argument: f /= Void;
		do
		end;

end -- class CONTENT_AS_B
