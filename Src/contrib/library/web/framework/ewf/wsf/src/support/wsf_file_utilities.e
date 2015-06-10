note
	description: "[
				Collection of file system utilities.

				Such as getting safe temporary file	in a specific directory, 
					for an optional prefix, and an optional expected filename.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FILE_UTILITIES [G -> FILE create make_with_path end]

feature -- Factory

	new_file (p: PATH): detachable G
			-- New temporary file open for writing at location `p' or appended with integer suffix if already exists.
		local
			f: G
			bn: STRING_32
			n: INTEGER
		do
			from
				create f.make_with_path (p)
				Result := new_file_opened_for_writing (f)
				n := 0
			until
				Result /= Void
				or else n > 1_000
			loop
				n := n + 1
				create bn.make (2 + n // 10)
				bn.append_character ('-')
				bn.append_integer (n)
				f.make_with_path (p.appended (bn))
				Result := new_file_opened_for_writing (f)
			end
		ensure
			result_opened_for_writing_if_set: Result /= Void implies Result.is_open_write
		end

	new_temporary_file (d: DIRECTORY; a_prefix: detachable READABLE_STRING_GENERAL; a_name: detachable READABLE_STRING_GENERAL): detachable G
			-- New temporary file open for writing inside directory `d', with prefix `a_prefix' is set, and based on name `a_name' is set.
			-- If it is unable to create such file opened for writing, then return Void.
		require
			d_valid: d.exists and then d.is_writable
		local
			fn: PATH
			tmp: STRING_32
			dn: PATH
		do
			if a_prefix /= Void then
				create tmp.make_from_string_general (a_prefix)
			else
				create tmp.make_from_string_general ("tmp")
			end
			dn := d.path
			if a_name /= Void then
				tmp.append_character ('-')
				tmp.append_string_general (safe_filename (a_name))
			end

			fn := dn.extended (tmp)
			Result := new_file (fn)
		ensure
			result_opened_for_writing_if_set: Result /= Void implies Result.is_open_write
		end

	safe_filename (fn: READABLE_STRING_GENERAL): STRING
			-- Safe filename that avoid impossible filename, or dangerous one.
		local
			c: CHARACTER_32
			i, n: INTEGER
		do
			from
				i := 1
				n := fn.count
				create Result.make (n)
			until
				i > n
			loop
				c := fn[i]
				inspect c
				when '.', '-', '_' then
					Result.append_code (c.natural_32_code)
				when 'A' .. 'Z', 'a' .. 'z', '0' .. '9' then
					Result.append_code (c.natural_32_code)
				else
					inspect c
					when '%/192/' then Result.extend ('A') -- À
					when '%/193/' then Result.extend ('A') -- Á
					when '%/194/' then Result.extend ('A') -- Â
					when '%/195/' then Result.extend ('A') -- Ã
					when '%/196/' then Result.extend ('A') -- Ä
					when '%/197/' then Result.extend ('A') -- Å
					when '%/199/' then Result.extend ('C') -- Ç
					when '%/200/' then Result.extend ('E') -- È
					when '%/201/' then Result.extend ('E') -- É
					when '%/202/' then Result.extend ('E') -- Ê
					when '%/203/' then Result.extend ('E') -- Ë
					when '%/204/' then Result.extend ('I') -- Ì
					when '%/205/' then Result.extend ('I') -- Í
					when '%/206/' then Result.extend ('I') -- Î
					when '%/207/' then Result.extend ('I') -- Ï
					when '%/210/' then Result.extend ('O') -- Ò
					when '%/211/' then Result.extend ('O') -- Ó
					when '%/212/' then Result.extend ('O') -- Ô
					when '%/213/' then Result.extend ('O') -- Õ
					when '%/214/' then Result.extend ('O') -- Ö
					when '%/217/' then Result.extend ('U') -- Ù
					when '%/218/' then Result.extend ('U') -- Ú
					when '%/219/' then Result.extend ('U') -- Û
					when '%/220/' then Result.extend ('U') -- Ü
					when '%/221/' then Result.extend ('Y') -- Ý
					when '%/224/' then Result.extend ('a') -- à
					when '%/225/' then Result.extend ('a') -- á
					when '%/226/' then Result.extend ('a') -- â
					when '%/227/' then Result.extend ('a') -- ã
					when '%/228/' then Result.extend ('a') -- ä
					when '%/229/' then Result.extend ('a') -- å
					when '%/231/' then Result.extend ('c') -- ç
					when '%/232/' then Result.extend ('e') -- è
					when '%/233/' then Result.extend ('e') -- é
					when '%/234/' then Result.extend ('e') -- ê
					when '%/235/' then Result.extend ('e') -- ë
					when '%/236/' then Result.extend ('i') -- ì
					when '%/237/' then Result.extend ('i') -- í
					when '%/238/' then Result.extend ('i') -- î
					when '%/239/' then Result.extend ('i') -- ï
					when '%/240/' then Result.extend ('o') -- ð
					when '%/242/' then Result.extend ('o') -- ò
					when '%/243/' then Result.extend ('o') -- ó
					when '%/244/' then Result.extend ('o') -- ô
					when '%/245/' then Result.extend ('o') -- õ
					when '%/246/' then Result.extend ('o') -- ö
					when '%/249/' then Result.extend ('u') -- ù
					when '%/250/' then Result.extend ('u') -- ú
					when '%/251/' then Result.extend ('u') -- û
					when '%/252/' then Result.extend ('u') -- ü
					when '%/253/' then Result.extend ('y') -- ý
					when '%/255/' then Result.extend ('y') -- ÿ
					else
						Result.extend ('-')
					end
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	new_file_opened_for_writing (f: G): detachable G
			-- Returns a new file object opened for writing if possible
			-- otherwise returns Void.
		local
			retried: BOOLEAN
		do
			if not retried then
				if not f.exists then
					f.open_write
					if f.is_open_write then
						Result := f
					elseif not f.is_closed then
						f.close
					end
				end
			end
		ensure
			Result /= Void implies Result.is_open_write
		rescue
			retried := True
			retry
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
