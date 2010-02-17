note
	description: "External iteration cursor used by `across...loop...end'."
	library: "Free implementation of ELKS library"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ITERATION_CURSOR [G]

inherit
	ITERABLE [G]

feature {NONE} -- Initialization

	make (s: like target)
			-- Initialize cursor using structure `s'.
		require
			s_attached: s /= Void
		do
			target := s
			if attached {VERSIONABLE} s as l_versionable then
				version := l_versionable.version
			else
				version := 0
			end
		ensure
			structure_set: target = s
			is_valid: is_valid
		end

feature -- Access

	item: G
			-- Item at current cursor position
		require
			is_valid: is_valid
			is_set: is_set
			valid_position: not off
		deferred
		end

	cursor_index: INTEGER
			-- Index position of cursor in the iteration
		require
			is_valid: is_valid
		attribute
		ensure
			positive_index: Result >= 0
		end

	new_cursor: ITERATION_CURSOR [G]
			-- <Precursor>
			-- Useful for classes not inheriting from ITERABLE but still
			-- wanting to benefit from the `across...loop...end' construct, or for
			-- classes having many ways to traverse a structure.
		do
			Result := Current
		end

feature -- Measurement

	version: NATURAL
			-- Current version
		note
			option: transient
		attribute
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is the cursor still compatible with the associated underlying object?
		do
			Result := attached {VERSIONABLE} target as l_versionable implies l_versionable.version = version
		end

	is_set: BOOLEAN
			-- Are changes to traversal policy prohibited? 			

	off: BOOLEAN
			-- Is cursor currently off, indicating `start' should be called?
		deferred
		end

	frozen after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
			--
			--| Retained for compatibility with the 6.5 compiler.
			--| Uncomment obsolete clause when compiler has switched to use `off'
--		obsolete
--			"Use `off' instead."
		do
			Result := off
		end

feature -- Status setting

	reset
			-- Make structure for a new kind traversal.
		do
			is_set := False
		ensure
			not_set: not is_set
		end

feature -- Cursor movement

	start
			-- Move to first position.
		require
			is_valid: is_valid
		do
			cursor_index := 1
			is_set := True
		ensure
			cursor_index_set_to_one: cursor_index = 1
			is_set: is_set
		end

	forth
			-- Move to next position.
		require
			is_valid: is_valid
			is_set: is_set
			valid_position: not off
		do
			cursor_index := cursor_index + 1
		ensure
			cursor_index_advanced: cursor_index = old cursor_index + 1
		end

feature {NONE} -- Implementation

	target: ITERABLE [G]
			-- Associated structure used for iteration

invariant
	target_attached: target /= Void

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
