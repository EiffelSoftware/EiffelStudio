indexing
	description: "Sorting support"
	external_name: "ISE.AssemblyManager.SortingSupport"

class
	SORTING_SUPPORT

feature -- Access

	sorted_list: SYSTEM_COLLECTIONS_ARRAYLIST
		indexing
			description: "List sorted by assembly name"
			external_name: "SortedList"
		end

feature -- Basic Operations

	sort_assembly_descriptors (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_ASSEMBLYDESCRIPTOR]
		indexing
			description: "Sort list by assembly names. Make result available in `sorted_list'."
			external_name: "SortAssemblyDescriptors"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			tmp_list: SYSTEM_COLLECTIONS_ARRAYLIST
			tmp_table: SYSTEM_COLLECTIONS_HASHTABLE
			a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR
			a_name: STRING
			added: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					create tmp_list.make
					create tmp_table.make
				until
					i = a_list.count
				loop
					a_descriptor ?= a_list.item (i)
					if a_descriptor /= Void then
						added := tmp_list.add (a_descriptor.name)
						tmp_table.add (a_descriptor.name, a_descriptor)
					end
					i := i + 1
				end
				tmp_list.sort
				create sorted_list.make
				from
					i := 0
				until
					i = tmp_list.count
				loop
					a_name ?= tmp_list.item (i)
					if a_name /= Void then
						a_descriptor ?= tmp_table.item (a_name)
						if a_descriptor /= Void then
							added := sorted_list.add (a_descriptor)
						end
					end
					i := i + 1
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

	sort_eiffel_assemblies (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELASSEMBLY]
		indexing
			description: "Sort list by assembly names. Make result available in `sorted_list'."
			external_name: "SortEiffelAssemblies"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			tmp_list: SYSTEM_COLLECTIONS_ARRAYLIST
			tmp_table: SYSTEM_COLLECTIONS_HASHTABLE
			an_eiffel_assembly: ISE_REFLECTION_EIFFELASSEMBLY
			a_name: STRING
			added: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					create tmp_list.make
					create tmp_table.make
				until
					i = a_list.count
				loop
					an_eiffel_assembly ?= a_list.item (i)
					if an_eiffel_assembly /= Void then
						added := tmp_list.add (an_eiffel_assembly.assemblydescriptor.name)
						tmp_table.add (an_eiffel_assembly.assemblydescriptor.name, an_eiffel_assembly)
					end
					i := i + 1
				end
				tmp_list.sort
				create sorted_list.make
				from
					i := 0
				until
					i = tmp_table.count
				loop
					a_name ?= tmp_list.item (i)
					if a_name /= Void then
						an_eiffel_assembly ?= tmp_table.item (a_name)
						if an_eiffel_assembly /= Void then
							added := sorted_list.add (an_eiffel_assembly)
						end
					end
					i := i + 1
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

	sort_eiffel_classes (a_list: SYSTEM_COLLECTIONS_ARRAYLIST) is
			-- | SYSTEM_COLLECTIONS_ARRAYLIST [ISE_REFLECTION_EIFFELCLASS]
		indexing
			description: "Sort list by class Eiffel names. Make result available in `sorted_list'."
			external_name: "SortEiffelClasses"
		require
			non_void_list: a_list /= Void
		local
			i: INTEGER
			tmp_list: SYSTEM_COLLECTIONS_ARRAYLIST
			tmp_table: SYSTEM_COLLECTIONS_HASHTABLE
			an_eiffel_class: ISE_REFLECTION_EIFFELCLASS
			a_name: STRING
			added: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					create tmp_list.make
					create tmp_table.make
				until
					i = a_list.count
				loop
					an_eiffel_class ?= a_list.item (i)
					if an_eiffel_class /= Void then
						added := tmp_list.add (an_eiffel_class.eiffelname)
						tmp_table.add (an_eiffel_class.eiffelname, an_eiffel_class)
					end
					i := i + 1
				end
				tmp_list.sort
				create sorted_list.make
				from
					i := 0
				until
					i = tmp_table.count
				loop
					a_name ?= tmp_list.item (i)
					if a_name /= Void then
						an_eiffel_class ?= tmp_table.item (a_name)
						if an_eiffel_class /= Void then
							added := sorted_list.add (an_eiffel_class)
						end
					end
					i := i + 1
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
