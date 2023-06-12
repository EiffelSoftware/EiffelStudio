note
	description: "Summary description for {MD_DEBUG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MD_DEBUG

feature -- Access	

	dump_pool (pool: PE_POOL): STRING_8
		local
			i: INTEGER
--			s: STRING
			arr: SPECIAL [NATURAL_8]
			n: INTEGER
		do
			arr := pool.base
			n := pool.size.to_integer_32
			from
				i := 0
				create Result.make (n)
--				create s.make_empty
			until
				i >= n
			loop
--				if arr [i] = {NATURAL_8} 0 then
--					s.append (arr [i].out)
--					s.append_character (',')
--				else
--					if not s.is_empty then
--						Result.append (s)
--						s.wipe_out
--					end
					Result.append (arr [i].out)
					Result.append_character (',')
--				end
				i := i + 1
			end
		ensure
			class
		end

	dump_special (sp: SPECIAL [NATURAL_8]; a_start_index, n: INTEGER): STRING_8
		require
			sp.valid_index (a_start_index)
			valid_count: a_start_index + n <= sp.count
		local
			i: INTEGER
		do
			from
				i := 0
				create Result.make (n)
			until
				i >= n
			loop
				Result.append (sp [i].to_hex_string)
				Result.append_character (' ')
				i := i + 1
			end
		ensure
			class
		end

end
