indexing
	description: "Representation of a SERVER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		require
			an_id_positive: i > 0
		do
			Result := tbl_has (i)
		end

	server_item, item (an_id: INTEGER): T is
			-- Object of id `an_id'
		require
			an_id_positive: an_id > 0
		deferred
		end

	disk_item (an_id: INTEGER):T is
			-- Object of id `an_id'
		require
			an_id_positive: an_id > 0
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
		ensure
			cache_not_void: Result /= Void
		end

feature {NONE} -- External features

	store_append (f_desc: INTEGER; object, make_index_proc, need_index_proc, s: POINTER): INTEGER is
		external
			"C inline use %"pstore.h%""
		alias
			"[
				return (EIF_INTEGER) store_append ((EIF_INTEGER) $f_desc, (EIF_REFERENCE) $object,
					(fnptr) $make_index_proc, (fnptr) $need_index_proc, (EIF_REFERENCE) $s);
			]"
		end

	retrieve_all (f_desc: INTEGER; pos: INTEGER): T is
		external
			"C | %"pretrieve.h%""
		end

	partial_retrieve (file_desc: INTEGER; pos, nb_obj: INTEGER): T is
		external
			"C | %"pretrieve.h%""
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class SERVER
