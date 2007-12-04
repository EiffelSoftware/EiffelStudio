indexing
	description: "[
		A service to access the running editor documents in the EiffelStudio IDE.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	EDITOR_DOCUMENTS_TABLE_S

inherit
	USEABLE_I

feature -- Access

	open_documents: DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of currently opened documents in all windows.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent {EDITOR_DOCUMENT_I}.is_interface_usable)
		end

	modified_documents: DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of all modified documents from all windows.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent {EDITOR_DOCUMENT_I}.is_interface_usable)
		end

	last_active_document: EDITOR_DOCUMENT_I
			-- Last active document in last active window.
			-- Note: There may not be a document open in the editor, in which case Void will be returned.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature -- Query

	open_documents_in_window (a_window: EB_DEVELOPMENT_WINDOW): DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of currently opened documents in a specific windows.
			--
			-- `a_window': A window to retrieve a the opened document for.
			-- `Result': A list of opened documents in the specified window.
		require
			is_interface_usable: is_interface_usable
			not_a_window_is_recycled: not a_window.is_recycled
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent {EDITOR_DOCUMENT_I}.is_interface_usable)
			result_items_window_matches: Result.for_all (agent (a_ia_doc: EDITOR_DOCUMENT_I; a_ia_window: EB_DEVELOPMENT_WINDOW): BOOLEAN
				do
					Result := a_ia_doc.window = a_ia_window
				end (?, a_window))
		end

	modified_documents_in_window (a_window: EB_DEVELOPMENT_WINDOW): DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of all modified documents from all windows.
			--
			-- `a_window': A window to retrieve a the modified active document for.
			-- `Result': A list of modified documents in the specified window.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		deferred
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_contains_usable_items: Result.for_all (agent {EDITOR_DOCUMENT_I}.is_interface_usable)
			result_items_window_matches: Result.for_all (agent (a_ia_doc: EDITOR_DOCUMENT_I; a_ia_window: EB_DEVELOPMENT_WINDOW): BOOLEAN
				do
					Result := a_ia_doc.window = a_ia_window
				end (?, a_window))
		end

	last_active_document_in_window (a_window: EB_DEVELOPMENT_WINDOW): EDITOR_DOCUMENT_I
			-- Last active document in last active window.
			--
			-- `a_window': A window to retrieve a the last active document for.
			-- `Result': The last active document, or Void if there are not open documents in the editor
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			not_a_window_is_recycled: not a_window.is_recycled
		deferred
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_window_matches: Result /= Void implies Result.window = a_window
		end

	is_valid_document_stone (a_stone: STONE): BOOLEAN
			-- Determines if a stone is a valid document stone.
			--
			-- `a_stone': Stone to validate.
			-- `Result': True if the stone represents a document that can be opened using this service, False otherwise.
		require
			is_interface_usable: is_interface_usable
			a_stone_attached: a_stone /= Void
		deferred
		end

feature -- Basic operation

	open_document_via_stone (a_stone: STONE; a_window: EB_DEVELOPMENT_WINDOW)
			-- Opens a document in the editor using the stone `a_stone'.
			-- Note: If the stone is not valid, no document will be opened.
			--
			-- `a_stone': The stone, representing a document, to open in the editor.
			-- `a_window': Window to open document in, or Void to use the last active window.
		require
			is_interface_usable: is_interface_usable
			a_stone_attached: a_stone /= Void
			a_stone_is_valid_document_stone: is_valid_document_stone (a_stone)
			not_a_window_is_recycled: a_window /= Void implies not a_window.is_recycled
		deferred
		end

feature -- Events

	document_opened_event: EVENT_TYPE [TUPLE [EDITOR_DOCUMENT_I]]
			-- Events called when a document is opened in the editor.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

	document_closed_event: EVENT_TYPE [TUPLE [EDITOR_DOCUMENT_I]]
			-- Events called when a document is closed in the editor.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

	document_activated_event: EVENT_TYPE [TUPLE [EDITOR_DOCUMENT_I]]
			-- Events called when a document is switched to in the editor.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

	document_deactivated_event: EVENT_TYPE [TUPLE [EDITOR_DOCUMENT_I]]
			-- Events called when a document is switched from in the editor.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
