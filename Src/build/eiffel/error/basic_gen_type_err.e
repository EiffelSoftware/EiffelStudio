-- Syntax error for basic type with generic derivation

class BASIC_GEN_TYPE_ERR

inherit

	SYNTAX_ERROR
		redefine
			build_explain
		end

creation

	init

feature

	build_explain is
            -- Build specific explanation image for current error
            -- in `error_window'.
        do
			put_string ("(basic type can not have generic derivation)%N")
        end;

end
