indexing
	description: "Body server indexed by body_index.%
				%Remember also the body indexes to erase from the table (body indexes%
				%from changed features)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class TMP_BODY_SERVER 

inherit
	READ_SERVER [FEATURE_AS]
		export
			{BODY_SERVER} tbl_item
		redefine
			clear, make, has, trace
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialization
		do
			Precursor {READ_SERVER}
			create useless_body_indexes.make (Array_chunk)
		end

feature -- Status report

	has (a_body_index: INTEGER): BOOLEAN is
			-- Does current contain `a_body_index'.
		do
			Result := server_has (a_body_index) and then not useless_body_indexes.has (a_body_index)
		end

feature -- Access

	cache: BODY_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end

feature -- Update

	desactive (a_body_index: INTEGER) is
			-- Put `a_body_index' in `useless_body_indexes'.
		require
			body_index_positive: a_body_index >= 0
		do
			if a_body_index > 0 then
				debug
					io.error.put_string ("TMP_BODY_SERVER.desactivate ")
					io.error.put_integer (a_body_index)
					io.error.put_new_line
				end
				useless_body_indexes.force (a_body_index)
			end
		end

	reactivate (a_body_index: INTEGER) is
			-- Remove `a_body_index' from `useless_body_indexes' if
			-- present, otherwise nothing.
		require
			body_index_positive: a_body_index >= 0
		local
			l_useless: like useless_body_indexes
		do
			if a_body_index > 0 then
				debug
					io.error.put_string ("TMP_BODY_SERVER.reactivate ")
					io.error.put_integer (a_body_index)
					io.error.put_new_line
				end
				l_useless := useless_body_indexes
				if l_useless.count > 0 then
					useless_body_indexes.remove (a_body_index)
				end
			end
		end

	finalize is
			-- Finalization after a successful recompilation.
		local
			useless_body_index: INTEGER
			l_useless: like useless_body_indexes
		do
			debug
				io.error.put_string ("TMP_BODY_SERVER.finalize%N")
			end
				-- Desactive useless ids
			from
				l_useless := useless_body_indexes
				l_useless.start
			until
				l_useless.after
			loop
				useless_body_index := l_useless.item_for_iteration
					-- Note: `remove' will get the updated id
					-- before performing the removal.
				debug
					io.error.put_string ("Useless body_index: ")
					io.error.put_integer (useless_body_index)
					io.error.put_new_line
				end
					-- Remove non-used `body_index' from both
					-- Current and BODY_SERVER, otherwise during
					-- `merge' we will add them back to BODY_SERVER
					-- making this step useless.
				remove (useless_body_index)
				Body_server.remove (useless_body_index)
				l_useless.forth
			end

				-- Update indexes
			Body_server.merge (Current)
				-- Update cache
			Body_server.cache.copy (cache)
			cache.make

			clear
		end

	clear is
			-- Clear the structure
		do
			Precursor {READ_SERVER}
			create useless_body_indexes.make (Array_chunk)
		end

feature -- Debugging

	trace is
		do
			from
				start
				io.error.put_string ("Keys:%N")
			until
				after
			loop
				io.error.put_string ("%T")
				io.error.put_integer (key_for_iteration)
				io.error.put_new_line
				forth
			end
			from
				useless_body_indexes.start
				io.error.put_string ("Useless:%N")
			until
				useless_body_indexes.after
			loop
				io.error.put_string ("%T")
				io.error.put_integer (useless_body_indexes.item_for_iteration)
				io.error.put_new_line
				useless_body_indexes.forth
			end
			io.error.put_string ("O_N_TABLE:%N")
		end

feature {NONE} -- Implementation

	useless_body_indexes: SEARCH_TABLE [INTEGER]
			-- Set of body_indexes ids which have to desappear after a successful
			-- recompilation
	
	offsets: HASH_TABLE [SERVER_INFO, INTEGER] is
		do
			Result := Tmp_ast_server
		end

	Array_chunk: INTEGER is 100;
			-- Array chunk

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
