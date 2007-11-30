indexing
	description: "Objects that provide code completion possibilities for a code completable"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_COMPLETION_POSSIBILITIES_PROVIDER

inherit
	COMPLETION_POSSIBILITIES_PROVIDER
		redefine
			code_completable,
			completion_possible,
			prepare_completion,
			name_type
		end

feature -- Access

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- A code completable.

	class_completion_possibilities: SORTABLE_ARRAY [like name_type] is
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	name_type: EB_NAME_FOR_COMPLETION

feature -- Status report

	provide_features: BOOLEAN
			-- Provide `completion_possibilities'?

	provide_classes: BOOLEAN
			-- Provide `class_completion_possibilities'?

	completion_possible: BOOLEAN is
			-- Is completion possible?
		do
			if
				(provide_features implies (completion_possibilities /= Void and then not completion_possibilities.is_empty)) and
				(provide_classes implies (class_completion_possibilities /= Void and then not class_completion_possibilities.is_empty))
			then
				Result := true
			end
		end

	completing_context: BOOLEAN is
			-- Is current context suitable to trigger an completion?
		local
			l_token: EDITOR_TOKEN
			l_image: STRING
			l_comment: EDITOR_TOKEN_COMMENT
			l_number: EDITOR_TOKEN_NUMBER
			l_string: EDITOR_TOKEN_STRING
		do
			l_token := cursor_token
			if l_token /= Void then
				if l_token.is_text then
					l_image := l_token.image
					if l_image.count > 1 and then current_pos_in_token > 1 then
							-- Will prevent completion of '`.' or '..'
						Result := is_completable_separator (l_image.item (current_pos_in_token - 1).out)
					end
				end

				l_token := l_token.previous

				if l_token /= Void then
					l_comment ?= l_token
					if l_comment /= Void then
							-- Previous token is a comment so we cannot complete.
							-- Happens when completing -- A Comment `.|
						Result := True
					elseif l_token.is_text then
							-- Will prevent completion of '22|'
						l_number ?= l_token
						Result := l_number /= Void

						if not Result then
							l_string ?= l_token
							Result := l_string /= Void
							if not Result then
								l_image := l_token.image
								if l_image.count > 1 then
										-- Will prevent completion of '|.' or '..'
									Result := is_completable_separator (l_image.item (l_image.count).out)
								elseif not l_image.is_empty and is_completable_separator (l_image) then
									if l_token.previous /= Void then
											-- Will prevent completion of '10.|'
										l_number ?= l_token.previous
										Result := l_number /= Void
									end
								end
							end
						end
					end
				end
			end
			Result := not Result
		end

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion is
			-- Prepare completion possibilities.
		do
			Precursor {COMPLETION_POSSIBILITIES_PROVIDER}
			provide_features := code_completable.completing_feature
			provide_classes := not code_completable.completing_feature
		end

feature -- Element Change

	set_provide_features (a_provide: BOOLEAN) is
			-- Set `provide_features' with `a_provide'.
		do
			provide_features := a_provide
			is_prepared := false
		ensure
			provide_features_set: provide_features = a_provide
		end

	set_provide_classes (a_provide: BOOLEAN) is
			-- Set `provide_classes' with `a_provide'.
		do
			provide_classes := a_provide
			is_prepared := false
		ensure
			provide_classes_set: provide_classes = a_provide
		end

feature {NONE} -- Implementation

	cursor_token: EDITOR_TOKEN is
			-- Token at cursor position
		deferred
		end

	current_pos_in_token: INTEGER is
			-- Pos in token.
		deferred
		end

	analyzer: EB_CLASS_INFO_ANALYZER is
			-- Class infor analyzer
		once
			create {EB_CLICK_AND_COMPLETE_TOOL} Result
		ensure
			result_not_void: Result /= Void
		end

	is_completable_separator (a_str: STRING): BOOLEAN is
			-- Is `a_str' a completable string separator?
		local
			i: INTEGER
			l_seps: ARRAY [STRING]
		do
			l_seps := analyzer.feature_call_separators
			if l_seps /= Void and then not l_seps.is_empty then
				from
					i := l_seps.lower
				until
					Result or i > l_seps.upper
				loop
					if (l_seps.item (i)).is_equal (a_str) then
						Result := True
					else
						i := i + 1
					end
				end
			end
		end

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
end
