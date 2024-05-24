note
	description: "Add setter for a feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	COMPOSER_FEATURE_REMOVER

inherit
	COMPOSER_ACTION

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		undefine
			default_create
		end

	INTERNAL_COMPILER_STRING_EXPORTER

	AST_ITERATOR
		redefine
			process_feature_as,
			process_eiffel_list
		end

create
	make

feature -- Status

	feature_set: BOOLEAN
			-- Has the the feature to remove been set?
		do
			Result := feature_i /= Void
		end

feature -- Element change

	set_feature (a_feature: FEATURE_I)
			-- The feature that get's removed
		require
			a_feature_not_void: a_feature /= Void
		do
			feature_i := a_feature
		ensure
			feature_set_correct: feature_set and feature_i = a_feature
		end

feature -- Access

	feature_i: detachable FEATURE_I;
			-- The associated feature

feature -- Main operation

	execute
			-- Execute the composer operation.
		local
			ctm: ES_CLASS_TEXT_AST_MODIFIER
		do
			if
				attached feature_i as l_feat_i and then
				attached l_feat_i.written_class.lace_class as l_class_i and then
				attached l_class_i.compiled_class as c
			then
				create ctm.make (l_class_i)
				ctm.execute_batch_modifications (agent (modifier: ES_CLASS_TEXT_AST_MODIFIER; fi: FEATURE_I)
					local
						a: CLASS_AS
						s: TUPLE [start_position: INTEGER_32; end_position: INTEGER_32]
						r: ERT_TOKEN_REGION
					do
						a := modifier.ast
						s := modifier.ast_position (a)
						r := a.token_region (modifier.ast_match_list)

						if attached modifier.ast.feature_of_name_32 (fi.feature_name_32, False) as f_as then
							feature_as_to_remove := f_as
							level_found := -1
							class_modifier := modifier
							process_class_as (a)
--							modifier.remove_ast_code (f_as, {ES_CLASS_TEXT_AST_MODIFIER}.Remove_white_space_trailing)
						end
						if modifier.ast_match_list.is_text_modified (r) then
							modifier.replace_code (s.start_position, s.end_position, modifier.ast_match_list.text_32 (r))
						end

					end(ctm, l_feat_i)
					, True, True
				)
			end
		end

	feature_as_to_remove: detachable FEATURE_AS

	level_found: INTEGER
	level: INTEGER
	class_modifier: ES_CLASS_TEXT_AST_MODIFIER

	process_eiffel_list (l_as: EIFFEL_LIST [AST_EIFFEL])
		do
			level := level + 1
			Precursor (l_as)
			if attached feature_as_to_remove as f and then level_found = level then
--				l_as.prune (f)
				f.replace_text ("", class_modifier.ast_match_list)
				feature_as_to_remove := Void
			end
			level := level - 1
		end

	process_feature_as (l_as: FEATURE_AS)
		do
			if l_as = feature_as_to_remove then
				level_found := level
			end
			Precursor (l_as)
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
