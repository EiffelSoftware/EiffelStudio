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

feature -- test for empty body

	empty : BOOLEAN is
			-- Is content empty?
		do
			Result := True  -- redefined in ROUTINE_AS_B
		end

feature -- default rescue

	create_default_rescue (def_resc_name : STRING) is
			-- Create default rescue clause if necessary
		require
			valid_feature_name : def_resc_name /= Void
		do
			-- redefined in ROUTINE_AS_B
		end

feature -- Type check and byte code

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
		end;

	local_table (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table of eiffel routine
		require
			good_argument: f /= Void;
		do
		end;

	local_table_for_format (f: FEATURE_I): EXTEND_TABLE [LOCAL_INFO, STRING] is
			-- Local table for format of eiffel routine
		do
		end;

end -- class CONTENT_AS_B
