indexing
	description:
		"Interface for GUI lookup"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GUI_I

feature -- Access

	application_under_test: EV_APPLICATION is
			-- Application under test
		deferred
		end

	screen: EV_SCREEN is
			-- Screen
		deferred
		end

	active_window: EV_WINDOW is
			-- Active window which is used for identifiable lookup
		deferred
		end

feature -- Status report

	has_active_window: BOOLEAN is
			-- Is an active window set?
		do
			Result := active_window /= Void
		end

feature -- Element change	

	set_active_window (a_window: like active_window) is
			-- Set `active_window' to `a_window'.
		require
			a_window_not_void: a_window /= Void
			a_window_valid: application_under_test.windows.has (a_window)
		deferred
		ensure
			active_window_set: active_window = a_window
		end

feature -- Window lookup

	window_by_identifier (an_identifier: STRING): EV_WINDOW is
			-- Window which has `an_identifier' as `identifier_name'.
		require
			an_identifier_not_void: an_identifier /= Void
			an_identifier_not_empty: not an_identifier.is_empty
		deferred
		ensure
			result_correct: -- has_window_with_identifier (an_identifier) implies Result /= Void
		end

	windows_by_identifier (an_identifier: STRING): LIST [EV_WINDOW] is
			-- All windows which have `an_identifier' as `identifier_name'.
		require
			an_identifier_not_void: an_identifier /= Void
			an_identifier_not_empty: not an_identifier.is_empty
		deferred
		ensure
			result_not_void: Result /= Void
			result_correct: -- has_window_with_identifier (an_identifier) implies not Result.is_empty
		end

feature -- Identifiable lookup

	identifiable (a_pattern: STRING): EV_IDENTIFIABLE is
			-- Identifiable corresponding to `a_pattern'.
		require
			a_pattern_not_void: a_pattern /= Void
			active_window_set_or_window_specified: not has_active_window implies a_pattern.index_of (':', 1) > 1
			a_pattern_valid: valid_pattern (a_pattern) -- TODO
		deferred
		ensure
			result_correct: -- has_identifiable (a_pattern) implies Result /= Void
		end

	identifiables (a_pattern: STRING): LIST [EV_IDENTIFIABLE] is
			-- All identifiablkes corresponding to `a_pattern'.
		require
			a_pattern_not_void: a_pattern /= Void
			active_window_set_or_window_specified: not has_active_window implies a_pattern.index_of (':', 1) > 1
			a_pattern_valid: valid_pattern (a_pattern) -- TODO
		deferred
		ensure
			result_not_void: Result /= Void
			result_correct: -- has_identifiable (a_pattern) implies not Result.is_empty
		end

feature -- Support

	valid_pattern (a_pattern: STRING): BOOLEAN is
			-- Is `a_pattern' valid to use for searching?
		local
			l_tokens: LIST [STRING]
			l_last_was_empty: BOOLEAN
		do
			if a_pattern /= Void and then not a_pattern.is_empty then
				l_tokens := a_pattern.split (':')
				if l_tokens.count = 2 then
					Result := valid_token (l_tokens.first)
				elseif l_tokens.count = 1 then
					Result := True
				end
				if Result then
					l_last_was_empty := True
					from
						l_tokens := l_tokens.last.split ('.')
						l_tokens.start
					until
						l_tokens.after or not Result
					loop
						if l_tokens.item.is_empty then
							Result := not l_last_was_empty
							l_last_was_empty := True
						else
							Result := valid_token (l_tokens.item)
							l_last_was_empty := False
						end
						l_tokens.forth
					end
				end
			end
		end

feature {NONE} -- Implementation

	valid_token (a_token: STRING): BOOLEAN is
			-- Is `a_token' valid to use in a path?
		local
			l_brace_index: INTEGER
		do
			if a_token /= Void and then not a_token.is_empty then
				l_brace_index := a_token.index_of ('}', 1)
				if l_brace_index > 0 then
					if l_brace_index = a_token.count then
						Result :=
							a_token.index_of ('{', 1) = 1 and then
							a_token.count > 2
					else
						Result :=
							a_token.index_of ('{', 1) = 1 and then
							a_token.index_of ('{', l_brace_index) = 0 and then
							a_token.index_of ('}', l_brace_index + 1) = 0
					end
				else
					Result := a_token.index_of ('{', 1) = 0
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
