%{
indexing

	description: "Eiffel inheritance clause parser"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_INHERITANCE_CLAUSE_PARSER

inherit
	CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

create
	make
%}

%start		Inheritance

%token		TE_ALL TE_SEMICOLON TE_COMMA TE_ID TE_END TE_AS TE_EXPANDED
%token		TE_EXPORT TE_INHERIT TE_REDEFINE TE_RENAME TE_LSQURE TE_RSQURE
%token		TE_SELECT TE_UNDEFINE TE_INFIX TE_PREFIX TE_LCURLY TE_RCURLY
%token		TE_SEPARATE TE_BIT TE_LIKE TE_CURRENT TE_INTEGER TE_PLUS TE_MINUS

%token		TE_STR_LT TE_STR_LE TE_STR_GT TE_STR_GE TE_STR_MINUS
%token		TE_STR_PLUS TE_STR_STAR TE_STR_SLASH TE_STR_MOD
%token		TE_STR_DIV TE_STR_POWER TE_STR_AND TE_STR_AND_THEN
%token		TE_STR_IMPLIES TE_STR_OR TE_STR_OR_ELSE TE_STR_XOR
%token		TE_STR_NOT TE_STR_FREE

%type <LIST [CODE_SNIPPET_PARENT]>			Parent_list
%type <CODE_SNIPPET_PARENT>					Parent Parent_clause
%type <STRING>								Feature_name Infix Prefix Infix_operator
											Prefix_operator Integer_constant
											Generics_opt Type_list Class_type
											Non_class_type Type Identifier
%type <LIST [STRING]>						Client_list Feature_set Feature_list Class_list
%type <LIST [CODE_SNIPPET_RENAME_CLAUSE]>	Rename Rename_list
%type <CODE_SNIPPET_RENAME_CLAUSE>			Rename_pair
%type <LIST [CODE_SNIPPET_EXPORT_CLAUSE]>	New_exports New_exports_opt New_export_list New_export_item
%type <LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]>	Undefine Undefine_opt
%type <LIST [CODE_SNIPPET_REDEFINE_CLAUSE]>	Redefine Redefine_opt
%type <LIST [CODE_SNIPPET_SELECT_CLAUSE]>	Select Select_opt

%%

Inheritance:
		TE_INHERIT Parent_list
			{ parents := $2 }
	|	TE_INHERIT ASemi
			{ parents := create {ARRAYED_LIST [CODE_SNIPPET_PARENT]}.make (0) }
	;

Parent_list: Parent
			{
				$$ := create {ARRAYED_LIST [CODE_SNIPPET_PARENT]}.make (Initial_parent_list_size)
				$$.extend ($1)
			}
	|	Parent_list Parent
			{
				$$ := $1
				$$.extend ($2)
			} 
	;

Parent: Parent_clause
			{ $$ := $1 }
	|	Parent_clause TE_SEMICOLON
			{ $$ := $1 }
	;

Parent_clause: Identifier Generics_opt
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, Void, Void, Void, Void, Void)
			}
	|	Identifier Generics_opt Rename New_exports_opt Undefine_opt Redefine_opt Select_opt TE_END
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, $3, $4, $5, $6, $7)
			}
	|	Identifier Generics_opt New_exports Undefine_opt Redefine_opt Select_opt TE_END
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, Void, $3, $4, $5, $6)
			}
	|	Identifier Generics_opt Undefine Redefine_opt Select_opt TE_END
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, Void, Void, $3, $4, $5)
			}
	|	Identifier Generics_opt Redefine Select_opt TE_END
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, Void, Void, Void, $3, $4)
			}
	|	Identifier Generics_opt Select TE_END
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, Void, Void, Void, Void, $3)
			}
	|	Identifier Generics_opt TE_END
			{
				$$ := create {CODE_SNIPPET_PARENT}.make ($1, $2, Void, Void, Void, Void, Void)
			}
	;

Type: Class_type
			{ $$ := $1 }
	|	Non_class_type
			{ $$ := $1 }
	;

