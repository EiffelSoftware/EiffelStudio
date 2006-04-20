indexing
	description: 
		"Major syntactic construct names in .FIL files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SHARED_FILTER

feature {NONE} -- Implementation

	f_Assertion_tag: STRING is			"assertion_tag"
	f_Basic: STRING is					"basic"
	f_Character: STRING is				"character"
	f_Class_declaration: STRING is		"class_declaration"
	f_Class_end: STRING is				"class_end"
	f_Class_header: STRING is			"class_header"
	f_Class_name: STRING is				"class_name"
	f_Cluster_declaration: STRING is	"cluster_declaration"
	f_Cluster_header: STRING is			"cluster_header"
	f_Cluster_name: STRING is			"cluster_name"
	f_Comment: STRING is				"comment"
	f_Comment_url: STRING is			"comment_url"
	f_Creators: STRING is				"creators"
	f_Feature_clause: STRING is			"feature_clause"
	f_Feature_clause_header: STRING is	"feature_clause_header"
	f_Feature_declaration: STRING is	"feature_declaration"
	f_Features: STRING is				"features"
	f_File_separator: STRING is			"file_separator"
	f_Formal_generics: STRING is		"formal_generics"
	f_Generic: STRING is				"generic"
	f_Indexing: STRING is				"indexing_clause"
	f_Indexing_content: STRING is		"indexing_content"
	f_Indexing_tag: STRING is			"indexing_tag"
	f_Inheritance: STRING is			"inheritance"
	f_Invariant: STRING is				"invariant_clause"
	f_Keyword: STRING is				"keyword"
	f_Keyword_features: STRING is		"keyword_features"
	f_Local_symbol: STRING is			"local_symbol"
	f_Menu_bar: STRING is				"menu_bar"
	f_Menu_item: STRING is				"menu_item"
	f_Multiple_spaces: STRING is		"multiple_spaces"
	f_New_line: STRING is				"new_line"
	f_Non_generated_class: STRING is	"non_generated_class"
	f_Non_generated_cluster: STRING is	"non_generated_cluster"
	f_Non_generated_feature: STRING is	"non_generated_feature"
	f_Number: STRING is					"number"
	f_Obsolete: STRING is				"obsolete_clause"
	f_Origin_comment: STRING is			"origin_comment"
	f_Quoted: STRING is					"quoted"
	f_Reserved_word: STRING is			"reserved_word"
	f_String: STRING is					"string"
	f_String_url: STRING is				"string_url"
	f_Suffix: STRING is					"suffix"
	f_Symbol: STRING is					"symbol"
	f_Symbol_features: STRING is		"symbol_features"
	f_Tab: STRING is					"tab"
	f_Tooltip: STRING is				"tooltip"

	kw_Class: STRING is					"class"
	kw_Feature: STRING is				"feature"
	kw_File: STRING is					"file"
	kw_Generator: STRING is				"generator"
	kw_Root: STRING is					"root"
	kw_Title: STRING is					"title"
	kw_Tooltip: STRING is				"tooltip";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class SHARED_FILTER
