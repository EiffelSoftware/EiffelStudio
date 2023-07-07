note
	description: "Summary description for {MD_REMAP_TOKEN_MANAGER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_REMAP_TOKEN_MANAGER

create
	make

feature {NONE} -- Initialization

	make
		do
			create table.make (4)
			table.compare_objects
		end

feature -- Status

	record (a_src, a_target: NATURAL_32)
		local
			l_src: NATURAL_32
		do
--			across
--				table as i
--			until
--				l_src > 0
--			loop
--				if i = a_src then
--					l_src := @ i.key
--				end
--			end
--			if l_src = 0 then
				l_src := a_src
--			end
			table [l_src] := a_target
			debug ("il_emitter_table")
				print ("> Remap token: " + l_src.to_hex_string)
--				if l_src /= a_src then
--					print (" (" + a_src.to_hex_string + ")")
--				end
				print (" -> " + a_target.to_hex_string + "%N")
			end
		end

	token (a_src: NATURAL_32): NATURAL_32
		do
			if table.has (a_src) then
				Result := table [a_src]
			else
				Result := a_src
			end
		end

	is_empty: BOOLEAN
		do
			Result := table.is_empty
		end

	has (a_key: NATURAL): BOOLEAN
			-- Is there an item in the hashtable with key `a_key'?
		do
			Result := table.has (a_key)
		end

	force (a_item: NATURAL; a_key: NATURAL)
			-- Update hashtable so that `a_item' will be the item associated
			-- with `a_key'.
		do
			table.force (a_item, a_key)
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

end
