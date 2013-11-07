note

	description:

		"Cursors for sparse table traversals"

	storable_version: "20130823"
	library: "Gobo Eiffel Structure Library"
	copyright: "Copyright (c) 2000-2013, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class DS_SPARSE_TABLE_CURSOR [G, K]

inherit

	DS_SPARSE_CONTAINER_CURSOR [G, K]
		redefine
			container,
			next_cursor
		end

	DS_BILINEAR_TABLE_CURSOR [G, K]
		undefine
			off
		redefine
			container,
			next_cursor
		end

	DS_DYNAMIC_CURSOR [G]
		redefine
			next_cursor
		end

create

	make

feature -- Access

	key: K
			-- Key at cursor position
		do
			Result := container.cursor_key (Current)
		end

	container: DS_SPARSE_TABLE [G, K]
			-- Table traversed

feature -- Element change

	replace (v: G)
			-- Replace item at cursor position by `v'.
		do
			container.item_storage_put (v, position)
		end

feature {DS_SPARSE_TABLE} -- Implementation

	next_cursor: detachable DS_SPARSE_TABLE_CURSOR [G, K]
			-- Next cursor
			-- (Used by `container' to keep track of traversing
			-- cursors (i.e. cursors associated with `container'
			-- and which are not currently `off').)

end
