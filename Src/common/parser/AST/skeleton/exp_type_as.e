-- Abstract description of expanded class type

class EXP_TYPE_AS

inherit

	CLASS_TYPE_AS
		rename
			actual_type as basic_actual_type,
			solved_type as basic_solved_type,
			dump as basic_dump
		end;
	CLASS_TYPE_AS
		redefine
			actual_type, solved_type, dump
		select
			actual_type, solved_type, dump
		end;

feature

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
        do
            Result := basic_solved_type (feat_table, f);
            Result.set_is_expanded (True);
        end;

    actual_type: CL_TYPE_A is
            -- Expanded actual class type
        do
            Result := basic_actual_type;
            Result.set_is_expanded (True);
        end;

    dump: STRING is
            -- Dumped trace
        do
            !!Result.make (class_name.count + 9);
            Result.append ("expanded ");
            Result.append (basic_dump);
        end;

end
