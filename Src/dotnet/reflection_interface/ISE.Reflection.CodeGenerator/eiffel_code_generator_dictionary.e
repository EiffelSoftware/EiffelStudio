indexing
	description: "Eiffel keywords and useful strings to generate Eiffel classes"
	external_name: "ISE.Reflection.EiffelCodeGeneratorDictionary"
	
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
			external_name: "AccessFeatureClause"
		end
		
	Alias_keyword: STRING is "alias"
		indexing
			external_name: "AliasKeyword"
		end
		
	Any_class: STRING is "ANY"
		indexing
			external_name: "AnyClass"
		end
		
	Basic_operations_feature_clause: STRING is "feature -- Basic Operations"
		indexing
			external_name: "BasicOperationsFeatureClause"
		end
		
	Binary_operators_feature_clause: STRING is "feature -- Binary Operators"
		indexing
			external_name: "BinaryOperatorsFeatureClause"
		end
		
	Boolean_class: STRING is "BOOLEAN"
		indexing
			external_name: "BooleanClass"
		end
		
	Character_class: STRING is "CHARACTER"
		indexing
			external_name: "CharacterClass"
		end
		
	Class_keyword: STRING is "class"
		indexing
			external_name: "ClassKeyword"
		end
		
	Closing_round_bracket: STRING is ")"
		indexing
			external_name: "ClosingRoundBracket"
		end
		
	Colon: STRING is ":"
		indexing
			external_name: "Colon"
		end
		
	Create_keyword: STRING is "create"
		indexing
			external_name: "CreateKeyword"
		end
		
	Create_none: STRING is "create {NONE}"
		indexing
			external_name: "CreateNone"
		end
		
	Creator: STRING is "creator"
		indexing
			external_name: "Creator"
		end
		
	Dashes: STRING is "--"
		indexing
			external_name: "Dashes"
		end
		
	Deferred_keyword: STRING is "deferred"
		indexing
			external_name: "DeferredKeyword"
		end
		
	Double_class: STRING is "DOUBLE"
		indexing
			external_name: "DoubleClass"
		end

	Eiffel_class_extension: STRING is ".e"
			-- Eiffel class extension
		indexing
			external_name: "EiffelClassExtension"
		end
		
	Element_change_feature_clause: STRING is "feature -- Element Change"
		indexing
			external_name: "ElementChangeFeatureClause"
		end
		
	End_keyword: STRING is "end"
		indexing
			external_name: "EndKeyword"
		end
		
	Ensure_keyword: STRING is "ensure"
		indexing
			external_name: "EnsureKeyword"
		end

	Enum_keyword: STRING is "enum"
		indexing
			external_name: "EnumKeyword"
		end
		
	Expanded_keyword: STRING is "expanded"
		indexing
			external_name: "ExpandedKeyword"
		end
		
	External_keyword: STRING is "external"
		indexing
			external_name: "ExternalKeyword"
		end
		
	External_name_keyword: STRING is "external_name"
		indexing
			external_name: "ExternalNameKeyword"
		end
		
	Field: STRING is "field"
		indexing
			external_name: "Field"
		end
		
	Frozen_keyword: STRING is "frozen"
		indexing
			external_name: "FrozenKeyword"
		end
		
	Generator_indexing_clause: STRING is "Generator"
		indexing
			external_name: "GeneratorIndexingClause"
		end
		
	Generator_name: STRING is "Eiffel Emitter"
		indexing
			external_name: "GeneratorName"
		end
		
	IL: STRING is "IL"
		indexing
			external_name: "IL"
		end
		
	Implementation_feature_clause: STRING is "feature {NONE} -- Implementation"
		indexing
			external_name: "ImplementationFeatureClause"
		end
		
	Indexing_keyword: STRING is "indexing"
		indexing
			external_name: "IndexingKeyword"
		end
		
	Infix_keyword: STRING is "infix"
		indexing
			external_name: "InfixKeyword"
		end
		
	Inherit_keyword: STRING is "inherit"
		indexing
			external_name: "InheritKeyword"
		end
		
	Initialization_feature_clause: STRING is "feature {NONE} -- Initialization"
		indexing
			external_name: "InitializationFeatureClause"
		end
		
	Integer_class: STRING is "INTEGER"
		indexing
			external_name: "IntegerClass"
		end
		
	Integer_8_class: STRING is "INTEGER_8"
		indexing
			external_name: "Integer8Class"
		end
		
	Integer_16_class: STRING is "INTEGER_16"
		indexing
			external_name: "Integer16Class"
		end
		
	Integer_64_class: STRING is "INTEGER_64"
		indexing
			external_name: "Integer64Class"
		end
		
	Inverted_comma: STRING is "%""
		indexing
			external_name: "InvertedComma"
		end
		
	Is_keyword: STRING is "is"
		indexing
			external_name: "IsKeyword"
		end
		
	New_line: STRING is "%N"
		indexing
			external_name: "NewLine"
		end
		
	Operator: STRING is "operator"
		indexing
			external_name: "Operator"
		end
		
	Opening_round_bracket: STRING is "("
		indexing
			external_name: "OpeningRoundBracket"
		end
		
	Prefix_keyword: STRING is "prefix"
		indexing
			external_name: "PrefixKeyword"
		end
		
	Property_set_prefix: STRING is "set_"
		indexing
			external_name: "PropertySetPrefix"
		end
		
	Real_class: STRING is "REAL"
		indexing
			external_name: "RealClass"
		end
		
	Redefine_keyword: STRING is "redefine"
		indexing
			external_name: "RedefineKeyword"
		end
		
	Rename_keyword: STRING is "rename"
		indexing
			external_name: "RenameKeyword"
		end
		
	Require_keyword: STRING is "require"
		indexing
			external_name: "RequireKeyword"
		end
	
	Select_keyword: STRING is "select"
		indexing
			external_name: "SelectKeyword"
		end
		
	Semi_colon: STRING is ";"
		indexing
			external_name: "SemiColon"
		end
		
	Signature_keyword: STRING is "signature"
		indexing
			external_name: "SignatureKeyword"
		end
		
	Specials_feature_clause: STRING is "feature -- Specials"
		indexing
			external_name: "SpecialsFeatureClause"
		end
		
	Static: STRING is "static"
		indexing
			external_name: "Static"
		end
		
	Static_field: STRING is "static_field"
		indexing
			external_name: "StaticField"
		end
		
	Tab: STRING is "%T"
		indexing
			external_name: "Tab"
		end
		
	Unary_operators_feature_clause: STRING is "feature -- Unary Operators"
		indexing
			external_name: "UnaryOperatorsFeatureClause"
		end
		
	Undefine_keyword: STRING is "undefine"
		indexing
			external_name: "UndefineKeyword"
		end
		
	Use: STRING is "use"
		indexing
			external_name: "Use"
		end
		
end -- class EIFFEL_CODE_GENERATOR_DICTIONARY