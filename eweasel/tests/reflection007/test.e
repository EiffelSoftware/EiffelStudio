note
	description: "System's root class"
--	assembly_metadata: create {DEBUGGABLE_ATTRIBUTE}.make (True, True) end

class
	TEST

inherit
	EXPANDED_COUNTER

create
	make, default_create

feature -- Initialization

	make
			-- Creation procedure.
		local
			l_obj: TEST1
			l_reflected: REFLECTED_REFERENCE_OBJECT
			l_counter, l_new_counter: INTEGER
		do
			create l_obj.make
			print_object (l_obj)
			l_counter := counter.item
			create l_reflected.make (l_obj)
			l_reflected := l_reflected.expanded_field (1)
			update_test2_instance (l_reflected.copy_semantics_field (1))
			l_new_counter := counter.item
			if l_counter /= l_new_counter then
				io.put_string ("Error, expanded copies were made%N")
			end
			print_object (l_obj)
		end

	print_object (a_obj: TEST1)
		do
			io.put_string ("Printing object: %N")
			if True then
				io.put_string (" attr = {TEST2} {")
				io.put_new_line
				check attached {TEST3} a_obj.attr.attr as l_attr then
					io.put_string ("   str3 = " + l_attr.str3)
					io.put_new_line
					io.put_string ("   int3 = " + l_attr.int3.out)
					io.put_new_line
					io.put_string ("   exp3 = {TEST4} {")
					io.put_new_line
					if True then
						io.put_string ("     str4 = " + l_attr.exp3.str4)
						io.put_new_line
						io.put_string ("     int4 = " + l_attr.exp3.int4.out)
						io.put_new_line
						io.put_string ("     exp4 = {TEST5} {")
						io.put_new_line
						if True then
							io.put_string ("       str5 = " + l_attr.exp3.exp4.str5)
							io.put_new_line
							io.put_string ("       int5 = " + l_attr.exp3.exp4.int5.out)
							io.put_new_line
							io.put_string ("       attr5 = {TEST6} {")
							io.put_new_line
							check attached {TEST6} l_attr.exp3.exp4.attr5 as l_nested_attr then
								io.put_string ("         str6 = " + l_nested_attr.str6)
								io.put_new_line
								io.put_string ("         int6 = " + l_nested_attr.int6.out)
								io.put_new_line
								io.put_string ("         attr6 = {TEST7} {")
								io.put_new_line
								check attached {TEST7} l_nested_attr.attr6 as l_attr6 then
									io.put_string ("           str7 = " + l_attr6.str7)
									io.put_new_line
									io.put_string ("           int7 = " + l_attr6.int7.out)
									io.put_new_line
									if attached l_attr6.attr7 as l_attr7 then
										io.put_string ("           attr7 = " + l_attr7.out)
									else
										io.put_string ("           attr7 = Void")
									end
									io.put_new_line
								end
								io.put_string ("         }")
								io.put_new_line
							end
							io.put_string ("       }")
							io.put_new_line
						end
						io.put_string ("     }")
						io.put_new_line
					end
					io.put_string ("   }")
					io.put_new_line
				end
				io.put_string (" }")
				io.put_new_line
			end
		end

	update_test2_instance (a_field: REFLECTED_COPY_SEMANTICS_OBJECT)
		local
			i, nb: INTEGER
		do
			from
				i := 1
				nb := a_field.field_count
			until
				i > nb
			loop
				inspect a_field.field_type (i)
				when {REFLECTOR_CONSTANTS}.integer_type then
					if not a_field.field_name (i).same_string ("counter") then
						a_field.set_integer_32_field (i, a_field.integer_32_field (i) + 10000)
					end

				when {REFLECTOR_CONSTANTS}.expanded_type then
					update_test2_instance (a_field.expanded_field (i))

				when {REFLECTOR_CONSTANTS}.reference_type then
					if a_field.is_copy_semantics_field (i) then
						update_test2_instance (a_field.copy_semantics_field (i))
					else
						if attached {STRING} a_field.reference_field (i) as l_str then
							l_str.append ("_modified")
							a_field.set_reference_field (i, l_str)
						end
					end
				end
				i := i + 1
			end
		end

	reflector: REFLECTOR
		once
			create Result
		end

end
