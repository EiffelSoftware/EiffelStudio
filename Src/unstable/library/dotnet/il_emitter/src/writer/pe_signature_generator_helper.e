note
	description: "[
			This class holds functions for generating the various signatures we need
			to put in the blob stream.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_SIGNATURE_GENERATOR_HELPER

inherit

	PE_SHARED_SIGNATURE_GENERATOR

	REFACTORING_HELPER



feature -- Access: Signature Generators

	method_def_sig (a_signature: CIL_METHOD_SIGNATURE; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
		do
			l_size := core_method (a_signature, a_signature.params.count, signature_generator.work_area, 0).to_integer_32
			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	method_ref_sig (a_signature: CIL_METHOD_SIGNATURE; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
		do
			l_size := core_method (a_signature, a_signature.params.count, signature_generator.work_area, 0).to_integer_32
				-- variable length args... this is the difference from the methoddef
			if ((a_signature.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg) /= 0) and then
			   not ((a_signature.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.Managed) /= 0)
			then
				if not a_signature.vararg_params.is_empty then
					signature_generator.work_area [l_size] := {PE_TYPES_ENUM}.ELEMENT_TYPE_SENTINEL
					l_size := l_size + 1
					across a_signature.vararg_params as  param loop
						l_size := l_size + embed_type (signature_generator.work_area, l_size, param.type).to_integer_32
					end
				end
			end
			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	method_spec_sig (a_signature: CIL_METHOD_SIGNATURE; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
		do
			l_size := 0
			signature_generator.work_area [l_size] := 0x0a
				-- generic
			l_size := l_size + 1
			signature_generator.work_area [l_size] := a_signature.generic.count
			l_size := l_size + 1
			across a_signature.generic as g loop
				l_size := l_size + embed_type (signature_generator.work_area, l_size, g).to_integer_32
			end
			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	property_sig (a_property: CIL_PROPERTY; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
			l_getter: CIL_METHOD
			l_val: INTEGER
		do
			l_size := 0
				-- a property sig is a modification of the methoddef of the getter
			signature_generator.work_area [l_size] := 8
			l_size := l_size + 1

			l_getter := a_property.getter


			l_size := core_method (if attached {CIL_METHOD} l_getter as ll_getter then ll_getter.prototype else	Void end,
									if attached {CIL_METHOD} l_getter as ll_getter then ll_getter.prototype.params.count else 0 end,
									signature_generator.work_area, 0).to_integer_32

			l_val := 0x20
			if a_property.instance then
				 signature_generator.work_area[1] := signature_generator.work_area [1] | l_val
			else
				signature_generator.work_area[1] := signature_generator.work_area [1] & l_val.bit_not
			end
			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	field_sig (a_field: CIL_FIELD; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
		do
			l_size := 0
			signature_generator.work_area [l_size] := 6
				-- field sig

			l_size := l_size + 1

			l_size := l_size + embed_type (signature_generator.work_area, l_size, a_field.type).to_integer_32
			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	local_var_sig (a_method: CIL_METHOD; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
		do
			signature_generator.work_area [l_size] := 7
			  -- local sig
			l_size := l_size + 1
			signature_generator.work_area [l_size] := a_method.var_list.count
				-- todo check if we need to create an size or count feature in CIL_METHOD
				-- to avoid call to var_list.count

			across a_method.var_list as  elem loop
				l_size := l_size + embed_type (signature_generator.work_area, l_size, elem.type).to_integer_32
			end

			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	type_sig (a_type: CIL_TYPE; a_size: CELL [NATURAL_64]): ARRAY [NATURAL_8]
		local
			l_size: INTEGER
		do
			l_size := 0
			l_size := l_size + embed_type (signature_generator.work_area, l_size, a_type).to_integer_32
			Result := convert_to_blob (signature_generator.work_area, l_size, a_size)
		ensure
			instance_free: class
		end

	embed_type (a_buf: SPECIAL [INTEGER]; a_offset: INTEGER; a_type: detachable CIL_TYPE): NATURAL
			-- this function is a generic function to embed a type
			-- into a signature
		local
			l_rv: INTEGER
			l_cls1: CIL_CLASS
		do
			if attached a_type as l_tp then
				if attached {CIL_TYPE} l_tp.mod_opt as l_opt and then l_opt.basic_type = {CIL_BASIC_TYPE}.class_ref then
					-- ELEMENT_TYPE_CMOD_OPT (typeRef)
    			    -- to realize modopt([mscorlib]System.Runtime.CompilerServices.CallConvCdecl)
        			-- placed on the return type of the delegates Invoke signature

					a_buf [a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_CMOD_OPT
					l_rv := l_rv + 1
					if attached {CIL_CLASS} l_opt.type_ref as l_cls then
							-- cannot use EmbedType here becode it would add ELEMENT_TYPE_CLASS
						if l_cls.pe_index = 0 then
							io.set_error_default
							io.put_string ("{PE_SIGNATURE_GENERATOR_HELPER}.embed_type classRef with no PEIndex")
							io.put_new_line
							io.set_output_default
						end
						if l_cls.in_assembly_ref then
							a_buf[a_offset + l_rv] := (l_cls.pe_index.to_integer_32 |<< 2) | {PE_TYPEDEF_OR_REF}.typeref
							l_rv := l_rv + 1
				        else
					        a_buf[a_offset + l_rv] := (l_cls.pe_index.to_integer_32 |<< 2) | {PE_TYPEDEF_OR_REF}.typedef
					        l_rv := l_rv + 1
            			end
					end
				end

				if l_tp.pinned then
					a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_PINNED
					l_rv := l_rv + 1
				end
				if l_tp.by_ref then
					a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_BYREF
					l_rv := l_rv + 1
				end

				--#if 0
				--    // when this is here instead of below we get a "type[]*" if tp has both pointer and array level.
				--    for (int i = 0; i < tp->PointerLevel(); i++)
				--        buf[offset + rv++] = ELEMENT_TYPE_PTR;
				--#endif

				if l_tp.array_level /= 0 then
					--#if 0
					--        if (tp->ArrayLevel() == 1)
					--        {
					--            buf[offset + rv++] = ELEMENT_TYPE_SZARRAY;
					--        }
					--        else
					--        {
					--            buf[offset + rv++] = ELEMENT_TYPE_ARRAY;
					--        }
					--#else
					across 0|..| (l_tp.array_level - 1) as i loop
						a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_SZARRAY
						l_rv := l_rv + 1
					end
				end

				--#if 1
				--    // with this order we get a "type*[]" if tp has both pointer and array level.
				--    for (int i = 0; i < tp->PointerLevel(); i++)
				--        buf[offset + rv++] = ELEMENT_TYPE_PTR;
				--#endif
				across 0|..| (l_tp.array_level - 1) as i loop
					a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_PTR
					l_rv := l_rv + 1
				end

				inspect l_tp.basic_type
				when {CIL_BASIC_TYPE}.object then
					a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_OBJECT
					l_rv := l_rv + 1
				when {CIL_BASIC_TYPE}.method_param then
					a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_MVAR
					l_rv := l_rv + 1
            		a_buf[a_offset + l_rv] := l_tp.var_num
            		l_rv := l_rv + 1
				when {CIL_BASIC_TYPE}.type_var then
					a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_VAR
					l_rv := l_rv + 1
            		a_buf[a_offset + l_rv] := l_tp.var_num
            		l_rv := l_rv + 1
				when {CIL_BASIC_TYPE}.class_ref then
					if attached {CIL_CLASS} l_tp.type_ref as l_cls  then
						l_cls1 := l_cls
						if not l_cls.generics.is_empty then
							a_buf [a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_GENERICINST
							l_rv := l_rv + 1
							 -- the parent is expected to be the main class for the generic.
							l_cls1 := l_cls1.generic_parent
						end
						if attached l_cls1 as l_cls2 and then
						   (l_cls2.flags.flags & {CIL_QUALIFIERS_ENUM}.value) /= 0
						then
							a_buf [a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_VALUETYPE
							l_rv := l_rv + 1
						else
							a_buf[a_offset + l_rv] :=  {PE_TYPES_ENUM}.ELEMENT_TYPE_CLASS
							l_rv := l_rv + 1
						end
						if attached l_cls1 as l_cls2 and then
						   l_cls2.pe_index = 0
						then
							io.set_error_default
							print ("PE_SIGNATURE_GENERATOR_HELPER}.embed_type classRef with no PEIndex")
							io.put_new_line
							io.set_output_default
						end
						if attached l_cls1 as l_cls2 then
							if
								l_cls2.in_assembly_ref
							then
								a_buf[a_offset + l_rv] := (l_cls2.pe_index |<< 2).to_integer_32 | {PE_TYPEDEF_OR_REF}.TypeRef
								l_rv := l_rv + 1
							else
								a_buf[a_offset + l_rv] := (l_cls2.pe_index |<< 2).to_integer_32 | {PE_TYPEDEF_OR_REF}.TypeDef
								l_rv := l_rv + 1
							end
						end
						if not l_cls.generics.is_empty then
							a_buf[a_offset + l_rv] := l_cls.generics.count
							l_rv := l_rv + 1
							across l_cls.generics as type loop
								l_rv := l_rv + embed_type (a_buf, a_offset + l_rv, type).to_integer_32
							end
						end
					end
				when {CIL_BASIC_TYPE}.method_ref then
					if attached {CIL_METHOD_SIGNATURE} l_tp.method_ref as l_sig then
						a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_FNPTR
						l_rv := l_rv + 1
						l_rv := l_rv + core_method (l_sig, l_sig.params.count, a_buf, a_offset + l_rv).to_integer_32
						if not l_sig.vararg_params.is_empty then
							signature_generator.work_area [a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_SENTINEL
							l_rv := l_rv + 1
							across l_sig.vararg_params as param loop
								l_rv := l_rv + embed_type (signature_generator.work_area, a_offset + l_rv, param.type).to_integer_32
							end
						end
					end
				when {CIL_BASIC_TYPE}.void_ then
					if l_tp.pe_index /= 0 then
 						a_buf[a_offset + l_rv] := {PE_TYPES_ENUM}.ELEMENT_TYPE_CLASS
 						l_rv := l_rv + 1
                		a_buf[a_offset + l_rv] := (l_tp.pe_index |<< 2).to_integer_32 | {PE_TYPEDEF_OR_REF}.TypeRef
                		l_rv := l_rv + 1
					end
				else
					-- fall through
					a_buf[a_offset + l_rv] := {PE_SIGNATURE_GENERATOR}.basic_types[{CIL_BASIC_TYPE}.index_of (l_tp.basic_type)]
					l_rv := l_rv + 1
				end
				--#if 0 // we only support SZARRAY of SZARRAY, not ARRAY
				--    if (tp->ArrayLevel() > 1)
				--    {
				--        buf[offset + rv++] = tp->ArrayLevel();  // rank
				--        buf[offset + rv++] = 0;                 // sizes = unsized
				--        buf[offset + rv++] = tp->ArrayLevel();  // lower bounds, set all to always zero for this
				--        for (int i = 0; i < tp->ArrayLevel(); i++)
				--            buf[offset + rv++] = 0;
				--    }
				--#endif
				Result := l_rv.to_natural_32
			end
		ensure
			instance_free: class
		end

feature -- Convert

	convert_to_blob (a_buf: SPECIAL [INTEGER]; a_size: INTEGER; a_sz: CELL [NATURAL_64]): ARRAY [NATURAL_8]
			-- this function converts a signature buffer to a blob entry, by compressing
			-- the integer values in the signature.
		local
			l_sz: NATURAL_32
			l_rv: SPECIAL [NATURAL_8]
			l_pos: INTEGER
		do
			l_sz := 0
			across 0 |..| (a_size - 1) as i loop
				if a_buf [i] >  0x3fff then
					l_sz := l_sz + 4
				elseif a_buf[i] > 0x7f then
					l_sz := l_sz + 2
				else
					l_sz := l_sz + 1
				end
			end
			create l_rv.make_empty (l_sz.to_integer_32)
			across 0 |..| (a_size - 1) as i loop
				if a_buf [i] > 0x3fff then
					l_rv[l_pos] := (((a_buf[i] |>> 24) & 0x1f) | 0xc0).to_natural_8
					l_pos := l_pos + 1
		            l_rv[l_pos] := ((a_buf[i] |>> 16) & 0xff).to_natural_8
		            l_pos := l_pos + 1
		            l_rv[l_pos] := ((a_buf[i] |>> 8) & 0xff).to_natural_8
		            l_pos := l_pos + 1
		            l_rv[l_pos] := (a_buf[i] & 0xff).to_natural_8
		            l_pos := l_pos + 1
				elseif (a_buf[i] > 0x7f) then
 		            l_rv[l_pos] := ((a_buf[i] |>> 8) | 0x80).to_natural_8
 		            l_pos := l_pos + 1
        		    l_rv[l_pos] := (a_buf[i] & 0xff).to_natural_8
        		    l_pos := l_pos + 1
        		else
        			l_rv[l_pos] := a_buf [i].to_natural_8
        			l_pos := l_pos + 1
        		end
			end
			a_sz.put (l_sz)
			create Result.make_from_special (l_rv)
		ensure
			instance_free: class
		end

	set_object_type (a_object_base: NATURAL_64)
		do
			 signature_generator.object_base := a_object_base.to_integer_32
		ensure
			instance_free: class
		end

feature -- Access

	core_method (a_method: detachable CIL_METHOD_SIGNATURE; a_param_count: INTEGER; a_buf: SPECIAL [INTEGER]; a_offset: INTEGER): NATURAL
		local
			l_orig_offset: INTEGER
			l_size: INTEGER
			l_flag: INTEGER
		do
			l_orig_offset := a_offset
			l_size := a_offset
			l_flag := 0
				--  for static members, flag will usually remain 0.

			if 	attached a_method as l_method and then
				(l_method.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.instance_flag) /= 0 then
				l_flag := l_flag | 0x20
			end
			if  attached a_method as l_method and then
				((l_method.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.vararg) /= 0)
				and then not ((l_method.flags & {CIL_METHOD_SIGNATURE_ATTRIBUTES}.Managed /= 0)) then
        		l_flag := l_flag | 5
        	end
			if 	attached a_method as l_method and then
				(a_method.generic_param_count /= 0) then
		        l_flag := l_flag | 0x10
		    end
		    signature_generator.work_area [l_size] := l_flag
		    l_size := l_size + 1

			if attached a_method as l_method and then
				(l_method.generic_param_count /= 0) then
		         signature_generator.work_area[l_size] := l_method.generic_param_count
		         l_size := l_size + 1
		    end
		    signature_generator.work_area [l_size] := a_param_count
		    l_size := l_size + 1
		    l_size := l_size + embed_type (signature_generator.work_area, l_size, if attached a_method as l_method then l_method.return_type else Void end).to_integer_32


			if attached a_method as l_method then
			    across l_method.params as elem loop
			    	l_size := l_size + embed_type (signature_generator.work_area, l_size, elem.type).to_integer_32
			    end
			end

			Result := (l_size - l_orig_offset).to_natural_32
		ensure
			instance_free: class
		end

	load_index (a_buf: SPECIAL [NATURAL_8]; a_start: CELL [NATURAL_32]; a_len: CELL [NATURAL_32]): NATURAL_32
		local
			l_start: INTEGER
			l_len: INTEGER
		do
			l_start := a_start.item.to_integer_32
			l_len := a_len.item.to_integer_32

			if not (a_buf [l_start] & 0x80 /= 0) then
				l_len := l_len - 1
				Result := a_buf [l_start]
				l_start := l_start + 1
			elseif not (a_buf [l_start] & 0x40 /= 0) then
				Result := ((a_buf [l_start + 0] & 0x7f) |<< 8) + a_buf [l_start + 1]
				l_start := l_start + 2
				l_len := l_len - 2
			else
				Result := ((a_buf [l_start ] & 0x3f) |<< 24) + (a_buf [l_start + 1] |<< 16) + (a_buf [l_start + 2] |<< 8) + a_buf [l_start + 3]
				l_start := l_start + 4
				l_len := l_len - 4
			end
			a_start.put (l_start.to_natural_32)
			a_len.put (l_len.to_natural_32)
		ensure
			instance_free: class
		end


end
