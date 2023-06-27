note
	description: "Summary description for {PE_MD_SIGNATURE_READER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PE_MD_SIGNATURE_READER

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (mp: MANAGED_POINTER; pe: like associated_pe_file)
		do
			pointer := mp
			associated_pe_file := pe
		end

feature -- Access

	pointer: MANAGED_POINTER

	associated_pe_file: detachable PE_FILE

feature -- Status report

	debug_output: STRING_8
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "[" + (current_position + 1 - 1).out + "/" + pointer.count.out + "] "
			if not exhausted then
				Result.append ("0x" + pointer.read_natural_8_le (current_position - 1).to_hex_string)
			end
			Result.append (": " + dump)
		end

	dump: STRING_8
		local
			i,n: INTEGER
			mp: MANAGED_POINTER
		do
			mp := pointer
			from
				i := 0
				n := pointer.count
				create Result.make (n * 3)
			until
				i >= n
			loop
				if not Result.is_empty then
					Result.append_character ('-')
				end
				Result.append (mp.read_natural_8 (i).to_hex_string)
				i := i + 1
			end
		end

feature -- Traversal

	current_position: INTEGER

	current_byte: NATURAL_8
		do
			if not exhausted then
				Result := pointer.read_natural_8_le (current_position)
			end
		end

	exhausted: BOOLEAN
		do
			Result := current_position >= pointer.count
		end

	reset_position
		do
			current_position := 0
		end

	forward_position (nb: INTEGER)
		require
			nb >= 0
		do
			current_position := current_position + nb
		end

	rewind_position (nb: INTEGER)
		require
			nb > 0
		do
			current_position := current_position - nb
		end

	read_integer_8_le: INTEGER_8
		require
			not exhausted
		do
			Result := pointer.read_integer_8_le (current_position)
			forward_position (1)
		end

	read_natural_32_le: NATURAL_32
		require
			not exhausted
		do
			Result := pointer.read_natural_32_le (current_position)
			forward_position ({PLATFORM}.natural_32_bytes)
		end

feature -- Access

	decoded_value: detachable STRING_32
		local
			k: INTEGER_8
		do
			k := read_integer_8_le
			inspect
				k
			when {MD_SIGNATURE_CONSTANTS}.field_sig then
				Result := fieldsig
			when {MD_SIGNATURE_CONSTANTS}.local_sig then
				Result := localvarsig
			when {MD_SIGNATURE_CONSTANTS}.property_sig then
				Result := propertysig
			else
				Result := Void
			end
		end

feature -- Method signature

	token_to_string (tok: NATURAL_32): STRING_32
		do
			if
				attached associated_pe_file as pe_file and then
				attached pe_file.table_entry (tok) as e and then
				attached {PE_MD_TABLE_ENTRY_WITH_IDENTIFIER} e as e_with_id and then
				attached e_with_id.resolved_identifier (pe_file) as s
			then
				Result := s
			else
				Result := "0x" + tok.to_hex_string
			end
		end

	token: NATURAL_32
		do
			Result := uncompressed_type_token (uncompressed_value)
		end

	methoddefsig: STRING_32
		local
			pos: INTEGER
			k: INTEGER_8
			i, j: INTEGER_8
			tok, n: NATURAL_32
		do
			create Result.make_empty
			i := read_integer_8_le
			if i & {MD_SIGNATURE_CONSTANTS}.has_current = {MD_SIGNATURE_CONSTANTS}.has_current then
				Result.append (" hasthis")
			end
			if i & {MD_SIGNATURE_CONSTANTS}.explicit_current = {MD_SIGNATURE_CONSTANTS}.explicit_current then
				Result.append (" explicit")
			end
			if i & {MD_SIGNATURE_CONSTANTS}.default_sig = {MD_SIGNATURE_CONSTANTS}.default_sig then
