note
	description:
		"Generic class to parse the AST tree."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	CODE_INIT_ATTRIBUTES

inherit
	AST_NULL_VISITOR
		redefine
			process_feature_clause_as,
			process_feature_as,
			process_class_as
		end

	CODE_AST_HISTORIC

create
	make

feature {NONE} -- Creation

	make
			-- Create and initialize `Current'
		do
			clear_cast_expressions
			clear_type_attributes
			clear_variables
		end

feature {AST_YACC} -- Initialization

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
		local
			l_features: EIFFEL_LIST [FEATURE_AS]
		do
			l_features := l_as.features
			if l_features /= Void then
				from
					l_features.start
				until
					l_features.after
				loop
					l_features.item.process (Current)
					l_features.forth
				end
			end
		end

	process_feature_as (l_as: FEATURE_AS)
		local
			l_converter: CODE_TYPE_CONVERTER_EIFFEL_TO_DOTNET
		do
			if l_as.is_attribute then
				create l_converter
				add_attribute (l_as.feature_name.name, l_converter.dotnet_type_name (l_as.body.type.dump))
			end
		end

	process_class_as (l_as: CLASS_AS)
		local
			l_features: EIFFEL_LIST [FEATURE_CLAUSE_AS]
			l_parents: EIFFEL_LIST [PARENT_AS]
		do
			l_features := l_as.features
			if l_features /= Void then
				from
					l_features.start
				until
					l_features.after
				loop
					l_features.item.process (Current)
					l_features.forth
				end
			end

			l_parents := l_as.parents
			if l_parents /= Void then
				from
					l_parents.start
				until
					l_parents.after
				loop
					l_parents.item.process (Current)
					l_parents.forth
				end
			end
		end

note
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
end -- CODE_INIT_ATTRIBUTES

