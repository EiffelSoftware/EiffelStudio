indexing
	description: "[

		Note: Service is not yet in effect. This was developed early in 6.2 but was not used. Hopefully it
		      will be available in a release post 6.2.

		      Please do not use the service until it is available as the interface may change.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EDITOR_DOCUMENTS_TABLE

inherit
	EDITOR_DOCUMENTS_TABLE_S

	EVENT_OBSERVER_CONNECTION [!EDITOR_DOCUMENTS_TABLE_EVENT_OBSERVER]
		redefine
			safe_dispose,
			is_interface_usable
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes editor document table service
		do
			create documents.make_default
			create document_activated_event
			create document_closed_event
			create document_deactivated_event
			create document_opened_event
		end

feature {NONE} -- Clean up

	safe_dispose (a_disposing: BOOLEAN) is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			--
			-- `a_disposing': True if Current is being explictly disposed of, False to indicate finalization.
		do
			document_activated_event.dispose
			document_closed_event.dispose
			document_deactivated_event.dispose
			document_opened_event.dispose

			Precursor {EVENT_OBSERVER_CONNECTION} (a_disposing)
		end

feature -- Access

	open_documents: DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of currently opened documents in all windows.
		local
			l_result: DS_ARRAYED_LIST [EDITOR_DOCUMENT_I]
		do
			create l_result.make_default
			documents.keys.do_all (agent (a_ia_key: NATURAL_32; a_ia_result: DS_ARRAYED_LIST [EDITOR_DOCUMENT_I])
					-- Add all documents
				local
					l_window: EB_DEVELOPMENT_WINDOW
				do
					l_window := window_manager.development_window_from_id (a_ia_key)
					if l_window /= Void and then not l_window.is_recycled then
						a_ia_result.append_last (open_documents_in_window (l_window))
					end
				end (?, l_result))
			Result := l_result
		end

	modified_documents: DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of all modified documents from all windows.
		local
			l_result: DS_ARRAYED_LIST [EDITOR_DOCUMENT_I]
		do
			create l_result.make_default
			documents.keys.do_all (agent (a_ia_key: NATURAL_32; a_ia_result: DS_ARRAYED_LIST [EDITOR_DOCUMENT_I])
					-- Add all documents
				local
					l_window: EB_DEVELOPMENT_WINDOW
				do
					l_window := window_manager.development_window_from_id (a_ia_key)
					if l_window /= Void and then not l_window.is_recycled then
						a_ia_result.append_last (modified_documents_in_window (l_window))
					end
				end (?, l_result))
			Result := l_result
		end

	last_active_document: EDITOR_DOCUMENT_I
			-- Last active document in last active window.
			-- Note: There may not be a document open in the editor, in which case Void will be returned.

	last_opened_document: EDITOR_DOCUMENT_I
			-- Last opened document
			-- Note: Will be Void when no documents have been opened or all documents are closed.

feature {NONE} -- Access

	documents: DS_HASH_TABLE [DS_LIST [EDITOR_DOCUMENT_I], NATURAL_32]
			-- Table of running documents indexed by a window id
			--
			-- Key: IDE window ({EB_DEVELOPMENT_WINDOW}.window_id)
			-- Value: List of opened documents

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Determines if the interface was usable
		do
			Result := Precursor {EVENT_OBSERVER_CONNECTION}
--			if Result then
--					-- We need at least one window to work with the editor documents table.
--				Result := window_manager.windows /= Void -- and then not window_manager.windows.is_empty
--			end
		end

feature -- Query

	open_documents_in_window (a_window: EB_DEVELOPMENT_WINDOW): DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of currently opened documents in a specific windows.
			--
			-- `a_window': A window to retrieve a the opened document for.
			-- `Result': A list of opened documents in the specified window.
		do
			Result := documents_for_window (a_window.window_id).twin
		end

	modified_documents_in_window (a_window: EB_DEVELOPMENT_WINDOW): DS_BILINEAR [EDITOR_DOCUMENT_I]
			-- List of all modified documents from all windows.
			--
			-- `a_window': A window to retrieve a the modified active document for.
			-- `Result': A list of modified documents in the specified window.
		local
			l_result: like documents_for_window
		do
			l_result := documents_for_window (a_window.window_id).twin
			from l_result.start until l_result.after loop
				if l_result.item_for_iteration.is_dirty then
					l_result.forth
				else
						-- Remove clean documents
					l_result.remove_at
				end
			end
			Result := l_result
		end

	last_active_document_in_window (a_window: EB_DEVELOPMENT_WINDOW): EDITOR_DOCUMENT_I
			-- Last active document in last active window.
			--
			-- `a_window': A window to retrieve a the last active document for.
			-- `Result': The last active document, or Void if there are not open documents in the editor
		local
			l_manager: EB_EDITORS_MANAGER
			l_editor: EB_SMART_EDITOR
		do
			l_manager := editors_manager_for_window (a_window)
			if l_manager /= Void and then not l_manager.is_recycled then
				l_editor := l_manager.last_focused_editor
				if l_editor /= Void and then not l_editor.is_recycled then
					Result := document_for_editor (l_editor)
				end
			end
		end

	is_valid_document_stone (a_stone: STONE): BOOLEAN
			-- Determines if a stone is a valid document stone.
			--
			-- `a_stone': Stone to validate.
			-- `Result': True if the stone represents a document that can be opened using this service, False otherwise.
		do
			Result := {l_cluster: !CLUSTER_STONE} a_stone or else {l_class: !CLASSI_STONE} a_stone or else {l_line: !LINE_STONE} a_stone
		end

feature -- Basic operation

	open_document_via_stone (a_stone: STONE; a_window: EB_DEVELOPMENT_WINDOW)
			-- Opens a document in the editor using the stone `a_stone'.
			-- Note: If the stone is not valid, no document will be opened.
			--
			-- `a_stone': The stone, representing a document, to open in the editor.
			-- `a_window': Window to open document in, or Void to use the last active window.
		local
			l_windows: BILINEAR [EB_WINDOW]
			l_window: EB_DEVELOPMENT_WINDOW
			l_window_id: NATURAL_32
			l_manager: EB_EDITORS_MANAGER
			l_checker: EB_STONE_FIRST_CHECKER
			l_editor: EB_SMART_EDITOR
			l_documents: like documents_for_window
			l_document: like create_document
		do
			if a_window = Void then
					-- No window defined so iterate through all windows to attempt to locate editor for the stone.
				l_windows := window_manager.windows
				from l_windows.start until l_windows.after or l_editor /= Void loop
					l_window ?= l_windows.item
					if l_window /= Void and then not l_window.is_recycled then
						l_manager := editors_manager_for_window (l_window)
						if l_manager /= Void and then not l_manager.is_recycled and then l_manager.stone_acceptable (a_stone) then
							l_editor := l_manager.editor_with_stone (a_stone)
						end
					end
					l_windows.forth
				end

				if l_editor = Void then
						-- Use last active window
					l_window := window_manager.last_focused_development_window
				else
						-- An editor was located, so use that window and discard the editor as it's refetched
					l_window := l_editor.dev_window
				end
			else
					-- Client specified a window so use the window to open the editor
				l_window := a_window
				l_manager:= editors_manager_for_window (l_window)
				if l_manager /= Void and then not l_manager.is_recycled and then l_manager.stone_acceptable (a_stone) then
					l_editor := l_manager.editor_with_stone (a_stone)
				end
			end

			check
				l_window_attached: l_window /= Void
				not_l_window_is_recycled: not l_window.is_recycled
			end

			if l_editor = Void then
					-- There is no editor, so we should create one
				create l_checker.make (l_window)
				l_checker.set_stone_after_first_check (a_stone)
				l_editor := l_manager.editor_with_stone (a_stone)
			else
				create l_checker.make (l_window)
				l_checker.set_stone_after_first_check (a_stone)
			end

			if l_editor /= Void and then not l_editor.is_recycled then
				l_document := document_for_editor (l_editor)
				if l_document = Void then
						-- Create new editor document and add to the list of managed documents
					l_window_id := l_window.window_id
					l_document := create_document (l_editor)
					l_documents := documents_for_window (l_window_id)
						-- Set focus in/out actions for service notification.
						-- Action hook up is done here because we know we the editor is new because a new document is created for it.
					l_editor.register_action (l_editor.editor_drawing_area.focus_in_actions, agent on_document_activated (l_document))
					l_editor.register_action (l_editor.editor_drawing_area.focus_out_actions, agent on_document_deactivated (l_document))

						-- Set last parameters
					last_opened_document := l_document

						-- Register the close actions here, because they have not been registers yet.
					l_editor.register_action (l_manager.editor_closed_actions, agent on_document_closed (?, l_document))

					if not l_documents.has (l_document) then
						l_documents.force_last (l_document)
							-- Publish open events
						document_opened_event.publish ([l_document])
					else
						if last_active_document /= Void then
							document_deactivated_event.publish ([last_active_document])
						end
						document_activated_event.publish ([l_document])
						last_active_document := l_document
					end
				else
					if last_active_document /= Void then
						document_deactivated_event.publish ([last_active_document])
					end
					document_activated_event.publish ([l_document])
					last_active_document := l_document
				end
			end


		end

