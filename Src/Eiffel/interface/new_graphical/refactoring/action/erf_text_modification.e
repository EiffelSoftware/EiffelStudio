note
	description: "This allows undoable text modifications."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERF_TEXT_MODIFICATION

inherit
	ERF_ACTION
		redefine
			destroy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EC_ENCODINGS
		export
			{NONE} all
		end

feature -- Status report

	text_managed: BOOLEAN
			-- Is the text prepared?
		do
			Result := text /= Void
		end

	undo_managed: BOOLEAN
			-- Are there undo informations associated?
		do
			Result := undo_redo /= Void
		end

	is_modified: BOOLEAN
			-- Is the text modified?

feature -- Prepare/Commit

	prepare
			-- Prepare the text for edit.
		require
			not_undo_managed: not undo_managed	-- We can't prepare if we have already undo informations
			not_text_managed: not text_managed
		do
			load_text
			original_text := text.twin
			is_modified := False
		ensure
			text_managed: text_managed
			not_modified: not is_modified
		end

	commit
			-- Commit text modifications.
		require
			text_managed: text_managed
		local
			diff: DIFF_TEXT
			file: RAW_FILE
			undo_patch: STRING_8
		do
				-- Compute and store undo if something changed
			if is_modified then
				create diff
				diff.set_text (text, original_text)
				diff.compute_diff
				undo_patch := diff.unified

				if not undo_patch.is_empty then
					create file.make_open_temporary_with_prefix (eiffel_layout.temporary_path.extended ("tmp-erf-").name)
					file.put_string (undo_patch)
					file.close
					undo_redo := file.path.utf_8_name
				else
					undo_redo := Void
				end

				save_text
			end
			discard_text
		ensure
			not_text_managed: not text_managed
			not_modified: not is_modified
		end

feature -- Element change

	load_text
			-- Load the text.
		require
			not_text_managed: not text_managed
		deferred
		ensure
			text_managed: text_managed
		end

	save_text
			-- Save the text.
		require
			text_managed: text_managed
		deferred
		end

	discard_text
			-- Discard the text.
		require
			text_managed: text_managed
		do
			original_text := Void
			text := Void
			is_modified := False
		ensure
			not_text_managed: not text_managed
			not_modified: not is_modified
		end

	discard_undo
			-- Discard the undo informations.
		local
			file: RAW_FILE
		do
			if attached undo_redo as l_undo_redo and then not l_undo_redo.is_empty then
				create file.make_with_name (l_undo_redo)
				if file.exists then
					file.delete
				end
			end
			undo_redo := Void
		ensure
			not_undo_managed: not undo_managed
		end

	set_changed_text (a_text: like text)
			-- Set the changed text.
		require
			text_managed: text_managed
			a_text_not_void: a_text /= Void
		do
			text := a_text
			is_modified := True
		ensure
			modified: is_modified
		end

feature -- Basic operations

	undo
			-- Undo the actions.
		local
			diff: DIFF_TEXT
			file: RAW_FILE
		do
			if attached undo_redo as l_undo_redo and then not l_undo_redo.is_empty then
				if text_managed then
					discard_text
				end

				if not text_managed then
					load_text
				end

				create diff
				create file.make_open_read (undo_redo)
				file.read_stream (file.count)
				text := diff.patch (text, file.last_string, False)
				file.close

				save_text
				discard_text
			end
		end

	redo
			-- Redo the actions.
		local
			diff: DIFF_TEXT
			file: RAW_FILE
		do
			if attached undo_redo as l_undo_redo and then not l_undo_redo.is_empty then
				if text_managed then
					discard_text
				end

				if not text_managed then
					load_text
				end

				create diff
				create file.make_open_read (undo_redo)
				file.read_stream (file.count)
				text := diff.patch (text, file.last_string, True)
				file.close

				save_text
				discard_text
			end
		end

feature -- Removal

	destroy
			-- Called before the object is destroyed.
		do
			if undo_managed then
				discard_undo
			end
		end

feature {NONE} -- Implementation

	original_text: detachable STRING_8
			-- Original text we loaded.

	text: detachable STRING_8
			-- Text to work on.
			-- Treat text as bytes stream. UTF-8 encoded.

	undo_redo: detachable STRING_8
			-- Undo/redo informations

invariant
	modified_needs_text_managed: is_modified implies text_managed

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
