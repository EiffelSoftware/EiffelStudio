indexing
	description: "Eiffel keywords and useful strings to generate Eiffel classes"
	
class
	EIFFEL_CODE_GENERATOR_DICTIONARY
	
inherit
	DICTIONARY


feature -- Access

	Access_feature_clause: STRING is "feature -- Access"
		indexing
			description: "Access feature clause"
		end
		
	Alias_keyword: STRING is "alias"
		indexing
			description: "Alias keyword"
		end
		
	Any_class: STRING is "ANY"
		indexing
			description: "Class `ANY' as a string"
		end
		
	Assembly_Keyword: STRING is "assembly"
		indexing
			description: "Assembly keyword"
		end
		
	Basic_operations_feature_clause: STRING is "feature -- Basic Operations"
		indexing
			description: "Basic operations feature clause"
		end
		
	Binary_operators_feature_clause: STRING is "feature -- Binary Operators"
		indexing
			description: "Binary operators feature clause"
		end
		
	Boolean_class: STRING is "BOOLEAN"
		indexing
			description: "Class `BOOLEAN' as a string"
		end
		
	Character_class: STRING is "CHARACTER"
		indexing
			description: "Class `CHARACTER' as a string"
		end
		
	Class_keyword: STRING is "class"
		indexing
			description: "Class keyword"
		end
		
	Closing_round_bracket: STRING is ")"
		indexing
			description: "Closing round bracket as a string"
		end
		
	Closing_square_bracket: STRING is "]"
		indexing
			description: "Closing square bracket as a string"
		end
		
	Colon: STRING is ":"
		indexing
			description: "Colon as a string"
		end
		
	Constraints_keyword: STRING is "constraints"
		indexing
			description: "Constraints keyword in a generic class indexing clause"
		end
		
	Create_keyword: STRING is "create"
		indexing
			description: "Create keyword"
		end
		
	Create_none: STRING is "create {NONE}"
		indexing
			description: "`create {NONE}' creation clause"
		end
		
	Creator: STRING is "creator"
		indexing
			description: "Creator"
		end
		
	Dashes: STRING is "--"
		indexing
			description: "Dashes as a string"
		end
		
	Deferred_keyword: STRING is "deferred"
		indexing
			description: "Deferred keyword"
		end
	
	Do_keyword: STRING is "do"
		indexing
			description: "do keyword"
		end
		
	Double_class: STRING is "DOUBLE"
		indexing
			description: "Class `DOUBLE' as a string"
		end

	Eiffel_class_extension: STRING is ".e"
		indexing
			description: "Eiffel class extension"
		end
		
	Element_change_feature_clause: STRING is "feature -- Element Change"
		indexing
			description: "Element change feature clause"
		end
		
	End_keyword: STRING is "end"
		indexing
			description: "End keyword"
		end
	
	Enum_type_keyword: STRING is "enum_type"
		indexing
			description: "`Enum_type' keyword"
		end
		
	Ensure_keyword: STRING is "ensure"
		indexing
			description: "Ensure keyword"
		end

	Enum_keyword: STRING is "enum"
		indexing
			description: "Enum keyword"
		end
		
	Expanded_keyword: STRING is "expanded"
		indexing
			description: "Expanded keyword"
		end
		
	External_keyword: STRING is "external"
		indexing
			description: "External keyword"
		end
		
	External_name_keyword: STRING is "external_name"
		indexing
			description: "`external_name' keyword"
		end
		
	Field: STRING is "field"
		indexing
			description: "Field"
		end
		
	Frozen_keyword: STRING is "frozen"
		indexing
			description: "Frozen keyword"
		end
		
	Generator_indexing_clause: STRING is "generator"
		indexing
			description: "Generator keyword"
		end
		
	Generator_name: STRING is "Eiffel Emitter"
		indexing
			description: "Generator name"
		end
	
	Generic_types_keyword: STRING is "generic_types"
		indexing
			description: "`generic_type' keyword in a generic class indexing clause"
		end
		
	IL: STRING is "IL"
		indexing
			description: "IL string"
		end
		
	Implementation_feature_clause: STRING is "feature {NONE} -- Implementation"
		indexing
			description: "Implementation feature clause"
		end
		
	Indexing_keyword: STRING is "indexing"
		indexing
			description: "Indexing keyword"
		end
		
	Infix_keyword: STRING is "infix"
		indexing
			description: "Infix keyword"
		end
		
	Inherit_keyword: STRING is "inherit"
		indexing
			description: "Inherit keyword"
		end
		
	Initialization_feature_clause: STRING is "feature -- Initialization"
		indexing
			description: "Initialization feature clause"
		end

	Initialization_feature_clause_exported_to_none: STRING is "feature {NONE} -- Initialization"
		indexing
			description: "Initialization feature clause with `NONE' export clause"
		end
		
	Integer_class: STRING is "INTEGER"
		indexing
			description: "Class `INTEGER' as a string"
		end
		
	Integer_8_class: STRING is "INTEGER_8"
		indexing
			description: "Class `INTEGER_8' as a string"
		end
		
	Integer_16_class: STRING is "INTEGER_16"
		indexing
			description: "Class `INTEGER_16' as a string"
		end
		
	Integer_64_class: STRING is "INTEGER_64"
		indexing
			description: "Class `INTEGER_64' as a string"
		end
		
	Inverted_comma: STRING is "%""
		indexing
			description: "Inverted comma as a string"
		end
		
	Is_keyword: STRING is "is"
		indexing
			description: "Is keyword"
		end
		
	New_line: STRING is "%N"
		indexing
			description: "New line as a string"
		end
		
	Operator: STRING is "operator"
		indexing
			description: "Operator"
		end
		
	Opening_round_bracket: STRING is "("
		indexing
			description: "Opening round bracket as a string"
		end
	
	Opening_square_bracket: STRING is "["
		indexing
			description: "Opening square bracket as a string"
		end
		
	Prefix_keyword: STRING is "prefix"
		indexing
			description: "Prefix keyword"
		end
		
	Property_set_prefix: STRING is "set_"
		indexing
			description: "Set prefix for .NET properties"
		end
		
	Real_class: STRING is "REAL"
		indexing
			description: "Class `REAL' as a string"
		end
		
	Redefine_keyword: STRING is "redefine"
		indexing
			description: "Redefine keyword"
		end
		
	Rename_keyword: STRING is "rename"
		indexing
			description: "Rename keyword"
		end
		
	Require_keyword: STRING is "require"
		indexing
			description: "Require keyword"
		end
	
	Select_keyword: STRING is "select"
		indexing
			description: "Select keyword"
		end
		
	Semi_colon: STRING is ";"
		indexing
			description: "Semi colon as a string"
		end
		
	Signature_keyword: STRING is "signature"
		indexing
			description: "Signature keyword"
		end
		
	Specials_feature_clause: STRING is "feature -- Specials"
		indexing
			description: "Specials feature clause"
		end
		
	Static: STRING is "static"
		indexing
			description: "Static"
		end
		
	Static_field: STRING is "static_field"
		indexing
			description: "Static field"
		end
		
	Tab: STRING is "%T"
		indexing
			description: "Tabulation as a string"
		end
		
	Unary_operators_feature_clause: STRING is "feature -- Unary Operators"
		indexing
			description: "Unary operators feature clause"
		end
		
	Undefine_keyword: STRING is "undefine"
		indexing
			description: "Undefine keyword"
		end
		
	Use: STRING is "use"
		indexing
			description: "Use"
		end
	
	Windows_new_line: STRING is "%R%N"
		indexing
			description: "New line as a string"
		end
		
end -- class EIFFEL_CODE_GENERATOR_DICTIONARY