feature -- Events

	document_opened_event: EVENT_TYPE [TUPLE [document: EDITOR_DOCUMENT_I]]
			-- Events called when a document is opened in the editor.

	document_closed_event: EVENT_TYPE [TUPLE [document: EDITOR_DOCUMENT_I]]
			-- Events called when a document is closed in the editor.

	document_activated_event: EVENT_TYPE [TUPLE [document: EDITOR_DOCUMENT_I]]
			-- Events called when a document is switched to in the editor.

	document_deactivated_event: EVENT_TYPE [TUPLE [document: EDITOR_DOCUMENT_I]]
			-- Events called when a document is switched from in the editor.

feature {NONE} -- Action handlers

	on_document_activated (a_document: EDITOR_DOCUMENT_I)
			-- Called when a document has been activated
		require
			a_document_attached: a_document /= Void
			a_document_is_interface_usable: a_document.is_interface_usable
		do
			last_active_document := a_document
		ensure
			last_active_document_set: last_active_document = a_document
		end

	on_document_deactivated (a_document: EDITOR_DOCUMENT_I)
			-- Called when a document has been deactivated
		require
			a_document_attached: a_document /= Void
		do
			last_active_document := Void
		ensure
			last_active_document_detached: last_active_document = Void
		end

	on_document_closed (a_editor: EB_SMART_EDITOR; a_document: EDITOR_DOCUMENT_I)
			-- Called when a document is closed
		require
			a_editor_attached: a_editor /= Void
			a_document_attached: a_document /= Void
		local
			l_disposable: DISPOSABLE
			l_documents: DS_LIST [EDITOR_DOCUMENT_I]
		do
			if a_document.is_interface_usable and then documents.has (a_document.window.window_id) then
					-- Remove the document from the list of managed documents
				l_documents := documents.item (a_document.window.window_id)
				l_documents.start
				l_documents.search_forth (a_document)
				check not_l_documents_after: not l_documents.after end
				if not l_documents.after then
					l_documents.remove_at
				end
			end

				-- Publish the removal event
			document_closed_event.publish ([a_document])

			l_disposable ?= a_document
			if l_disposable /= Void then
					-- Clean up document
				l_disposable.dispose
			end
		end

