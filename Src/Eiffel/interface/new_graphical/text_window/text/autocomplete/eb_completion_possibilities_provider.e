note
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
		rename
			completion_possibilities as feature_completion_possibilities
		redefine
			code_completable,
			completion_possible,
			prepare_completion,
			name_type
		end

feature -- Access

	code_completable: EB_TAB_CODE_COMPLETABLE
			-- A code completable.

	class_completion_possibilities: SORTABLE_ARRAY [like name_type]
			-- Completions proposals found by `prepare_auto_complete'
		require
			is_prepared : is_prepared
		deferred
		end

	alias_name_completion_possibilities: SORTABLE_ARRAY [like name_type]
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

	provide_alias_name: BOOLEAN
			-- Provide `alias_name_completion_possibilities'?

	completion_possible: BOOLEAN
			-- Is completion possible?
		do
			if
				(provide_features implies (attached feature_completion_possibilities as l_f_possibilities and then not l_f_possibilities.is_empty)) and
				(provide_classes implies (attached class_completion_possibilities as l_c_possibilities and then not l_c_possibilities.is_empty)) and
				(provide_alias_name implies True)
			then
				Result := True
			end
		end

	completing_context: BOOLEAN
			-- Is current context suitable to trigger a completion?
		local
			l_token: EDITOR_TOKEN
			l_image: STRING_32
		do
			Result := True
			l_token := cursor_token
			if l_token /= Void then
				if attached {EDITOR_TOKEN_STRING} l_token then
					Result := True
				else
					if l_token.is_text then
						l_image := l_token.wide_image
						if l_image.count > 1 and then current_pos_in_token > 1 then
								-- Will prevent completion of '`.' or '..'
							Result := is_completable_separator_character_32 (l_image [current_pos_in_token - 1])
						end
					end

					l_token := l_token.previous

					if l_token /= Void then
						if attached {EDITOR_TOKEN_COMMENT} l_token then
								-- Previous token is a comment so we cannot complete.
								-- Happens when completing -- A Comment `.|
							Result := False
						elseif l_token.is_text then
								-- Will prevent completion of '22|'
							Result := not attached {EDITOR_TOKEN_NUMBER} l_token

							if Result then
									-- will prevent completion of '"str"|'
								Result := not attached {EDITOR_TOKEN_STRING} l_token
								if Result then
									l_image := l_token.wide_image
									if l_image.count > 1 then
											-- Will prevent completion of '|.' or '..'
										if is_completable_separator_character_32 (l_image [l_image.count]) then
											inspect
												l_image [l_image.count - 1]
											when ')', '}', ']' then
												Result := True
											else
												Result := False -- Exclude for instance '|.' or '..' or '|..' or '`.' , ...
											end
										end
									elseif not l_image.is_empty and is_completable_separator (l_image) then
										if attached l_token.previous as prev then
												-- Will prevent completion of '10.|'
											Result := not attached {EDITOR_TOKEN_NUMBER} prev
										end
									end
								end
							end
						end
					end
				end
			end
		end

feature {CODE_COMPLETABLE} -- Basic operation

	prepare_completion
			-- Prepare completion possibilities.
		do
			Precursor {COMPLETION_POSSIBILITIES_PROVIDER}
			provide_features := code_completable.completing_feature
			provide_classes := code_completable.completing_class
			provide_alias_name := code_completable.completing_alias_name
		end

feature -- Element Change

	set_provide_features (a_provide: BOOLEAN)
			-- Set `provide_features' with `a_provide'.
		do
			provide_features := a_provide
			is_prepared := False
		ensure
			provide_features_set: provide_features = a_provide
		end

	set_provide_classes (a_provide: BOOLEAN)
			-- Set `provide_classes' with `a_provide'.
		do
			provide_classes := a_provide
			is_prepared := False
		ensure
			provide_classes_set: provide_classes = a_provide
		end

	set_provide_alias_name (a_provide: BOOLEAN)
			-- Set `provide_alias_name' with `a_provide'.
		do
			provide_alias_name := a_provide
			is_prepared := False
		ensure
			provide_alias_name_set: provide_alias_name = a_provide
		end

feature {NONE} -- Implementation

	cursor_token: EDITOR_TOKEN
			-- Token at cursor position
		deferred
		end

	current_pos_in_token: INTEGER
			-- Pos in token.
		deferred
		end

	analyzer: EB_CLASS_INFO_ANALYZER
			-- Class infor analyzer
		once
			create {EB_CLICK_AND_COMPLETE_TOOL} Result
		ensure
			result_not_void: Result /= Void
		end

	is_completable_separator_character_32 (ch: CHARACTER_32): BOOLEAN
			-- Is `ch' a completable character separator?
		do
			Result := is_completable_separator (create {STRING_32}.make_filled (ch, 1))
		end

	is_completable_separator (a_str: READABLE_STRING_GENERAL): BOOLEAN
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
					if a_str.same_string (l_seps [i]) then
						Result := True
					else
						i := i + 1
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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
