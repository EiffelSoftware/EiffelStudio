indexing

	description: 
		"Extended Yacc to Eiffel interface for AST structures. %
		%Integrates a feature AST in which comments are kept, %
		%not retrieved each time.";
	date: "$Date$";
	revision: "$Revision $"

class EXT_YACC_EIFFEL

inherit

	YACC_EIFFEL
		redefine
			anchor_class_as, anchor_feature_as, anchor_feature_clause_as
		end

creation

	init

feature {NONE} -- Implementation

	anchor_class_as: EXT_CLASS_AS is
		do
		end;

	anchor_feature_as: EXT_FEATURE_AS is
		do
		end;

	anchor_feature_clause_as: EXT_FEATURE_CLAUSE_AS is
		do
		end;

end -- class EXT_YACC_EIFFEL
