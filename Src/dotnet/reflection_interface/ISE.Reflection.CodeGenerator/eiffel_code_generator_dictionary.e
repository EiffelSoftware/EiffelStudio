indexing
	description: "Eiffel keywords and useful strings to generate Eiffel classes"
	external_name: "ISE.Reflection.EiffelCodeGeneratorDictionary"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end
	
class
	EIFFEL_CODE_GENERATOR_DICTIONARY
	
inherit
	ISE_REFLECTION_DICTIONARY
		export	
			{NONE} all
		end

feature -- Access

	Access_feature_clause: STRING is "feature -- Access"
		indexing
			description: "Access feature clause"
			external_name: "AccessFeatureClause"
		end
		
	Alias_keyword: STRING is "alias"
		indexing
			description: "Alias keyword"
			external_name: "AliasKeyword"
		end
		
	Any_class: STRING is "ANY"
		indexing
			description: "Class `ANY' as a string"
			external_name: "AnyClass"
		end
		
	Basic_operations_feature_clause: STRING is "feature -- Basic Operations"
		indexing
			description: "Basic operations feature clause"
			external_name: "BasicOperationsFeatureClause"
		end
		
	Binary_operators_feature_clause: STRING is "feature -- Binary Operators"
		indexing
			description: "Binary operators feature clause"
			external_name: "BinaryOperatorsFeatureClause"
		end
		
	Boolean_class: STRING is "BOOLEAN"
		indexing
			description: "Class `BOOLEAN' as a string"
			external_name: "BooleanClass"
		end
		
	Character_class: STRING is "CHARACTER"
		indexing
			description: "Class `CHARACTER' as a string"
			external_name: "CharacterClass"
		end
		
	Class_keyword: STRING is "class"
		indexing
			description: "Class keyword"
			external_name: "ClassKeyword"
		end
		
	Closing_round_bracket: STRING is ")"
		indexing
			description: "Closing round bracket as a string"
			external_name: "ClosingRoundBracket"
		end
		
	Colon: STRING is ":"
		indexing
			description: "Colon as a string"
			external_name: "Colon"
		end
		
	Create_keyword: STRING is "create"
		indexing
			description: "Create keyword"
			external_name: "CreateKeyword"
		end
		
	Create_none: STRING is "create {NONE}"
		indexing
			description: "`create {NONE}' creation clause"
			external_name: "CreateNone"
		end
		
	Creator: STRING is "creator"
		indexing
			description: "Creator"
			external_name: "Creator"
		end
		
	Dashes: STRING is "--"
		indexing
			description: "Dashes as a string"
			external_name: "Dashes"
		end
		
	Deferred_keyword: STRING is "deferred"
		indexing
			description: "Deferred keyword"
			external_name: "DeferredKeyword"
		end
	
	Do_keyword: STRING is "do"
		indexing
			description: "do keyword"
			external_name: "DoKeyword"
		end
		
	Double_class: STRING is "DOUBLE"
		indexing
			description: "Class `DOUBLE' as a string"
			external_name: "DoubleClass"
		end

	Eiffel_class_extension: STRING is ".e"
		indexing
			description: "Eiffel class extension"
			external_name: "EiffelClassExtension"
		end
		
	Element_change_feature_clause: STRING is "feature -- Element Change"
		indexing
			description: "Element change feature clause"
			external_name: "ElementChangeFeatureClause"
		end
		
	End_keyword: STRING is "end"
		indexing
			description: "End keyword"
			external_name: "EndKeyword"
		end
	
	Enum_type_keyword: STRING is "enum_type"
		indexing
			description: "`Enum_type' keyword"
			external_name: "EnumTypeKeyword"
		end
		
	Ensure_keyword: STRING is "ensure"
		indexing
			description: "Ensure keyword"
			external_name: "EnsureKeyword"
		end

	Enum_keyword: STRING is "enum"
		indexing
			description: "Enum keyword"
			external_name: "EnumKeyword"
		end
		
	Expanded_keyword: STRING is "expanded"
		indexing
			description: "Expanded keyword"
			external_name: "ExpandedKeyword"
		end
		
	External_keyword: STRING is "external"
		indexing
			description: "External keyword"
			external_name: "ExternalKeyword"
		end
		
	External_name_keyword: STRING is "external_name"
		indexing
			description: "`external_name' keyword"
			external_name: "ExternalNameKeyword"
		end
		
	Field: STRING is "field"
		indexing
			description: "Field"
			external_name: "Field"
		end
		
	Frozen_keyword: STRING is "frozen"
		indexing
			description: "Frozen keyword"
			external_name: "FrozenKeyword"
		end
		
	Generator_indexing_clause: STRING is "Generator"
		indexing
			description: "Generator keyword"
			external_name: "GeneratorIndexingClause"
		end
		
	Generator_name: STRING is "Eiffel Emitter"
		indexing
			description: "Generator name"
			external_name: "GeneratorName"
		end
		
	IL: STRING is "IL"
		indexing
			description: "IL string"
			external_name: "IL"
		end
		
	Implementation_feature_clause: STRING is "feature {NONE} -- Implementation"
		indexing
			description: "Implementation feature clause"
			external_name: "ImplementationFeatureClause"
		end
		
	Indexing_keyword: STRING is "indexing"
		indexing
			description: "Indexing keyword"
			external_name: "IndexingKeyword"
		end
		
	Infix_keyword: STRING is "infix"
		indexing
			description: "Infix keyword"
			external_name: "InfixKeyword"
		end
		
	Inherit_keyword: STRING is "inherit"
		indexing
			description: "Inherit keyword"
			external_name: "InheritKeyword"
		end
		
	Initialization_feature_clause: STRING is "feature -- Initialization"
		indexing
			description: "Initialization feature clause"
			external_name: "InitializationFeatureClause"
		end

	Initialization_feature_clause_exported_to_none: STRING is "feature {NONE} -- Initialization"
		indexing
			description: "Initialization feature clause with `NONE' export clause"
			external_name: "InitializationFeatureClauseExportedToNone"
		end
		
	Integer_class: STRING is "INTEGER"
		indexing
			description: "Class `INTEGER' as a string"
			external_name: "IntegerClass"
		end
		
	Integer_8_class: STRING is "INTEGER_8"
		indexing
			description: "Class `INTEGER_8' as a string"
			external_name: "Integer8Class"
		end
		
	Integer_16_class: STRING is "INTEGER_16"
		indexing
			description: "Class `INTEGER_16' as a string"
			external_name: "Integer16Class"
		end
		
	Integer_64_class: STRING is "INTEGER_64"
		indexing
			description: "Class `INTEGER_64' as a string"
			external_name: "Integer64Class"
		end
		
	Inverted_comma: STRING is "%""
		indexing
			description: "Inverted comma as a string"
			external_name: "InvertedComma"
		end
		
	Is_keyword: STRING is "is"
		indexing
			description: "Is keyword"
			external_name: "IsKeyword"
		end
		
	New_line: STRING is "%N"
		indexing
			description: "New line as a string"
			external_name: "NewLine"
		end
		
	Operator: STRING is "operator"
		indexing
			description: "Operator"
			external_name: "Operator"
		end
		
	Opening_round_bracket: STRING is "("
		indexing
			description: "Opening round bracket as a string"
			external_name: "OpeningRoundBracket"
		end
		
	Prefix_keyword: STRING is "prefix"
		indexing
			description: "Prefix keyword"
			external_name: "PrefixKeyword"
		end
		
	Property_set_prefix: STRING is "set_"
		indexing
			description: "Set prefix for .NET properties"
			external_name: "PropertySetPrefix"
		end
		
	Real_class: STRING is "REAL"
		indexing
			description: "Class `REAL' as a string"
			external_name: "RealClass"
		end
		
	Redefine_keyword: STRING is "redefine"
		indexing
			description: "Redefine keyword"
			external_name: "RedefineKeyword"
		end
		
	Rename_keyword: STRING is "rename"
		indexing
			description: "Rename keyword"
			external_name: "RenameKeyword"
		end
		
	Require_keyword: STRING is "require"
		indexing
			description: "Require keyword"
			external_name: "RequireKeyword"
		end
	
	Select_keyword: STRING is "select"
		indexing
			description: "Select keyword"
			external_name: "SelectKeyword"
		end
		
	Semi_colon: STRING is ";"
		indexing
			description: "Semi colon as a string"
			external_name: "SemiColon"
		end
		
	Signature_keyword: STRING is "signature"
		indexing
			description: "Signature keyword"
			external_name: "SignatureKeyword"
		end
		
	Specials_feature_clause: STRING is "feature -- Specials"
		indexing
			description: "Specials feature clause"
			external_name: "SpecialsFeatureClause"
		end
		
	Static: STRING is "static"
		indexing
			description: "Static"
			external_name: "Static"
		end
		
	Static_field: STRING is "static_field"
		indexing
			description: "Static field"
			external_name: "StaticField"
		end
		
	Tab: STRING is "%T"
		indexing
			description: "Tabulation as a string"
			external_name: "Tab"
		end
		
	Unary_operators_feature_clause: STRING is "feature -- Unary Operators"
		indexing
			description: "Unary operators feature clause"
			external_name: "UnaryOperatorsFeatureClause"
		end
		
	Undefine_keyword: STRING is "undefine"
		indexing
			description: "Undefine keyword"
			external_name: "UndefineKeyword"
		end
		
	Use: STRING is "use"
		indexing
			description: "Use"
			external_name: "Use"
		end
	
	Windows_new_line: STRING is "%R%N"
		indexing
			description: "New line as a string"
			external_name: "WindowsNewLine"
		end
		
end -- class EIFFEL_CODE_GENERATOR_DICTIONARY