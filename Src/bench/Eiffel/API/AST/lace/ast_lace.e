indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

deferred class AST_LACE

inherit

	AST_YACC;
	SHARED_WORKBENCH;
	SHARED_ERROR_HANDLER;
	SHARED_L_CONTEXT;
	COMPILER_EXPORTER

feature {COMPILER_EXPORTER}

	adapt is
		do
		end

end -- class AST_LACE
