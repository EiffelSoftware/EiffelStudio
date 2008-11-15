indexing
	description: "[
		A feature-level AST-augmented Eiffel code class text modifier.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_FEATURE_TEXT_AST_MODIFIER

inherit
	ES_CLASS_TEXT_AST_MODIFIER
		rename
			make as make_with_class
		redefine
			modified_data,
			new_modified_data
		end

create
	make

feature {NONE} -- Initialization

	make (a_feature: !like context_feature; a_class: !like context_class)
			-- Initialize a contract text modifier for a feature
			--
			-- `a_class': Associated context class to modify class text for.
			-- `a_feature': Associated context feature to modify the class text for.
		require
			a_class_is_compiled: a_class.is_compiled
		do
			context_feature := find_actual_context_feature (a_feature, a_class)
			make_with_class (a_class)
		ensure
			context_feature_set: equal (context_feature, find_actual_context_feature (a_feature, a_class))
			context_class_set: context_class = a_class
		end

feature -- Access

	ast_feature: ?FEATURE_AS
			-- Resulting feature AST node.
			-- Note: This is the original AST node not the modified one. To access the modified one
			--       the changes must be commited and the ast re-prepared.
		require
			is_prepared: is_prepared
			is_ast_available: is_ast_available
		do
			Result := modified_data.ast_feature
		end

	context_feature: !E_FEATURE
			-- Context feature.

feature {NONE} -- Access

	modified_data: !ES_FEATURE_TEXT_AST_MODIFIER_DATA
			-- <Precursor>

feature {NONE} -- Query

	find_actual_context_feature (a_feature: !like context_feature; a_class: !like context_class): !like context_feature is
			-- Locates the actual context feature given a class.
			--
			-- `a_feature': The feature to resolve an actual feature for.
			-- `a_class': The class to retrieve a feature from.
			-- `Result': A feature that actually is belongs of the supplied class.
		require
			is_interface_usable: is_interface_usable
			a_class_is_compiled: a_class.is_compiled
		local
			l_feature_i: ?FEATURE_I
			l_class_c: CLASS_C
			l_result: ?like context_feature
		do
			if a_class.is_compiled then
				l_class_c := a_class.compiled_class
				if l_class_c /= Void then
					if a_feature.written_in = l_class_c.class_id then
						l_result := a_feature
					elseif l_class_c.has_feature_table then
						l_feature_i := l_class_c.feature_table.feature_of_rout_id_set (a_feature.rout_id_set)
						check l_feature_i_attached: l_feature_i /= Void end
						if l_feature_i /= Void and then l_feature_i.written_class = l_class_c then
							l_result := l_feature_i.api_feature (l_class_c.class_id)
						end
					end
				end
			end

			if l_result = Void then
					-- Should never end up here!
				Result := a_feature
			else
				Result := l_result
			end
		end

feature {NONE} -- Factory

	new_modified_data: !like modified_data
			-- <Precursor>
		local
			l_class: !like context_class
			l_editor: like active_editor_for_class
			l_text: !STRING_32
		do
			l_class := context_class
			l_editor := active_editor_for_class (l_class)
			if l_editor = Void then
					-- There's no open editor, use the class text from disk instead.
				l_text := original_text
			else
				create l_text.make_from_string (l_editor.wide_text)
			end
			create Result.make (l_class, context_feature, l_text)
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
