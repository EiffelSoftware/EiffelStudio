indexing
	description: "Support to allow convertions between dependant assemblies"

class
	ASSMEBLY_MANAGER_SUPPORT [G]
	
feature -- Convertion

	from_eiffel_linked_list (a_list: LINKED_LIST [G]) : LINKED_LIST [G] is
		do
			Result := a_list
		end
		
	to_eiffel_linked_list (a_list: LINKED_LIST [G]): LINKED_LIST [G] is
		do
			Result := a_list
		end
		
	from_array_any (array: ARRAY [G]) : ARRAY [G] is
		do
			Result := array
		end
		
	from_linked_list_any (list: LINKED_LIST [G]) : LINKED_LIST [G] is
		do
			Result := list
		end

--	from_eiffel_linked_list (a_list: LINKED_LIST [G]) : ARRAY_LIST is
--		indexing
--			description: "[
--				Converts an Eiffel LinkedList into a .net System.Collections.ArrayList
--				It automatically extracts CLI_CELL items and places them directly into
---				the list
--				]"
--		require
--			valid_list : a_list /= Void
--		local
--			item: G
--			cli_cell: CLI_CELL [G]
--			added: INTEGER
--		do
--			create Result.make
--			from
--				a_list.start
--			until
--				a_list.after
--			loop
--				cli_cell ?= a_list.item
--				if cli_cell /= Void then
--					added := Result.add (cli_cell.item)
--				else
--					item ?= a_list.item
--					if item /= Void then
--						added := Result.add (item)
--					end
--				end
--				a_list.forth
--			end
--		ensure
--			complete_list: a_list.count = Result.get_count
--			array_list_created: Result /= Void
--		end
--		
--	to_eiffel_linked_list (a_list: ARRAY_LIST): LINKED_LIST [G] is
--		indexing
--			description: "[
--				Converts an .net System.Collection.ArrayList  to an Eiffel Linked_List
--				It automatically detects if the list item derives from System.Object and
--				place a CLI_CELL wrapper around the item
--				]"
--		require
--			valid_list: a_list /= Void
--		local
--			i: INTEGER
--			object: SYSTEM_OBJECT
--			cli_cell: CLI_CELL [G]
--			item: G
--		do
--			create Result.make
--			from
--				i := 0
--			until
--				i = a_list.get_count
--			loop
--				object ?= a_list.get_item (i)
--				if object /= Void then
--					create cli_cell.put (object)
--					Result.extend (cli_cell)
--				else
--					item ?= a_list.get_item (i)
--					if item /= Void then
--						Result.extend (item)
--					end
--				end
--				i := i + 1
--			end
--		ensure
--			complete_list: a_list.get_count = Result.count
--			linked_list_created: Result /= Void
--		end
--		
--	from_array_any (array: ARRAY_ANY) : ARRAY [G] is
--		-- converts a ISE.Reflection.ArrayAny to an Array
--		local
--			i: INTEGER
--			item: G
--		do
--			create Result.make (array.lower, array.lower + array.count)
---			from
--				i := array.lower
--			until
--				i = array.lower + array.count
--			loop
--				item ?= array.item (i)
--				if (item /= Void) then
--					Result.put (item, i)
--				end
--				i := i + 1
--			end
--		end
--		
--	from_linked_list_any (list: LINKED_LIST_ANY) : LINKED_LIST [G] is
---		-- converts a ISE.Reflection.LinkedListAny to an LinkedList
--		local
--			i: INTEGER
--			item: G
--		do
--			create Result.make
--			from
--				list.start
--			until
--				list.after
--			loop
--				item ?= list.item
--				if (item /= Void) then
--					Result.extend (item)
--				end
--				list.forth
--			end
--		end
--
--	to_reflection_string (string: STRING ) : STRING is
--		indexing
--			description: "Converts a STRING to a INTERFACE_STRING"
--		do
--			if string /= Void then
--				Result := create {STRING}.make_from_cil ( string.to_cil )
--			end
--		end
--		
--	from_reflection_string (string: STRING ) : STRING is
--		indexing
--			description: "Converts a STRING to a STRING"
--		do
--			if string /= Void then
--				Result := create {STRING}.make_from_cil ( string.to_cil )
--			end
--		end

	to_reflection_string (string: STRING ) : STRING is
		indexing
			description: "Converts a STRING to a INTERFACE_STRING"
		do
			if string /= Void then
				Result := create {STRING}.make_from_cil ( string.to_cil )
			end
		end
		
	from_reflection_string (string: STRING ) : STRING is
		indexing
			description: "Converts a STRING to a STRING"
		do
			if string /= Void then
				Result := create {STRING}.make_from_cil ( string.to_cil )
			end
		end
		
	to_system_string (string: STRING): SYSTEM_STRING is
		indexing
			description: "Converts a Eiffel STRING into and .net System.String"
		do
			if string /= Void then
				Result := string.to_cil
			end
		end
		
	from_system_string (string: SYSTEM_STRING): STRING is
		indexing
			description: "Converts a .net System.String into and Eiffel STRING"
		do
			if string /= Void then
				create Result.make_from_cil (string)
			end	
		end


end -- ASSMEBLY_MANAGER_SUPPORT
