indexing
	description: "Representation of a SERVER"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ISE_SERVER [G -> SERVER_INFO, T -> IDABLE, H -> COMPILER_ID]

inherit
	EXTEND_TABLE [G, H]
		rename
			make as tbl_make,
			item as tbl_item,
			has as tbl_has,
			remove as tbl_remove,
			put as tbl_put
		end

	COMPILER_EXPORTER
		undefine
			copy, is_equal
		end

	SHARED_SERVER
		undefine
			copy, is_equal
		end

	SHARED_SCONTROL
		undefine
			copy, is_equal
		end

feature -- Initialization

	make is
		do
			tbl_make (Chunk)		
		end

feature -- Access

	has, frozen server_has (i: H): BOOLEAN is
			-- Does the server contain an element of id `i'?
		do
			Result := tbl_has (updated_id(i))
		end

	server_item, item (an_id: H): T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id)
		deferred
		end
		
	disk_item (an_id: H):T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id)
		deferred
		end

feature -- Removal
	
	remove (an_id: H) is
			-- Remove an element from the Server
		deferred
		end

feature -- Update

	updated_id (i: H): H is
		do
			Result := i	
		end

	ontable: O_N_TABLE [H] is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
			-- By default, this mechanism is disabled, hence the
			-- `False' precondition
		require
			False
		do
		end

	change_id (new_value, old_value: H) is
		require
			Has_old: has (old_value)
		local
			info: G
			temp: T
			real_id: H
		do
			real_id := updated_id (old_value)

			temp := cache.item_id (real_id)
			if temp /= Void then
				temp.set_id (new_value)
			end

			info := tbl_item (real_id)
			tbl_remove (real_id)
			tbl_put (info, new_value)
		end

	clear is
			-- Clear the server.
		do
			cache.wipe_out
			clear_all
		end

feature -- Server size configuration

	Chunk: INTEGER is
			-- Hash table chunk
			-- We will add `Chunk' element during resizing.
		deferred
		end

feature -- Implementation

	cache: CACHE [T, H] is
			-- Server cache, to make things faster
		deferred
		end

feature {NONE} -- External features

	store_append (f_desc: INTEGER; object, make_index_proc, need_index_proc, s: POINTER): INTEGER is
		external
			"C | %"pstore.h%""
		end

	retrieve_all (f_desc: INTEGER; pos: INTEGER): T is
		external
			"C | %"pretrieve.h%""
		end

	partial_retrieve (file_desc: INTEGER; pos, nb_obj: INTEGER): T is
		external
			"C | %"pretrieve.h%""
		end

end -- class SERVER
