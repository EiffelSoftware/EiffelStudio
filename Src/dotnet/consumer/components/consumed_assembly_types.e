indexing
	description: "Table of consumed types for a given assembly"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ASSEMBLY_TYPES

create
	make

feature {NONE} -- Initialization

	make (count: INTEGER) is
			-- Create name arrays.
		do
			create eiffel_names.make (1, count)
			create dotnet_names.make (1, count)
			create flags.make (1, count)
		end
		
feature -- Access

	eiffel_names: ARRAY [STRING]
			-- Assembly types eiffel name
	
	dotnet_names: ARRAY [STRING]
			-- Assembly types .NET name

	flags: ARRAY [INTEGER]
			-- Assembly types attributes (i.e. is type an interface an enum etc...)
			--| See class {TYPE_FLAGS} for possible values.
	
	index: INTEGER
			-- Number of items in arrays

	namespaces: ARRAY [STRING] is
			-- Namespaces
		local
			i, l_index, namespace_count, count: INTEGER
			namespace, name: STRING
			l_namespaces: ARRAYED_LIST [STRING]
		do
			create l_namespaces.make (index)
			l_namespaces.compare_objects
			from
				i := 1
				count := dotnet_names.count
				namespace_count := 1
			until
				i > count
			loop
				name := dotnet_names.item (i)
				l_index := name.last_index_of ('.', name.count)
				namespace := Void
				if l_index > 0 then
					namespace := name.substring (1, l_index - 1)
				end
				if namespace /= Void and then not l_namespaces.has (namespace) then
					l_namespaces.extend (namespace)
					namespace_count := namespace_count + 1
				end
				i := i + 1
			end
			create Result.make (1, namespace_count)
			from
				l_namespaces.start
			until
				l_namespaces.after
			loop
				Result.put (l_namespaces.item, l_namespaces.index)
				l_namespaces.forth
			end
		end
	
	namespace_types (namespace_name: STRING): ARRAY [INTEGER] is
			-- Indices of types that belong to namespace `namespace_name'.
		require
			non_void_name: namespace_name /= Void 
			valid_name: namespaces.has (namespace_name)
		local
			i, l_index, types_count, count: INTEGER
			name: STRING
			l_types_index: ARRAYED_LIST [INTEGER]
		do
			create l_types_index.make (index)
			from
				i := 1
				count := dotnet_names.count
			until
				i > count
			loop
				name := dotnet_names.item (i)
				l_index := name.substring_index (namespace_name, 1)
				if l_index = 1 and then name.substring (namespace_name.count, name.count).occurrences ('.') = 1 then
					l_types_index.extend (i)
					types_count := types_count + 1
				end
				i := i + 1
			end
			create Result.make (1, types_count)
			from
				l_types_index.start
			until
				l_types_index.after
			loop
				Result.put (l_types_index.item, l_types_index.index)
				l_types_index.forth
			end
		end
		
feature -- Element Settings	

	put (dn, en: STRING; int, enum, dele, val: BOOLEAN) is
			-- Add type with Eiffel name `en' and .NET name `dn'.
			-- type is interface if `int' is true, enum if `enum'
			-- is true, delegate if `dele' is true, deferred if
			-- `def' is true and value type if `val' is true.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
		local
			flag: INTEGER
		do
			index := index + 1
			eiffel_names.put (en, index)
			dotnet_names.put (dn, index)
			if int then
				flag := feature {TYPE_FLAGS}.Is_interface
			elseif enum then
				flag := feature {TYPE_FLAGS}.Is_enum
			elseif dele then
				flag := feature {TYPE_FLAGS}.Is_delegate
			elseif val then
				flag := feature {TYPE_FLAGS}.Is_value_type
			end
			flags.put (flag, index)
		ensure
			eiffel_name_inserted: eiffel_names.item (eiffel_names.count) = en
			dotnet_name_inserted: dotnet_names.item (dotnet_names.count) = dn
		end

end -- class CONSUMED_ASSEMBLY_TYPES