Non_class_type: TE_EXPANDED Identifier Generics_opt
			{
				$$ := create {STRING}.make (64)
				$$.append ("expanded ")
				$$.append ($2)
				if $3 /= Void then
					$$.append ($3)
				end
			}
	|	TE_SEPARATE Identifier Generics_opt
			{
				$$ := create {STRING}.make (64)
				$$.append ("separate ")
				$$.append ($2)
				if $3 /= Void then
					$$.append ($3)
				end
			}
	|	TE_BIT Integer_constant
			{
				$$ := create {STRING}.make ($2.count + 4)
				$$.append ("BIT ")
				$$.append ($2)
			}
	|	TE_BIT Identifier
			{
				$$ := create {STRING}.make ($2.count + 4)
				$$.append ("BIT ")
				$$.append ($2)
			}
	|	TE_LIKE Identifier
			{
				$$ := create {STRING}.make ($2.count + 5)
				$$.append ("like ")
				$$.append ($2)
			}
	|	TE_LIKE TE_CURRENT
			{ $$ := "like Current" }
	;

Class_type: Identifier Generics_opt
			{
				$$ := $1
				if $2 /= Void then
					$$.append ($2)
				end
			}
	;

Generics_opt: -- Empty
			-- { $$ := Void }
	|	TE_LSQURE TE_RSQURE
			-- { $$ := Void }
	|	TE_LSQURE Type_list TE_RSQURE
			{
				$$ := create {STRING}.make ($2.count + 2)
				$$.append_character ('[')
				$$.append ($2)
				$$.append_character (']')
			}
	;

Type_list: Type
			{ $$ := $1 }
	|	Type_list TE_COMMA Type
			{
				$$ := $1
				$$.append (", ")
				$$.append ($3)
			}
	;

Client_list: TE_LCURLY TE_RCURLY
			{
				$$ := create {ARRAYED_LIST [STRING]}.make (1)
				$$.extend ("{NONE}")
			}
	|	TE_LCURLY Class_list TE_RCURLY
			{ $$ := $2 }
	;

Class_list: Identifier
			{
				$$ := create {ARRAYED_LIST [STRING]}.make (1)
				$$.extend ($1)
			}
	|	Class_list TE_COMMA Identifier
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Rename: TE_RENAME
			-- { $$ := Void }
	|	TE_RENAME Rename_list
			{ $$ := $2 }
	;

Rename_list: Rename_pair
			{
				$$ := create {ARRAYED_LIST [CODE_SNIPPET_RENAME_CLAUSE]}.make (Initial_clause_list_size)
				$$.extend ($1)
			}
	|	Rename_list TE_COMMA Rename_pair
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Rename_pair: Feature_name TE_AS Feature_name
			{
				$$ := create {CODE_SNIPPET_RENAME_CLAUSE}.make ($1, $3)
			}
			;

New_exports_opt: -- Empty
			-- { $$  := Void }
	|	New_exports
			{ $$ := $1 }
	;

New_exports: TE_EXPORT New_export_list
			{
				if $2 = Void or else $2.is_empty then
					$$ := Void
				else
					$$ := $2
				end
			}
	|	TE_EXPORT ASemi
			-- { $$ := Void }
	;

New_export_list: New_export_item
			{ $$ := $1 }
	|	New_export_list New_export_item
			{
				$$ := $1
				if $1 /= Void and $2 /= Void then
					$$.append ($2)
				end
			}
	;

New_export_item: Client_list Feature_set ASemi
			{
				if $2 /= Void then
					$$ := create {ARRAYED_LIST [CODE_SNIPPET_EXPORT_CLAUSE]}.make ($2.count)
					from
						$2.start
					until
						$2.after
					loop
						$$.extend (create {CODE_SNIPPET_EXPORT_CLAUSE}.make ($2.item, $1))
						$2.forth
					end
				end
			}
			;

Feature_set: -- Empty
			-- { $$ := Void }
	|	TE_ALL
			{
				$$ := create {ARRAYED_LIST [STRING]}.make (1)
				$$.extend ("all")
			}
	|	Feature_list
			{ $$ := $1 }
	;

Feature_list: Feature_name
			{
				$$ := create {ARRAYED_LIST [STRING]}.make (Initial_feature_list_size)
				$$.extend ($1)
			}
	|	Feature_list TE_COMMA Feature_name
			{
				$$ := $1
				$$.extend ($3)
			}
	;

Undefine_opt: -- Empty
			-- { $$ := Void }
	|	Undefine
			{ $$ := $1 }
	;

