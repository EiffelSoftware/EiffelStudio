indexing
	description: "Representation of a SERVER"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ISE_SERVER [G -> SERVER_INFO, T -> IDABLE]

inherit
	HASH_TABLE [G, INTEGER]
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

	has, frozen server_has (i: INTEGER): BOOLEAN is
			-- Does the server contain an element of id `i'?
		do
			Result := tbl_has (i)
		end

	server_item, item (an_id: INTEGER): T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id)
		deferred
		end
		
	disk_item (an_id: INTEGER):T is
			-- Object of id `an_id'
		require
			an_id_in_table: has (an_id)
		deferred
		end

feature -- Removal
	
	remove (an_id: INTEGER) is
			-- Remove an element from the Server
		deferred
		end

feature -- Update

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

	cache: CACHE [T] is
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
