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
	EIFFEL_EDITOR_DOCUMENT

inherit
	EDITOR_DOCUMENT_I

	SAFE_AUTO_DISPOSABLE

create
	make

feature {NONE} -- Initialization

	make (a_editor: like current_editor)
		require
			a_editor_attached: a_editor /= Void
			not_a_editor_is_recycled: not a_editor.is_recycled
		do
			current_editor := a_editor
			create internal_editors.make (1)
			internal_editors.put_last (a_editor)
		ensure
			current_editor_set: current_editor = a_editor
			editors_has_a_editor: editors.has (a_editor)
		end

feature -- Access

	moniker: STRING_32
			-- Document moniker
		do
			Result := current_editor.file_name.out.as_string_32
		end

	kind: UUID
			-- Document kind identifier, see {EDITOR_DOCUMENT_KINDS}.
		once
			Result := (create {EDITOR_DOCUMENT_KINDS}).eiffel_class_editor_kind
		end

	window: EB_DEVELOPMENT_WINDOW
			-- Document's host window
		do
			Result := current_editor.dev_window
		end

	current_editor: EB_SMART_EDITOR
			-- Active editor of document, which may be Void in the case of no editor

	editors: DS_BILINEAR [ANY]
			-- List of editors modifying the document
		do
			Result := internal_editors
		end

	data: ANY
			-- Document custom data

feature -- Status report

	is_dirty: BOOLEAN
			-- Indicates if the document has been modified
		do

		end

feature {NONE} -- Internal implementation cache

	internal_editors: DS_ARRAYED_LIST [ANY]
			-- Mutable version of `editors'

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