feature {NONE} -- Document management

	editors_manager_for_window (a_window: EB_DEVELOPMENT_WINDOW): EB_EDITORS_MANAGER
			-- Retrieve an editor manager for a given IDE window
			--
			-- `a_window': The IDE window to retrieve an editors manager for, or Void to retrieve the last
			--             active IDE window's editors manager
			-- `Result': An editors manager for the IDE window.
		require
			is_interface_usable: is_interface_usable
			not_a_window_is_recycled: a_window /= Void implies not a_window.is_recycled
		local
			l_window: EB_DEVELOPMENT_WINDOW
		do
			if a_window = Void then
				l_window := window_manager.last_focused_development_window
			else
				l_window := a_window
			end
			check
				l_window_attached: l_window /= Void
				not_l_window_is_recycled: not l_window.is_recycled
			end
			Result := l_window.editors_manager
		end

	documents_for_window (a_window_id: NATURAL_32): DS_LIST [EDITOR_DOCUMENT_I]
			-- Retrieves the live document list for an IDE window
			--
			-- `a_window_id': The list to
		require
			is_interface_usable: is_interface_usable
			a_window_id_positive: a_window_id > 0
			window_manager_has_a_window_id: window_manager.development_window_from_id (a_window_id) /= Void
		local
			l_documents: like documents
			l_list: DS_ARRAYED_LIST [EDITOR_DOCUMENT_I]
		do
			l_documents := documents
			if not l_documents.has (a_window_id) then
					-- Create new entry
				create l_list.make_default
				l_documents.force_last (l_list, a_window_id)
				Result := l_list
			else
				Result := l_documents.item (a_window_id)
			end
		ensure
			result_attached: Result /= Void
			result_contains_attached_items: not Result.has (Void)
			result_consistent: Result = documents_for_window (a_window_id)
		end

	document_for_editor (a_editor: EB_SMART_EDITOR): EDITOR_DOCUMENT_I is
			-- Attempts to locate the last activated document using an editor
			--
			-- `a_editor': The editor to retrieve the associated document for.
			-- `Result': A document associated with the editor, or Void if the document could not be found.
		require
			is_interface_usable: is_interface_usable
			a_editor_attached: a_editor /= Void
			not_a_editor_is_recycled: not a_editor.is_recycled
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_documents: DS_LIST_CURSOR [EDITOR_DOCUMENT_I]
		do
			l_window := a_editor.dev_window
			if l_window /= Void and then not l_window.is_recycled then
				l_documents := documents_for_window (l_window.window_id).new_cursor
				from l_documents.start until l_documents.after or Result /= Void loop
					if l_documents.item.editors.has (a_editor) then
						Result := l_documents.item
					else
						l_documents.forth
					end
				end
			end
		end

feature {NONE} -- Factory

	create_document (a_editor: EB_SMART_EDITOR): EDITOR_DOCUMENT_I
			-- Creates a new document for a
		require
			a_editor_attached: a_editor /= Void
			not_a_editor_is_recycled: not a_editor.is_recycled
		do
			create {EIFFEL_EDITOR_DOCUMENT} Result.make (a_editor)
		ensure
			result_attached: Result /= Void
			result_is_interface_usable: Result.is_interface_usable
		end

invariant
	documents_attached: documents /= Void
	documents_contains_attached_items: not documents.has_item (Void)

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
