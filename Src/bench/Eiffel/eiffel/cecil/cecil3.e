-- Cecil table for generic classes

class CECIL3 

inherit

	CECIL2
		redefine
			key_name, generate, make_byte_code
		end

creation
	init
	
feature 

	generate is
			-- Generic classes table generation
		local
			a_class: CLASS_C
			i: INTEGER
			gen_type: GEN_TYPE_I
			types: TYPE_LIST
			local_values: like values
			buffer: GENERATION_BUFFER
		do
			buffer := generation_buffer
			generate_keys (buffer)
			local_values := values

			from
				i := lower
			until
				i > upper
			loop
				a_class := local_values.item (i)
				if a_class /= Void and then
					a_class.has_types
				then
					check
						a_class.generics /= Void
					end
					buffer.putstring ("static int32 patterns")
					buffer.putint (a_class.class_id)
					buffer.putstring (" [] = {%N")
					from
						types := a_class.types
						types.start
					until
						types.after
					loop
						gen_type ?= types.item.type
						gen_type.meta_generic.generate_cecil_values(buffer)
						types.forth
					end
					buffer.putstring ("SK_INVALID%N};%N%N")
					
					buffer.putstring ("static int16 dyn_types")
					buffer.putint (a_class.class_id)
					buffer.putstring (" [] = {%N")
					from
						types.start
					until
						types.after
					loop
						buffer.putint (types.item.type_id - 1)
						buffer.putstring (",%N")
						types.forth
					end
					buffer.putstring ("};%N%N")

				end
				i := i + 1
			end

			buffer.putstring ("static struct gt_info gtype_val[] = {%N")
			from
				i := lower
			until
				i > upper
			loop
				a_class := local_values.item (i)
				if (a_class = Void) or else not a_class.has_types then
					buffer.putstring ("{(int) 0, (int32 *) 0, (int16 *) 0}")
				else
					buffer.putstring ("{(int) ")
					buffer.putint (a_class.generics.count)
					buffer.putstring (", patterns")
					buffer.putint (a_class.class_id)
					buffer.putstring (", dyn_types")
					buffer.putint (a_class.class_id)
					buffer.putchar ('}')
				end
				buffer.putstring (",%N")
				i := i + 1
			end
			buffer.putstring ("};%N%N")

			buffer.putstring ("struct ctable egc_ce_gtype_init = {(int32) ")
			buffer.putint (count)
			buffer.putstring (", sizeof(struct gt_info),")
			buffer.putstring (key_name)
			buffer.putstring (", (char *) gtype_val};%N%N")

			wipe_out
		end

	key_name: STRING is 
			-- Name of the static key table
		once
			Result := "gtype_key"
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for the current table
		local
			i: INTEGER
			a_class: CLASS_C
			types: TYPE_LIST
			gen_type: GEN_TYPE_I
			local_values: like values
		do
			ba.append_short_integer (upper - lower + 1)
			make_key_byte_code (ba)
			from
				local_values := values
				i := lower
			until
				i > upper
			loop
				a_class := local_values.item (i)
				if a_class = Void then
						-- No generics
					ba.append_short_integer (0)
						-- No meta-types
				else
						-- Number of generics
					ba.append_short_integer (a_class.generics.count)
					types := a_class.types
					ba.append_short_integer (types.count)
						-- Meta type description array
					from
						types.start
					until
						types.after
					loop
						gen_type ?= types.item.type
						gen_type.meta_generic.make_byte_code (ba)
						types.forth
					end
						-- Dynamic type array
					from
						types.start
					until
						types.after
					loop
						ba.append_short_integer (types.item.type_id - 1)
						types.forth
					end
				end
				i := i + 1
			end
			wipe_out
		end

end
