indexing
	description:"Database wrapper, allows storage and retrievals from a database%
				%G: Type of elements in the database%
				%H: Type of associated keys"

class
	DATABASE [G -> DATABASE_ITEM, H]
alias
	"RegistrationService.DataBase"

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Database access.
		do
			max_items := Default_max_items
			create table.make (max_items)
		end

feature -- Access

	item: G
			-- Last item retrieved with `retrieve'

	stored (key: H): BOOLEAN is
			-- Does database include an element at key `key'?
		do
			Result := table.has (key)
		end

feature -- Duplication

	items: ARRAY [G] is
			-- Array of items in database
		do
			Result := table.linear_representation
		end

feature -- Measurement

	max_items: INTEGER
			-- Maximum number of elements in database

feature -- Status setting

	set_max_items (max: INTEGER) is
			-- Set `max_items' with `max'.
		require
			valid_maximum: max > 0
		do
			max_items := max
		ensure
			max_items_set: max_items = max
		end

feature -- Basic Operations

	store (v: G; key: H) is
			-- Store `item' with key `key'.
		require
			non_void_item: v /= Void
			non_void_key: key /= Void
			valid_item: v.initialized
			not_stored: not stored (key)
		do
			if table.count >= max_items then
				create table.make (max_items)
			end
			table.put (v, key)
		ensure
			stored: stored (key)
		end
	
	retrieve (key: H) is
			-- Retrieve item with key `key'.
		require
			non_void_key: key /= Void
			has_item: stored (key)
		do
			item := table.item (key)
		ensure
			retrieved: item /= Void
		end
	
feature {NONE} -- Implementation

	table: HASH_TABLE [G, H]
			-- Database emulation

	Default_max_items: INTEGER is 50
			-- Default maximum number of items

end -- class REGISTRANTS_DATABASE
			
