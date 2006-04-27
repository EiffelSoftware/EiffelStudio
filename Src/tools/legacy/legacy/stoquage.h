/*
declaration_joce_body
	:	// only for the body between "{" and "}"
		LCURLYBRACE 
			<<beginStruct_UnionDefinition("ANONYMOUS_DECL");>>
			(member_declaration)* 
			<<endStruct_UnionDefinition();>>
		RCURLYBRACE 
	;

joce_declarator
	:   <<
		TypeSpecifier ts = tsSTRUCT;
		TypeQualifier tq = tqInvalid;
		StorageClass  sc = scInvalid;
		DeclSpecifier ds = dsInvalid;
		>>
		<<beginFieldDeclaration();>>
		<<declarationSpecifier(sc, tq, ts);>>
		member_declarator
		("," <<beginFieldDeclaration();>> member_declarator)*   
	;

struct_union_specifier
	:	<<char *saveClass;>>
		(STRUCT | UNION )

		id:ID //<<declaratorID("STRUCT");>>
		<<saveClass = enclosingClass;  enclosingClass = symbols->strdup($id->getText());>>
		 {declaration_struct_union_body}
		<<enclosingClass = saveClass;>>
		struct_union_declarator  ";"	
		<<printf("CHOIX 1\n");>>

	|	(STRUCT | UNION )
		<<saveClass = enclosingClass; enclosingClass = "__anonymous";>>
		{declaration_struct_union_body}
		<<enclosingClass = saveClass;>>
		struct_union_declarator  ";"
		<<printf("CHOIX 2\n");>>
	;
*/