Undefine: TE_UNDEFINE
			-- { $$ := Void }
	|	TE_UNDEFINE Feature_list
			{
				$$ := create {ARRAYED_LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]}.make ($2.count)
				from
					$2.start
				until
					$2.after
				loop
					$$.extend (create {CODE_SNIPPET_UNDEFINE_CLAUSE}.make ($2.item))
					$2.forth
				end
			}
	;

Redefine_opt: -- Empty
			-- { $$ := Void }
	|	Redefine
			{ $$ := $1 }
	;

Redefine: TE_REDEFINE
			-- { $$ := Void }
	|	TE_REDEFINE Feature_list
			{
				$$ := create {ARRAYED_LIST [CODE_SNIPPET_REDEFINE_CLAUSE]}.make ($2.count)
				from
					$2.start
				until
					$2.after
				loop
					$$.extend (create {CODE_SNIPPET_REDEFINE_CLAUSE}.make ($2.item))
					$2.forth
				end
			}
	;

Select_opt: -- Empty
			-- { $$ := Void }
	|	Select
			{ $$ := $1 }
	;

Select: TE_SELECT
			-- { $$ := Void }
	|	TE_SELECT Feature_list
			{
				$$ := create {ARRAYED_LIST [CODE_SNIPPET_SELECT_CLAUSE]}.make ($2.count)
				from
					$2.start
				until
					$2.after
				loop
					$$.extend (create {CODE_SNIPPET_SELECT_CLAUSE}.make ($2.item))
					$2.forth
				end
			}
	;

Feature_name: Identifier
			{ $$ := $1 }
	|	Infix
			{ $$ := $1 }
	|	Prefix
			{ $$ := $1 }
	;

Infix: TE_INFIX Infix_operator
			{ $$ := $2 }
	;


Prefix: TE_PREFIX Prefix_operator
			{ $$ := $2 }
	;

Prefix_operator: TE_STR_MINUS
			{ $$ := "prefix %"-%"" }
	|	TE_STR_PLUS
			{ $$ := "prefix %"+%"" }
	|	TE_STR_NOT
			{ $$ := "prefix %"not%"" }
	|	TE_STR_FREE
			{
				$$ := create {STRING}.make (9 + token_buffer.count)
				$$.append ("prefix %"")
				$$.append (token_buffer.as_lower)
				$$.append_character ('"')
			}
	;

Infix_operator: TE_STR_LT
			{ $$ := "infix %"<%"" }
	|	TE_STR_LE
			{ $$ := "infix %"<=%"" }
	|	TE_STR_GT
			{ $$ := "infix %">%"" }
	|	TE_STR_GE
			{ $$ := "infix %">=%"" }
	|	TE_STR_MINUS
			{ $$ := "infix %"-%"" }
	|	TE_STR_PLUS
			{ $$ := "infix %"+%"" }
	|	TE_STR_STAR
			{ $$ := "infix %"*%"" }
	|	TE_STR_SLASH
			{ $$ := "infix %"/%"" }
	|	TE_STR_MOD
			{ $$ := "infix %"\\%"" }
	|	TE_STR_DIV
			{ $$ := "infix %"//%"" }
	|	TE_STR_POWER
			{ $$ := "infix %"^%"" }
	|	TE_STR_AND
			{ $$ := "infix %"and%"" }
	|	TE_STR_AND_THEN
			{ $$ := "infix %"and then%"" }
	|	TE_STR_IMPLIES
			{ $$ := "infix %"implies%"" }
	|	TE_STR_OR
			{ $$ := "infix %"or%"" }
	|	TE_STR_OR_ELSE
			{ $$ := "infix %"or else%"" }
	|	TE_STR_XOR
			{ $$ := "infix %"xor%"" }
	|	TE_STR_FREE
			{
				$$ := create {STRING}.make (8 + token_buffer.count)
				$$.append ("infix %"")
				$$.append (token_buffer.as_lower)
				$$.append_character ('"')
			}
	;

Integer_constant: TE_INTEGER
			{
				$$ := token_buffer.twin
			}
	|	TE_PLUS TE_INTEGER
			{
				$$ := token_buffer.twin
			}
	|	TE_MINUS TE_INTEGER
			{
				$$ := token_buffer.twin
			}
	;
	
Identifier: TE_ID
		{ $$ := token_buffer.twin }
	;

ASemi: -- Empty
	|	TE_SEMICOLON
	;

%%

end -- class CODE_INHERITANCE_CLAUSE_PARSER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------