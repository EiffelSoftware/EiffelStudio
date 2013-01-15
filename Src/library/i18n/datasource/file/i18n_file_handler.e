note
	description: "[
				Abstract representation of a link in a chain-of-responsability 
				pattern that knows how to handle one particular type of dictionary file
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_FILE_HANDLER

feature -- Status report

	handled: BOOLEAN
			-- Was last file handled by current handler?

	can_handle (a_path: READABLE_STRING_GENERAL): BOOLEAN
			-- Can this class handle the file pointed to?
			--
			-- Check extension, magic number, doctype or whatever you have to.
			--
			-- `a_path': Path to a file which is checked
		require
			a_path_not_void: a_path /= Void
		deferred
		end

feature -- Access

	next: detachable I18N_FILE_HANDLER
			-- Next handler in chain of responsability
			-- Void if this is the last handler

feature -- Element change

	set_next (next_handler: detachable I18N_FILE_HANDLER)
			-- Set `next' to `next_handler'.
			--
			-- `next_handler': The next handler in the chain
		do
			next := next_handler
		ensure
			next_set: next = next_handler
		end

feature -- Locale

	file_scope (a_path: READABLE_STRING_GENERAL): detachable I18N_FILE_SCOPE_INFORMATION
			-- Scope of file represented by `a_path'
			--
			-- NOTE: Void if scope cannot be determined from file contents.
			--
			-- `a_path': Path to a file where scope is extracted
		require
			a_path_not_void: a_path /= Void
		do
			if can_handle (a_path) then
				Result := extract_scope (a_path)
				handled := True
			else
				if attached next as l_next then
					Result := l_next.file_scope (a_path)
					handled := l_next.handled
				else
					handled := False
				end
			end
		ensure
			handled_if_can_handle: can_handle (a_path) implies handled
			next_handeld: (not can_handle (a_path)) and then (attached next as l_next) implies handled = l_next.handled
			not_handeled: (not can_handle (a_path)) and then next = Void implies not handled
		end

feature {NONE} -- Implementation

	extract_scope (a_path: READABLE_STRING_GENERAL): detachable I18N_FILE_SCOPE_INFORMATION
			-- Extract scope of file at `a_path'
			-- NOTE: Void if scope cannot be determined from file contents
		require
			a_path_exists: a_path /= Void
			can_handle(a_path)
		deferred
		end

feature -- Dictionary

	get_file_dictionary (a_path: READABLE_STRING_GENERAL): detachable I18N_DICTIONARY
			-- get appropriate dictionary for the file at `a_path'
		require
			a_path_exists: a_path /= Void
		do
			if can_handle(a_path.as_string_32) then
				Result := extract_dictionary(a_path)
				handled := True
			else
				if attached next as l_next then
					Result := l_next.get_file_dictionary(a_path)
					handled := l_next.handled
				else
					handled := False
				end
			end
		ensure
			handled_if_can_handle: can_handle (a_path) implies handled
			next_handeld: ((not can_handle (a_path)) and then (attached next as l_next))
							implies handled = l_next.handled
			not_handeled: ((not can_handle (a_path)) and then next = Void)
							implies not handled
		end

	extract_dictionary (a_path: READABLE_STRING_GENERAL): I18N_DICTIONARY
			-- Current handler can handle the file at `a_path',
			-- get appropriate dictionary
		require
			a_path_exists: a_path /= Void
			can_handle(a_path)
		deferred
		ensure
			result_exists: Result /= Void
		end

feature {NONE} 	-- Implementation

	file: detachable I18N_FILE;

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
