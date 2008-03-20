indexing
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_FEATURE_TEXT_AST_MODIFIER_DATA

inherit
	ES_CLASS_TEXT_AST_MODIFIER_DATA
		rename
			make as make_with_class
		redefine
			is_ast_available,
			prepare,
			reset
		end

create
	make

feature {NONE} -- Initialization

	make (a_class: !like associated_class; a_feature: !like associated_feature; a_text: !like text)
			-- Initializes the data required to perform class modifications.
			--
			-- `a_class': The associated class to perform modifications on.
			-- `a_feature': The associated feature to perform modifications on.
			-- `a_text': Actual class text to modify.
		do
			associated_feature := a_feature
			make_with_class (a_class, a_text)
		ensure
			associated_class_set: associated_class = a_class
			associated_feature_set: associated_feature = a_feature
			text_set: text.is_equal (a_text)
		end

feature -- Access

	ast_feature: ?FEATURE_AS
			-- Root AST node of prepared class.

feature {NONE} -- Access

	associated_feature: !E_FEATURE
			-- Feature associated with Current

feature -- Status report

	is_ast_available: BOOLEAN
			-- Indicates if the AST information is available.
		do
			Result := Precursor {ES_CLASS_TEXT_AST_MODIFIER_DATA} and then ast_feature /= Void
		ensure then
			ast_feature_attached: Result implies ast_feature /= Void
		end

feature -- Basic operations

	prepare
			-- <Precursor>
		local
			l_ast: like ast
		do
			Precursor {ES_CLASS_TEXT_AST_MODIFIER_DATA}
			l_ast := ast
			if l_ast /= Void then
				ast_feature := l_ast.feature_of_name (associated_feature.name, False)
			end
		end

feature {ES_CLASS_TEXT_MODIFIER} -- Basic operations

	reset
			-- <Precursor>
		do
			Precursor {ES_CLASS_TEXT_AST_MODIFIER_DATA}
			ast_feature := Void
		ensure then
			ast_feature: ast_feature = Void
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
