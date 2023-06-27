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

	make (mp: MANAGED_POINTER; pe: like associated_pe_file; e: like associated_table_entry)
		do
			pointer := mp
			associated_pe_file := pe
			associated_table_entry := e
		end

feature -- Access

	pointer: MANAGED_POINTER

	associated_pe_file: detachable PE_FILE

	associated_table_entry: detachable PE_MD_TABLE_ENTRY

feature -- Optional access

	last_methoddefsig_params: detachable ARRAYED_LIST [attached like last_param]

	last_param: detachable TUPLE [is_szarray: BOOLEAN]

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

	read_integer_16_le: INTEGER_16
		require
			not exhausted
		do
			Result := pointer.read_integer_16_le (current_position)
			forward_position ({PLATFORM}.integer_16_bytes)
		end

	read_integer_32_le: INTEGER_32
		require
			not exhausted
		do
			Result := pointer.read_integer_32_le (current_position)
			forward_position ({PLATFORM}.integer_32_bytes)
		end

	read_natural_8_le: NATURAL_8
		require
			not exhausted
		do
			Result := pointer.read_natural_8_le (current_position)
			forward_position ({PLATFORM}.natural_8_bytes)
		end

	read_natural_16_le: NATURAL_16
		require
			not exhausted
		do
			Result := pointer.read_natural_16_le (current_position)
			forward_position ({PLATFORM}.natural_16_bytes)
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
				if k & {MD_SIGNATURE_CONSTANTS}.property_sig = {MD_SIGNATURE_CONSTANTS}.property_sig then
					Result := propertysig
					if k & {MD_SIGNATURE_CONSTANTS}.has_current = {MD_SIGNATURE_CONSTANTS}.has_current then
						Result.prepend (" hasthis")
					end
				else
					rewind_position (1)
						-- CA prolog
					if read_integer_16_le = {MD_SIGNATURE_CONSTANTS}.ca_prolog then
						Result := custom_attribute
					else
						rewind_position ({PLATFORM}.integer_16_bytes)
						Result := Void
					end
				end
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
			l_retype: like retype
			s: STRING_32
			lst: like last_methoddefsig_params
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
				check False end
				Result.append (" (!ERROR!)")
			else
					-- return type
				l_retype := retype
				if n > 0 then
						-- Params...
--					Result.append (" param.count="+ n.out)
					if exhausted then
						check False end
						Result.append ("(/!ERROR!/)")
					else
						create lst.make (n.to_integer_32)
						last_methoddefsig_params := lst

						Result.append ("(")
						from
						until
							n = 0 --or exhausted
						loop
							s := param
							if attached last_param as lp then
								lst.force (lp)
							else
								check has_last_param: False end
							end
							s.left_adjust
							Result.append (s)
							if n > 1 then
								Result.append (", ")
							end
							n := n - 1
						end
						Result.append (")")
					end
				end
				Result.append (":")
				Result.append (l_retype)
			end
		end

	param: STRING_32
		local
			i: INTEGER_8
			l_last_param: like last_param
		do
			l_last_param := [False]
			last_param := l_last_param
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
				Result.append (" System.TypedReference")
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
				Result.append (" VAR<T")
				tok := uncompressed_value.to_natural_32
				Result.append (tok.out)
				Result.append (">")
			when {MD_SIGNATURE_CONSTANTS}.element_type_mvar then
				Result.append (" MVAR<T")
				tok := uncompressed_value.to_natural_32
				Result.append (tok.out)
				Result.append (">")
			when {MD_SIGNATURE_CONSTANTS}.element_type_class then
				tok := token
				Result.append_character (' ')
				Result.append (token_to_string (tok))
			when {MD_SIGNATURE_CONSTANTS}.element_type_boolean then
				Result.append (" System.Boolean")
			when {MD_SIGNATURE_CONSTANTS}.element_type_char then
				Result.append (" System.Char")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i then
				Result.append (" System.IntPtr")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u then
				Result.append (" System.UIntPtr")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i1 then
				Result.append (" System.Sbyte")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u1 then
				Result.append (" System.Byte")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i2 then
				Result.append (" System.Int16")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u2 then
				Result.append (" System.UInt16")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i4 then
				Result.append (" System.Int32")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u4 then
				Result.append (" System.UInt32")
			when {MD_SIGNATURE_CONSTANTS}.element_type_i8 then
				Result.append (" System.Int64")
			when {MD_SIGNATURE_CONSTANTS}.element_type_u8 then
				Result.append (" System.UInt64")
			when {MD_SIGNATURE_CONSTANTS}.element_type_r4 then
				Result.append (" System.Float")
			when {MD_SIGNATURE_CONSTANTS}.element_type_r8 then
				Result.append (" System.Double")
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
				if attached last_param as lp then
					lp.is_szarray := True
				end
				Result.append (" System.Bytes[")
				Result.append (type)
				Result.append ("]")
			when {MD_SIGNATURE_CONSTANTS}.element_type_valuetype then
				tok := token
				Result.append_character (' ')
				Result.append (token_to_string (tok))
			when {MD_SIGNATURE_CONSTANTS}.element_type_genericinst then
				Result.append (" GENERICINST[")
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
				n = 0 --or exhausted -- TODO: report error is exhausted
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
							s.is_whitespace --or exhausted -- TODO: report error is exhausted
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
			-- See II.23.2.5 PropertySig
		local
			i: like read_integer_8_le
			n: NATURAL_32
			s: like custommod
		do
			create Result.make_empty
				-- param count
			n := uncompressed_value.to_natural_32

			from
				s := custommod
			until
				s.is_whitespace
			loop
				Result.append (s)
				s := custommod
			end

			Result.append (type)

			if n > 0 then
				Result.append ("(")
				from
				until
					n = 0
				loop
					s := param
					s.left_adjust
					Result.append (s)
					if n > 1 then
						Result.append (", ")
					end
					n := n - 1
				end
				Result.append (")")
			end

