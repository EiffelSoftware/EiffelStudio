indexing
	description: "Converts the types and structs to and from Eiffel and .net"
	
class GLOBAL_CONVERSATION [G -> ANY]
	
feature -- Conversion

	from_eiffel_linked_list (a_list: LINKED_LIST [G]) : ARRAY_LIST is
		indexing
			description: "Converts an Eiffel LinkedList into a .net System.Collections.ArrayList"
		require
			valid_list : a_list /= Void
		local
			any: G
			--cli_cell: CLI_CELL [SYSTEM_OBJECT]
			added: INTEGER
		do
			create Result.make
			from
				a_list.start
			until
				a_list.after
			loop
			--	cli_cell ?= a_list.item
			--	if cli_cell /= Void then
			--		added := Result.add (cli_cell.item)
			--	else
					any ?= a_list.item
					if any /= Void then
						added := Result.add (any)
					end
			--	end
				a_list.forth
			end
		ensure
			complete_list: a_list.count = Result.get_count
			array_list_created: Result /= Void
		end
		
	to_eiffel_linked_list (a_list: ARRAY_LIST): LINKED_LIST [G] is
		indexing
			description: "Converts an .net System.Collection.ArrayList  to an Eiffel Linked_List"
		require
			valid_list: a_list /= Void
		local
			i: INTEGER
			--object: SYSTEM_OBJECT
			any: G
		do
			create Result.make
			from
				i := 0
			until
				i = a_list.get_count
			loop
				--object ?= a_list.get_item (i)
				--if object /= Void then
				--	create cli_cell.put (object)
				--	Result.extend (cli_cell)
				--else
					any ?= a_list.get_item (i)
					if any /= Void then
						Result.extend (any)
					end
				--end
				i := i + 1
			end
		ensure
			complete_list: a_list.get_count = Result.count
			linked_list_created: Result /= Void
		end

	from_eiffel_string (string: STRING): SYSTEM_STRING is
		indexing
			description: "Converts a Eiffel STRING into and .net System.String"
		require
			valid_string: string /= Void
		do
			Result := string.to_cil
		end
		
	to_eiffel_string (string: SYSTEM_STRING): STRING is
		indexing
			description: "Converts a .net System.String into and Eiffel STRING"
		require
			valid_string: string /= Void
		do
			create Result.make_from_cil (string)
		ensure
			string_created: Result /= Void
		end

end -- GLOBAL_CONVERSATION