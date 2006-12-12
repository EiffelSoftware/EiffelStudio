indexing
	description: "[
				Abstract representation of a link in a chain-of-responsability 
				pattern that knows how to handle one particular type of dictionary file
					]"
	author: "ES-i18n team (es-i18n@origo.ethz.ch)"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	I18N_FILE_HANDLER


feature  -- chain-of-responsability

		next: I18N_FILE_HANDLER

		set_next (next_handler: I18N_FILE_HANDLER) is
				-- set next handler in chain
				do
					next := next_handler
				ensure
					next_set: next = next_handler
				end

		can_handle (a_path:STRING_32): BOOLEAN is
				-- can this class handle the file pointed to?
				-- Check extension, magic number, doctype or whatever you have to.
			require
				a_path_exists: a_path /= Void
			deferred
			end

		handled: BOOLEAN


feature -- locale

	get_file_scope (a_path: STRING_GENERAL): I18N_FILE_SCOPE_INFORMATION is
			-- get the scope of the file at `a_path'
			-- NOTE: Void if scope cannot be determined from file contents.
		do
			if can_handle(a_path.as_string_32) then
				Result := extract_scope(a_path)
				handled := True
			else
				if next /= Void then
					Result := next.get_file_scope(a_path)
					handled := next.handled
				else
					handled := False
				end
			end
		ensure
			handled_if_can_handle: can_handle(a_path) implies handled
			next_handeld: (not can_handle(a_path)) and then next /= Void implies handled = next.handled
			not_handeled: (not can_handle(a_path)) and then next = Void implies not handled
		end

	extract_scope (a_path: STRING_32): I18N_FILE_SCOPE_INFORMATION is
			-- extract the scope of file at `a_path'
			-- NOTE: Void if scope cannot be determined from file contents
		require
			a_path_exists: a_path /= Void
			can_handle(a_path)
		deferred
		end



feature -- dictionary

	get_file_dictionary (a_path: STRING_32): I18N_DICTIONARY is
			-- get appropriate dictionary for the file at `a_path'
		require
			a_path_exists: a_path /= Void
		do
			if can_handle(a_path.as_string_32) then
				Result := extract_dictionary(a_path)
				handled := True
			else
				if next /= Void then
					Result := next.get_file_dictionary(a_path)
					handled := next.handled
				else
					handled := False
				end
			end
		ensure
			can_handle(a_path) implies handled
			not (can_handle(a_path) and then next /= Void) implies handled = next.handled
			not (can_handle(a_path) and then next = Void) implies not handled
		end


	extract_dictionary (a_path: STRING_32): I18N_DICTIONARY is
			-- Current handler can handle the file at `a_path',
			-- get appropriate dictionary
		require
			a_path_exists: a_path /= Void
			can_handle(a_path)
		deferred
		ensure
			result_exists: Result /= Void
		end



 feature {NONE}
 	-- Implementation
	file: I18N_FILE



end