--			Result := {STRING_32} " ERROR:PropertySig-NotFullyImplemented"
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

	custom_attribute: detachable STRING_32
			-- See II.23.3 Custom attributes
		local
			i: INTEGER
			s: STRING
			l_num_named: NATURAL_16
			is_szarray: BOOLEAN
			l_args_count: INTEGER
			l_inner_reader: PE_MD_SIGNATURE_READER
			l_args_info: detachable LIST [TUPLE [is_szarray: BOOLEAN]]
		do
			Result := "CASig" -- Void

	-- FIXME: not implemented, it relies on associated constructor method information
	--		  find a way to access those data from here...
			if
				attached associated_pe_file as pe and then
				attached {PE_MD_TABLE_CUSTOMATTRIBUTE_ENTRY} associated_table_entry as ca and then
				attached ca.type_index as l_type_index
			then
				if
					attached {PE_MD_TABLE_MEMBERREF_ENTRY} pe.entry_from_index (l_type_index) as e and then
					attached e.signature_index as sig_idx and then
					attached pe.signature_blob_heap_item (sig_idx) as sign and then
					attached sign.methoddefsig_params as l_params
				then
					l_args_info := sign.methoddefsig_params
--					create l_inner_reader.make (sign.pointer , pe: [like associated_pe_file] detachable PE_FILE, e: [like associated_table_entry] detachable PE_MD_TABLE_ENTRY)
					do_nothing
				end
			end
if False then
			create Result.make_empty
			if l_args_info /= Void then
				l_args_count := l_args_info.count
				from
					i := 0
				until
					l_args_count = 0
				loop
					i := i + 1
					-- for each arg, get the value ...
					is_szarray := False -- FIXME
					Result.append (fixed_arg (l_args_info.i_th (i).is_szarray))
					l_args_count := l_args_count - 1
				end
				l_num_named := read_natural_16_le

			else
				l_args_count := 0
			end

			from
			until
				l_num_named = 0
			loop
				is_szarray := False -- TODO
				Result.append (named_arg (is_szarray))
				l_num_named := l_num_named - 1
			end
end
		end

	named_arg (is_szarray: BOOLEAN): STRING_32
		local
			i: like read_integer_8_le
		do
			create Result.make_empty
			i := read_integer_8_le
			if i = {MD_SIGNATURE_CONSTANTS}.element_type_field then
				Result.append (" FIELD")
			elseif i = {MD_SIGNATURE_CONSTANTS}.element_type_property then
				Result.append (" PROPERTY")
			else
				check False end
				Result.append (" ?ERROR?")
			end
			Result.append (type)
			if attached ser_string as str then
				Result.append_character ('%"')
				Result.append (str)
				Result.append_character ('%"')
			else
				Result.append ("null")
			end
			Result.append (fixed_arg (is_szarray))
		end

	ser_string: detachable STRING_32
		local
			l_packlen: INTEGER_32
			s: STRING_8
			n: NATURAL_8
		do
			n := read_natural_8_le
			if n = 0xFF then
				Result := Void
			elseif n= 0x0 then
				create Result.make_empty
			else
				rewind_position (1)
				l_packlen := uncompressed_value
				create s.make (l_packlen)
				from
				until
					l_packlen = 0
				loop
					s.append_code (read_natural_8_le)
					l_packlen := l_packlen - 1
				end
				Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (s)
			end
		end

	fixed_arg (is_szarray: BOOLEAN): STRING_32
		local
			i: like read_integer_8_le
			l_num_elem: INTEGER_32
		do
			create Result.make_empty
			if is_szarray then
				l_num_elem := read_integer_32_le
				from
				until
					l_num_elem = 0
				loop
					Result.append (elem)
					l_num_elem := l_num_elem - 1
				end
			else
				Result.append (elem)
			end
		end

	elem: STRING_32
		local
			i: like read_integer_8_le
		do
			create Result.make_empty
			check implemented: False end
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
