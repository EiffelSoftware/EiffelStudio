class SHARED

feature {NONE} -- Access

	input_arguments: ARRAYED_LIST [STRING_32]
			-- Arguments that enable input redirection.
		once
			create Result.make (6)
			Result.extend ("ioe")
			Result.extend ("oie")
			Result.extend ("oei")
			Result.extend ("ieo")
			Result.extend ("eio")
			Result.extend ("eoi")
			Result.compare_objects
		end

	no_input_arguments: ARRAYED_LIST [STRING_32]
			-- Arguments that disable input redirection.
		once
			Result := input_arguments.deep_twin
			across
				Result as c
			loop
				c.item.replace_substring_all ("i", "I")
			end
		end

	valid_arguments: STRING_TABLE [READABLE_STRING_32]
			-- Arguments expected by the supplier.
		once
			create Result.make (input_arguments.count * 2)
			across
				input_arguments as c
			loop
				Result.extend (c.item, c.item)
			end
			across
				no_input_arguments as c
			loop
				Result.extend (c.item, c.item)
			end
			Result.compare_objects
		end

feature {NONE} -- Input/Output

	output_file_name: STRING_32 = "supplier.out"
			-- Name of an output file.

	output_message: STRING_8 = "Supplier's message to standard output."

	error_message: STRING_8 = "Supplier's message to standard error."

end
