indexing
	description: "Sorting support"
	external_name: "ISE.AssemblyManager.SortingSupport"

class
	SORTING_SUPPORT

feature -- Access

	sorted_list: LINKED_LIST [ANY]
		indexing
			description: "List sorted by assembly name"
			external_name: "SortedList"
		end

feature -- Basic Operations

	sort_assembly_descriptors (a_list: LINKED_LIST [ASSEMBLY_DESCRIPTOR]) is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ASSEMBLYDESCRIPTOR]
		indexing
			description: "Sort list by assembly names. Make result available in `sorted_list'."
			external_name: "SortAssemblyDescriptors"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			tmp_list: SORTED_TWO_WAY_LIST [STRING]
			tmp_table: HASH_TABLE [ASSEMBLY_DESCRIPTOR, STRING]
			a_descriptor: ASSEMBLY_DESCRIPTOR
			a_name: STRING
			added: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					create tmp_list.make
					create tmp_table.make (0)
					a_list.start
				until
					a_list.after
				loop
					a_descriptor ?= a_list.item
					if a_descriptor /= Void then
						tmp_list.extend (a_descriptor.name)
						tmp_table.extend (a_descriptor, a_descriptor.name)
					end
					a_list.forth
				end
				tmp_list.sort
				create sorted_list.make
				from
					tmp_list.start
				until
					tmp_list.after
				loop
					a_name ?= tmp_list.item
					if a_name /= Void then
						a_descriptor ?= tmp_table.item (a_name)
						if a_descriptor /= Void then
							sorted_list.extend (a_descriptor)
						end
					end
					tmp_list.forth
				end
			else
				sorted_list := a_list
			end
		ensure
			non_void_sorted_list: sorted_list /= Void
			valid_sorted_list: sorted_list.count = a_list.count
		rescue
			retried := True
			retry
		end

	sort_eiffel_assemblies (a_list: LINKED_LIST [EIFFEL_ASSEMBLY]) is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELASSEMBLY]
		indexing
			description: "Sort list by assembly names. Make result available in `sorted_list'."
			external_name: "SortEiffelAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			tmp_list: SORTED_TWO_WAY_LIST [STRING]
			tmp_table: HASH_TABLE [EIFFEL_ASSEMBLY, STRING]
			an_eiffel_assembly: EIFFEL_ASSEMBLY
			a_name: STRING
			added: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					create tmp_list.make
					create tmp_table.make (0)
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_assembly ?= a_list.item
					if an_eiffel_assembly /= Void then
						tmp_list.extend (an_eiffel_assembly.assembly_descriptor.name)
						tmp_table.extend (an_eiffel_assembly, an_eiffel_assembly.assembly_descriptor.name)
					end
					a_list.forth
				end
				tmp_list.sort
				create sorted_list.make
				from
					tmp_list.start
				until
					tmp_list.after
				loop
					a_name ?= tmp_list.item
					if a_name /= Void then
						an_eiffel_assembly ?= tmp_table.item (a_name)
						if an_eiffel_assembly /= Void then
							sorted_list.extend (an_eiffel_assembly)
						end
					end
					tmp_list.forth
				end
			else
				sorted_list := a_list
			end
		ensure
			non_void_sorted_list: sorted_list /= Void
		rescue
			retried := True
			retry
		end

	sort_eiffel_classes (a_list: LINKED_LIST [EIFFEL_CLASS]) is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [EIFFELCLASS]
		indexing
			description: "Sort list by class Eiffel names. Make result available in `sorted_list'."
			external_name: "SortEiffelClasses"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			tmp_list: SORTED_TWO_WAY_LIST [STRING]
			tmp_table: HASH_TABLE [EIFFEL_CLASS, STRING]
			an_eiffel_class: EIFFEL_CLASS
			a_name: STRING
			added: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					create tmp_list.make
					create tmp_table.make (0)
					a_list.start
				until
					a_list.after
				loop
					an_eiffel_class ?= a_list.item
					if an_eiffel_class /= Void then
						tmp_list.extend (an_eiffel_class.eiffel_name)
						tmp_table.extend (an_eiffel_class, an_eiffel_class.eiffel_name)
					end
					a_list.forth
				end
				tmp_list.sort
				create sorted_list.make
				from
					tmp_list.start
				until
					tmp_list.after
				loop
					a_name ?= tmp_list.item
					if a_name /= Void then
						an_eiffel_class ?= tmp_table.item (a_name)
						if an_eiffel_class /= Void then
							sorted_list.extend (an_eiffel_class)
						end
					end
					tmp_list.forth
				end
			else
				sorted_list := a_list
			end
		ensure
			non_void_sorted_list: sorted_list /= Void
		rescue
			retried := True
			retry
		end
		
		
end -- class SORTING_SUPPORT
