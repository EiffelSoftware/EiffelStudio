-- Syntax error for invalid external declaration

class EXTERNAL_SYNTAX_ERROR

inherit

	SYNTAX_ERROR
		redefine
			build_explain
		end

creation
	init

feature

	external_error_message: STRING;

	set_external_error_message (message: STRING) is
		do
			!!external_error_message.make (0);
			external_error_message.copy (message);
		end;

	build_explain is
            -- Build specific explanation image for current error
            -- in `error_window'.
        do
			put_string (external_error_message);
        end

end