--				Result.append (" DEFAULT")
			end
			if i & {MD_SIGNATURE_CONSTANTS}.vararg_sig = {MD_SIGNATURE_CONSTANTS}.vararg_sig then
				Result.append (" VARARGS")
			end
			if i & {MD_SIGNATURE_CONSTANTS}.generic = {MD_SIGNATURE_CONSTANTS}.generic then
				Result.append (" GENERIC")
				n := uncompressed_value.to_natural_32
				Result.append ("("+ n.out +")")
			end

--			when {MD_SIGNATURE_CONSTANTS}.c then
--				Result.append (" C")
--			when {MD_SIGNATURE_CONSTANTS}.stdcall then
--				Result.append (" STDCALL")
--			when {MD_SIGNATURE_CONSTANTS}.thiscall then
--				Result.append (" THISCALL")
--			when {MD_SIGNATURE_CONSTANTS}.fastcall then
--				Result.append (" FASTCALL")

				-- Param count
			n := uncompressed_value.to_natural_32
			if exhausted then
				-- FIXME: is that expected?
				do_nothing
			else
					-- return type
				Result.append (retype)

				if n > 0 then
						-- Params...
					Result.append (" param("+ n.out +") ")
					if exhausted then
--						check False end
						Result.append (" (!ERROR!)")
					else
						Result.append (" (")
						from
						until
							n = 0 or exhausted
						loop
							Result.append (param)
							n := n - 1
						end
						Result.append (")")
					end
				end
			end
		end

	param: STRING_32
		local
			i: INTEGER_8
		do
			create Result.make_empty
			Result.append (custommod)
			i := read_integer_8_le
			inspect i
			when {MD_SIGNATURE_CONSTANTS}.element_type_byref then
				Result.append (type)
			when {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
				Result.append (" typedbyref")
			else
				rewind_position (1)
				Result.append (type)
			end
		end

	retype: STRING_32
		local
			i: INTEGER_8
		do
			create Result.make_empty
			Result.append (custommod)
			inspect read_integer_8_le
			when {MD_SIGNATURE_CONSTANTS}.element_type_byref then
				Result.append (type)
			when {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
				Result.append (" typedbyref")
			when {MD_SIGNATURE_CONSTANTS}.element_type_pinned then
				Result.append (" pinned") -- TODO: Good location?				
			else
				rewind_position (1)
				Result.append (type)
			end
		end

	type: STRING_32
		local
			tok: NATURAL_32
			i: like read_integer_8_le
			n: NATURAL_32
		do
			create Result.make_empty
			i := read_integer_8_le
			inspect i
			when {MD_SIGNATURE_CONSTANTS}.element_type_void then
				Result.append (" void")
			when {MD_SIGNATURE_CONSTANTS}.element_type_var then
				Result.append (" VAR<")
				tok := token
				Result.append (token_to_string (tok))
				Result.append (">")
			when {MD_SIGNATURE_CONSTANTS}.element_type_mvar then
				Result.append (" MVAR<")
				tok := token
				Result.append (token_to_string (tok))
				Result.append (">")
			when {MD_SIGNATURE_CONSTANTS}.element_type_class then
				tok := token
				Result.append_character (' ')
				Result.append (token_to_string (tok))
			when {MD_SIGNATURE_CONSTANTS}.element_type_boolean then
				Result.append (" boolean")
			when {MD_SIGNATURE_CONSTANTS}.element_type_char then
				Result.append (" char")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i then
				Result.append (" i")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u then
				Result.append (" u")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
				Result.append (" i1")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
				Result.append (" u1")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
				Result.append (" i2")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
				Result.append (" u2")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then
				Result.append (" i4")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then
				Result.append (" u4")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
				Result.append (" i8")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
				Result.append (" u8")
			when {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
				Result.append (" r4")
			when {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
				Result.append (" r8")
			when {MD_SIGNATURE_CONSTANTS}.element_type_string then
				Result.append (" System.String")
			when {MD_SIGNATURE_CONSTANTS}.element_type_object then
				Result.append (" System.Object")
			when {MD_SIGNATURE_CONSTANTS}.element_type_array then
				Result.append (" System.Array[")
				Result.append (type)
				-- TODO
				check implemented: False end
				Result.append ("]")
			when {MD_SIGNATURE_CONSTANTS}.element_type_szarray then
				Result.append (" System.Bytes[")
				Result.append (type)
				Result.append ("]")
			when {MD_SIGNATURE_CONSTANTS}.element_type_valuetype then
				tok := token
				Result.append_character (' ')
				Result.append (token_to_string (tok))
			when {MD_SIGNATURE_CONSTANTS}.element_type_genericinst then
				Result.append (" GENERICINST [")
				Result.append (type)
				n := uncompressed_value.to_natural_32
				Result.append ("<")
				from
				until
					n = 0
				loop
					Result.append (type)
					n := n - 1
				end
				Result.append (">]")
			when {MD_SIGNATURE_CONSTANTS}.element_type_fnptr then
				do_nothing
			else
				Result.append (" ERROR:Type-NotFullyImplemented")
			end
		end

feature -- FieldSig	, LocalSig, PropertySig ...

	custommod: STRING_32
		local
			tok: NATURAL_32
		do
			create Result.make (0)
			inspect read_integer_8_le
			when {MD_SIGNATURE_CONSTANTS}.element_type_cmod_opt then
				Result.append (" opt")
					-- TypeDefOrReforSpecEncoded
				tok := token
				Result.append_character (' ')
				Result.append (token_to_string (tok))
			when {MD_SIGNATURE_CONSTANTS}.element_type_cmod_reqd then
				Result.append (" reqd ")
					-- TypeDefOrReforSpecEncoded
				tok := token
				Result.append_character (' ')
				Result.append (token_to_string (tok))
			else
					-- No CustomMod found, reverse position
				rewind_position (1)
			end
		end

	fieldsig: STRING_32
		local
			k: INTEGER_8
			i, j: INTEGER_8
			tok: NATURAL_32
			s: like custommod
		do
			create Result.make_empty
			from
				s := custommod
			until
				s.is_empty
			loop
				Result.append (s)
				s := custommod
			end

--			i := read_integer_8_le
--			if i = {MD_SIGNATURE_CONSTANTS}.field_sig then
--				Result.append (fieldsig)
--			else
--				rewind_position (1)
--			end

			Result.append (type)
		end

	localvarsig: STRING_32
		local
			n: NATURAL_32
			i: like read_integer_8_le
			s: like custommod
			l_done: BOOLEAN
			old_count: INTEGER
		do
			create Result.make_empty
			n := uncompressed_value.to_natural_32
			Result.append (" count=" + n.out)
			from
			until
				n = 0 or exhausted -- TODO: report error is exhausted
			loop
				i := read_integer_8_le
				if i = {MD_SIGNATURE_CONSTANTS}.element_type_typedbyref then
					Result.append (" typedbyref")
				else
					rewind_position (1)
					from
						old_count := -1
					until
						old_count = Result.count or exhausted -- TODO: report error is exhausted
					loop
						old_count := Result.count
						from
							s := custommod
						until
							s.is_whitespace or exhausted -- TODO: report error is exhausted
						loop
							Result.append (s)
							s := custommod
						end

						i := read_integer_8_le
						if i = {MD_SIGNATURE_CONSTANTS}.element_type_pinned then
							Result.append (" pinned")
							-- TODO: check for custommod ...
						else
							rewind_position (1)
						end
					end

					i := read_integer_8_le
					if i = {MD_SIGNATURE_CONSTANTS}.element_type_byref then
						Result.append (" byref")
					else
						rewind_position (1)
					end
					Result.append (type)
				end
				n := n - 1
			end
--			Result := {STRING_32} " ERROR:LocalVarSig-NotFullyImplemented"
		end

	propertysig: STRING_32
		do
			Result := {STRING_32} " ERROR:PropertySig-NotFullyImplemented"
		end

	typespecsig: STRING_32
			-- See II.23.2.14 TypeSpec
		local
			i: like read_integer_8_le
			n: NATURAL_32
		do
			create Result.make_empty
			i := read_integer_8_le
			inspect i
			when {MD_SIGNATURE_CONSTANTS}.element_type_ptr then
				Result.append (" !ERROR:PTR!")
			when {MD_SIGNATURE_CONSTANTS}.element_type_fnptr then
				Result.append (" !ERROR:FNPTR!")
			when {MD_SIGNATURE_CONSTANTS}.element_type_array then
				Result.append (" !ERROR:ARRAY!")
			when {MD_SIGNATURE_CONSTANTS}.element_type_szarray then
				Result.append (" !ERROR:SZARRAY!")
			when {MD_SIGNATURE_CONSTANTS}.element_type_genericinst then
				Result.append (" GENERICINST")
				i := read_integer_8_le
				if i = {MD_SIGNATURE_CONSTANTS}.element_type_class then
					Result.append (" class")
				elseif i = {MD_SIGNATURE_CONSTANTS}.element_type_valuetype then
					Result.append (" valuetype")
				else
					rewind_position (1)
				end
				Result.append_character (' ')
				Result.append (token_to_string (token))

				n := uncompressed_value.to_natural_32
				from

				until
					n = 0
				loop
					Result.append (type)
					n := n - 1
				end
			else
				Result := {STRING_32} " ERROR:TypeSpecSig-NotFullyImplemented"
			end
		end

feature -- Implementation

	uncompressed_value: INTEGER_32
		local
			cl: CELL [INTEGER_32]
		do
			create cl.put (0)
			Result := uncompressed_data (pointer, current_position, cl)
			forward_position (cl.item)
		end

	uncompressed_data (v: MANAGED_POINTER; pos: INTEGER; nb_bytes: detachable CELL [INTEGER_32]): INTEGER_32
		local
			i1, i2, i3, i4: NATURAL_32
			res: NATURAL_32
			l_bytes_count: INTEGER
		do
			i1 := v.read_natural_8 (pos + 0)
			if i1 <= 0x7F then
				res := i1
				l_bytes_count := 1
			else
				i2 := v.read_natural_8 (pos + 1)
				res := (i1 |<< 8)
						+ i2
						- 0x0000_8000
				if res <= 0x3FFF then
					l_bytes_count := 2
					-- ok
				else
					i3 := v.read_natural_8 (pos + 2)
					i4 := v.read_natural_8 (pos + 3)
					l_bytes_count := 4

					res := (i1 |<< 24).to_natural_32
							+ (i2 |<< 16).to_natural_32
							+ (i3 |<< 8).to_natural_32
							+ (i4).to_natural_32
							- 0xC000_0000
				end
			end
			if nb_bytes /= Void then
				nb_bytes.replace (l_bytes_count)
			end
			Result := res.to_integer_32
		ensure
			class
		end

	uncompressed_type_token (v: INTEGER): NATURAL_32
		local
			enc: INTEGER
			val: NATURAL_32
			tag: NATURAL_32
		do
			enc := (v & 0x0000_0003)
			val := (v |>> 2).to_natural_32
			inspect
				enc
			when 0 then
					-- TypeDef Token
				tag := {PE_TABLES}.ttypedef
			when 1 then
					-- Typeref Token
				tag := {PE_TABLES}.ttyperef
			when 2 then
					-- TypeSpec Token
				tag := {PE_TABLES}.ttypespec
			else
--				check known: False end
				tag := 0xFF -- {PE_TABLES}.ttypedef
			end
			if tag = 0xFF then
				Result := 0xFF00_1111
			else
				Result := ((tag |<< 24) | val)
			end
		ensure
			class
		end


end
