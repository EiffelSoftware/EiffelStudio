indexing

	description: "[
		Translations of class names between a storing and a retrieving
		system. Values in this table are names of classes in the retrieving
		system, indexed by names of generating classes in the storing
		system (i.e. with no generic arguments). Values may have generic
		arguments (e.g. "MY_CLASS [DOUBLE]"), thus allowing a very simple
		conversion of a non-generic class into a generic class. The
		presence of entries in this table affects all retrieve operations
		for objects stored using `independent_store'.
		]"
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	status: "See notice at end of class."

class CLASS_NAME_TRANSLATIONS

inherit

	HASH_TABLE [STRING, STRING]
		export
			{NONE} replace_key, remove
		redefine
			put, force, extend, replace,
			clear_all
		end

create
	default_create

feature -- Element change

	put (new: ?STRING; key: ?STRING) is
			-- Insert `new' with `key' if there is no other item
			-- associated with the same key.
			-- Set `inserted' if and only if an insertion has
			-- been made (i.e. `key' was not present).
			-- If so, set `position' to the insertion position.
			-- If not, set `conflict'.
			-- In either case, set `found_item' to the item
			-- now associated with `key' (previous item if
			-- there was one, `new' otherwise).
		do
			Precursor (new, key)
			if inserted then add_translation (new, key) end
		end

	force (new: ?STRING; key: ?STRING) is
			-- Update table so that `new' will be the item associated
			-- with `key'.
			-- If there was an item for that key, set `found'
			-- and set `found_item' to that item.
			-- If there was none, set `not_found' and set
			-- `found_item' to the default value.
		do
			Precursor (new, key)
			add_translation (new, key)
		end

	extend (new: ?STRING; key: ?STRING) is
			-- Assuming there is no item of key `key',
			-- insert `new' with `key'.
			-- Set `inserted'.
		do
			Precursor (new, key)
			add_translation (new, key)
		end

	replace (new: ?STRING; key: ?STRING) is
			-- Replace item at `key', if present,
			-- with `new'; do not change associated key.
			-- Set `replaced' if and only if a replacement has been made
			-- (i.e. `key' was present); otherwise set `not_found'.
			-- Set `found_item' to the item previously associated
			-- with `key' (default value if there was none).
		do
			if has (key) then
				Precursor (new, key)
				add_translation (new, key)
			end
		end

feature -- Removal

	clear_all is
			-- Reset all items to default values; reset status.
		do
			Precursor
		end

feature {NONE} -- Implementation

	add_translation (new_name, old_name: ?STRING) is
			-- Add a translation entry mapping class `old_name' in the
			-- storing system to class `new_name' in the retrieving system.
		local
			n, o: ANY
		do
			n := new_name.to_c
			o := old_name.to_c
		end

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
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
