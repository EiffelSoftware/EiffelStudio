-- Syntax error for invalid external declaration

class EXTERNAL_SYNTAX_ERROR

inherit

	SYNTAX_ERROR
		rename
			syntax_message as external_error_message
		redefine
			external_error_message
		end

creation
	init

feature

	external_error_message: STRING;
			-- Specific syntax message

	set_external_error_message (message: STRING) is
		do
			!!external_error_message.make (0);
			external_error_message.copy (message);
		end;

end
