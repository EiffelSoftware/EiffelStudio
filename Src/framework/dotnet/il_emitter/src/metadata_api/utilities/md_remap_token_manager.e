note
	description: "Summary description for {MD_REMAP_TOKEN_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_REMAP_TOKEN_MANAGER

inherit
	TABLE_ITERABLE [NATURAL_32, NATURAL_32]

create
	make

feature {NONE} -- Initialization

	make (a_tb: MD_TABLE)
		do
			associated_table := a_tb
			create table.make (4)
			table.compare_objects
		end

feature -- Access

	associated_table: MD_TABLE

feature -- Access		

	token (a_src: NATURAL_32): NATURAL_32
		do
			if attached committed_table as tb and then tb.has (a_src) then
				Result := tb [a_src]
			else
				Result := a_src
			end
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [NATURAL_32, NATURAL_32]
			-- Fresh cursor associated with current structure
		do
			Result := table.new_cursor
		end

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := table.is_empty
		end

	has (a_key: NATURAL): BOOLEAN
			-- Is there an item in the hashtable with key `a_key'?
		do
			Result := table.has (a_key)
		end

feature -- Element change

	reset
		do
			table.wipe_out
			committed_table := Void
		end

	record (a_src, a_target: NATURAL_32)
		require
			valid_src: associated_table.valid_index (a_src)
			valid_target: associated_table.valid_index (a_target)
		local
			l_src: NATURAL_32
		do
-- FIXME: check for recursive cases.
			if attached reversed_committed_table as rftb then
				l_src := rftb [a_src]
			end
			if l_src = 0 then
				l_src := a_src
			end
			table [l_src] := a_target
			debug ("il_emitter_table")
				print ("> Remap token: " + l_src.to_hex_string)
				if l_src /= a_src then
					print (" (" + a_src.to_hex_string + ")")
				end
				print (" -> " + a_target.to_hex_string + "%N")
			end
		end

	commit
		local
			ftb: like committed_table
			rftb: like reversed_committed_table
		do
			ftb := committed_table
			if ftb = Void then
				create ftb.make (table.count)
				committed_table := ftb
			else
				ftb.wipe_out
			end

			rftb := reversed_committed_table
			if rftb = Void then
				create rftb.make (table.count)
				reversed_committed_table := rftb
			else
				rftb.wipe_out
			end

			across
				table as i
			loop
				ftb[@i.key] := i
				rftb[i] := @i.key
			end
		end

	force (a_item: NATURAL; a_key: NATURAL)
			-- Update hashtable so that `a_item' will be the item associated
			-- with `a_key'.
		do
			table.force (a_item, a_key)
		end

feature -- Operation

	remap_index (idx: PE_INDEX_BASE; a_table_id: NATURAL_32)
		local
			i, t: NATURAL_32
		do
			if
				attached {PE_LIST} idx as p_list and then
				(not p_list.is_list_index_set or p_list.is_null_index)
			then
				-- Ignore
			else
				if attached {PE_CODED_INDEX_BASE} idx as l_coded_idx then
					i := l_coded_idx.index
					t := token (i)
					if i /= t then
						l_coded_idx.update_coded_index (t, a_table_id)
					end
				else
					i := idx.index
					t := token (i)
					if i /= t then
						idx.update_index (t)
					end
				end
			end
		end

feature -- Conversion

	dump: STRING
		do
			create Result.make (10)
			across
				table as i
			loop
				Result.append (" " + @ i.key.to_hex_string + " -> " + i.to_hex_string + "%N")
			end
		end

feature {NONE} -- Implemetation

	table: HASH_TABLE [NATURAL, NATURAL]
			-- New token indexed by old token.

	committed_table,
	reversed_committed_table: detachable HASH_TABLE [NATURAL, NATURAL]
			-- Token remapping used for recursion.

end
