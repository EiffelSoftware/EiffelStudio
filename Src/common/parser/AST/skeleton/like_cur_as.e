-- Node for "like Current" type

class LIKE_CUR_AS

inherit

	TYPE
		redefine
			has_like
		end;

feature
		
	set is
			-- Yacc initialization
		do
			-- Do nothing
		end; -- set

feature

	has_like: BOOLEAN is True;
			-- Does the type have anchor in its definition ?

	actual_type: TYPE_A is
			-- Useless
		do
			-- Do nothing
		ensure then
			False
		end;

	dump: STRING is "like Current";
			-- Dump trace

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_CURRENT is
           -- Calcutate the effective type
        do
            !!Result;
            Result.set_actual_type (feat_table.associated_class.actual_type);
        end;
		
end
