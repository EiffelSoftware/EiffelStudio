indexing
	description: "Encapsulation of a C extension and no generation has to be done."
	date: "$Date$"
	revision: "$Revision$"

class C_EXT_BYTE_CODE

inherit
	EXT_BYTE_CODE
		redefine
			generate_body
		end

feature -- Generation

	generate_body is
		do
			if is_during_il then
				generate_c_extern_declaration
				Precursor {EXT_BYTE_CODE}
			end
		end

	generate_c_extern_declaration is
			-- Generate declaration for C external `name_id'.
		local
			header: like Header_generation_buffer
			l_args: like std_argument_types
			l_names_heap: like Names_heap
			l_type: TYPE_I
			i, nb: INTEGER
		do
			header := Header_generation_buffer
			if header_files = Void then
				l_names_heap := Names_heap
				header.putstring ("extern ")
				if return_type > 0 then
					header.putstring (l_names_heap.item (return_type))
				else
					l_type := context.real_type (result_type)
					if not l_type.is_void then
						l_type.c_type.generate (header)
					end
				end

				header.putstring (l_names_heap.item (external_name_id))
				
				header.putchar ('(')
				if argument_types /= Void then
					from
						i := argument_types.lower
						nb := argument_types.upper
					until
						i > nb
					loop
						header.putstring (l_names_heap.item (argument_types.item (i)))
						if i < nb then
							header.putstring (", ")
						end
						i := i + 1
					end
				else
					l_args := std_argument_types
					from
						i := l_args.lower
						nb := l_args.upper
					until
						i > nb
					loop
						header.putstring (l_args.item (i))
						if i < nb then
							header.putstring (", ")
						end
						i := i + 1
					end
				end
				header.putstring (");")
				header.new_line
			end
		end	

end -- class C_EXT_BYTE_CODE
