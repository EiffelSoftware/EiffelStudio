indexing
	description: "Hash table of classes."
	date: "$Date$"
	revision: "$Revision$"

class CECIL_CLASS_TABLE 

inherit
	CECIL_TABLE [CLASS_C]

create
	init
	
feature -- C code generation

	generate is
			-- Generic classes table generation
		local
			buffer: GENERATION_BUFFER
			l_values: like values
			l_keys: like keys
		do
			buffer := generation_buffer
			l_values := values
			l_keys := keys

				-- Generate entries for references
			prepare_entries (False, l_keys, l_values)
			internal_generate (buffer, False)

				-- Generate entries for expanded
			prepare_entries (True, l_keys, l_values)
			internal_generate (buffer, True)

			wipe_out
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Produce byte code for the current table
		local
			l_values: like values
			l_keys: like keys
		do
			l_values := values
			l_keys := keys

				-- Generate entries for references
			prepare_entries (False, l_keys, l_values)
			internal_make_byte_code (ba, False)

				-- Generate entries for expanded
			prepare_entries (True, l_keys, l_values)
			internal_make_byte_code (ba, True)

			wipe_out
		end

feature {NONE} -- Convenience

	prepare_entries (for_expanded: BOOLEAN; a_keys: like keys; a_values: like values) is
			-- Check where we have entries depending on value of `for_expanded'.
		require
			a_keys_not_void: a_keys /= Void
			a_values_not_void: a_values /= Void
			same_capacity: a_keys.capacity = a_values.capacity
		local
			i, nb, nb_entries: INTEGER
			a_class: CLASS_C
			l_has_entry: BOOLEAN
			l_types: TYPE_LIST
			l_values: like values
			l_keys: like keys
			l_used_entries: ARRAY [BOOLEAN]
		do
			l_values := a_values
			l_keys := a_keys
			nb := l_keys.capacity - 1

				-- First compute number of entries for case `for_expanded'.
			from
				i := 0
				create l_used_entries.make (0, nb)
			until
				i > nb
			loop
				a_class := l_values.item (i)
				if a_class /= Void then
					from
						l_types := a_class.types
						l_has_entry := False
						l_types.start
					until
						l_types.after or l_has_entry
					loop
						l_has_entry := 
							(for_expanded and l_types.item.is_expanded) or
							(not for_expanded and not l_types.item.is_expanded)
						l_types.forth
					end
					if l_has_entry then
						l_used_entries.put (True, i)
						nb_entries := nb_entries + 1
					end
				end
				i := i + 1
			end

				-- Now fill internal data only with required entries.
			init (nb_entries)
			from
				i := 0
			until
				i > nb
			loop
				if l_used_entries.item (i) then
					put (l_values.item (i), class_name (l_values.item (i), l_keys.item (i), for_expanded))
				end
				i := i + 1
			end
		end

	class_name (a_class: CLASS_C; a_given_class_name: STRING; for_expanded: BOOLEAN): STRING is
			-- Associated class name of `a_class' using given name `a_given_class_name'
			-- when treated as `for_expanded' status.
		require
			a_class_not_void: a_class /= Void
			a_given_class_name: a_given_class_name /= Void
		do
			if for_expanded then
				if a_class.is_expanded then
					Result := a_given_class_name
				else
					create Result.make (9 + a_given_class_name.count)
					Result.append ("expanded ")
					Result.append (a_given_class_name)
				end
			else
				if a_class.is_expanded then
					create Result.make (10 + a_given_class_name.count)
					Result.append ("reference ")
					Result.append (a_given_class_name)
				else
					Result := a_given_class_name
				end
			end
		ensure
			class_name_not_void: Result /= Void
		end
		
feature {NONE} -- C code generation

	internal_generate (buffer: GENERATION_BUFFER; for_expanded: BOOLEAN) is
			-- Generic classes table generation.
		require
			buffer_not_void: buffer /= Void
		local
			a_class: CLASS_C
			i, nb: INTEGER
			gen_type: GEN_TYPE_I
			l_types: TYPE_LIST
			l_values: like values
			l_keys: like keys
			l_is_generic: BOOLEAN
			cl_name: STRING
		do
			l_values := values
			l_keys := keys

				-- Generate the keys
			if for_expanded then
				buffer.putstring ("static char * exp_type_key [] = {%N")
			else
				buffer.putstring ("static char * type_key [] = {%N")
			end			
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				cl_name := l_keys.item (i)
				if cl_name = Void then
					buffer.putstring ("(char *) 0")
				else
					buffer.putchar ('"')
					buffer.putstring (cl_name)
					buffer.putchar ('"')
				end
				buffer.putstring (",%N")
				i := i + 1
			end
			buffer.putstring ("};%N%N")
			
				-- Generate the subvalues needed to fill the values
			from
				i := 0
			until
				i > nb
			loop
				a_class := l_values.item (i)
				if a_class /= Void then
					l_is_generic := a_class.is_generic
					if l_is_generic then
						if for_expanded then
							buffer.putstring ("static int32 exp_patterns")
						else
							buffer.putstring ("static int32 patterns")
						end
						buffer.putint (a_class.class_id)
						buffer.putstring (" [] = {%N")
						from
							l_types := a_class.types
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								if l_is_generic then
									gen_type ?= l_types.item.type
									check
										gen_type_not_void: gen_type /= Void
									end
									gen_type.meta_generic.generate_cecil_values (buffer)
								else
									l_types.item.type.generate_cecil_value (buffer)
									buffer.putstring (",%N")
								end
							end
							l_types.forth
						end
						buffer.putstring ("SK_INVALID%N};%N%N")
						
						if for_expanded then
							buffer.putstring ("static int16 exp_dyn_types")
						else
							buffer.putstring ("static int16 dyn_types")
						end
						buffer.putint (a_class.class_id)
						buffer.putstring (" [] = {%N")
						from
							l_types.start
						until
							l_types.after
						loop
							if
								(for_expanded and l_types.item.is_expanded) or
								(not for_expanded and not l_types.item.is_expanded)
							then
								buffer.putint (l_types.item.type_id - 1)
								buffer.putstring (",%N")
							end
							l_types.forth
						end
						buffer.putstring ("};%N%N")
					end
				end
				i := i + 1
			end

				-- Generate the values using above subvalues.
			if for_expanded then
				buffer.putstring ("static struct cecil_info exp_type_val[] = {%N")
			else
				buffer.putstring ("static struct cecil_info type_val[] = {%N")
			end
			from
				i := 0
			until
				i > nb
			loop
				a_class := l_values.item (i)
				if a_class = Void then
					buffer.putstring ("{(int) 0, (int16) 0, NULL, NULL}")
				else
					buffer.putstring ("{(int) ")
					if a_class.is_generic then
						buffer.putint (a_class.generics.count)
						if for_expanded then
							buffer.putstring (", (int16) 0, exp_patterns")
							buffer.putint (a_class.class_id)
							buffer.putstring (", exp_dyn_types")
							buffer.putint (a_class.class_id)
						else
							buffer.putstring (", (int16) 0, patterns")
							buffer.putint (a_class.class_id)
							buffer.putstring (", dyn_types")
							buffer.putint (a_class.class_id)
						end
					else
						buffer.putstring ("0, (int16) ")
						buffer.putint (a_class.types.first.type_id - 1)
						buffer.putstring (", NULL, NULL")
					end
					buffer.putchar ('}')
				end
				buffer.putstring (",%N")
				i := i + 1
			end
			buffer.putstring ("};%N%N")

				-- Generate table
			if for_expanded then
				buffer.putstring ("struct ctable egc_ce_exp_type_init = {(int32) ")
			else
				buffer.putstring ("struct ctable egc_ce_type_init = {(int32) ")
			end
			buffer.putint (capacity)
			buffer.putstring (", sizeof(struct cecil_info),")
			if for_expanded then
				buffer.putstring ("exp_type_key, (char *) exp_type_val};%N%N")
			else
				buffer.putstring ("type_key, (char *) type_val};%N%N")
			end
		end

feature {NONE} -- Byte code generation

	internal_make_byte_code (ba: BYTE_ARRAY; for_expanded: BOOLEAN) is
			-- Produce byte code for class name array.
		local
			i, nb, nb_types: INTEGER
			cl_name: STRING
			a_class: CLASS_C
			l_types: TYPE_LIST
			gen_type: GEN_TYPE_I
			l_keys: like keys
			l_values: like values
			l_is_generic: BOOLEAN
		do
			l_values := values
			l_keys := keys
			
			ba.append_short_integer (capacity)
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				cl_name := l_keys.item (i)
				if cl_name = Void then
					ba.append_short_integer (0)
				else
					ba.append_string (cl_name)
				end
				i := i + 1
			end
			
			from
				i := 0
				nb := capacity - 1
			until
				i > nb
			loop
				a_class := l_values.item (i)
				if a_class = Void then
						-- No generics
					ba.append_short_integer (0)
						-- No meta-types
					ba.append_short_integer (0)
				else
					l_is_generic := a_class.is_generic
						-- Number of generics
					if l_is_generic then
						ba.append_short_integer (a_class.generics.count)
					else
						ba.append_short_integer (0)
					end

						-- Compute number of types that needs to be generated.
					from
						l_types := a_class.types
						nb_types := 0
						l_types.start
					until
						l_types.after
					loop
						if
							(for_expanded and l_types.item.is_expanded) or
							(not for_expanded and not l_types.item.is_expanded)
						then
							nb_types := nb_types + 1
						end
						l_types.forth
					end

					check
						has_types: nb_types > 0
					end
					ba.append_short_integer (nb_types)

						-- Meta type description array
					from
						l_types.start
					until
						l_types.after
					loop
						if
							(for_expanded and l_types.item.is_expanded) or
							(not for_expanded and not l_types.item.is_expanded)
						then
							if l_is_generic then
								gen_type ?= l_types.item.type
								check
									gen_type_not_void: gen_type /= Void
								end
								gen_type.meta_generic.make_byte_code (ba)
							else
								ba.append_int32_integer (l_types.item.type.cecil_value)
							end
						end
						l_types.forth
					end

						-- Dynamic type array
					from
						l_types.start
					until
						l_types.after
					loop
						if
							(for_expanded and l_types.item.is_expanded) or
							(not for_expanded and not l_types.item.is_expanded)
						then
							ba.append_short_integer (l_types.item.type_id - 1)
						end
						l_types.forth
					end
				end
				i := i + 1
			end
		end

end
