indexing
	description: "[
		Representation of a class that has been generated
		in a different compilation or language in .NET context.
		Used to consume external types in Eiffel.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	EXTERNAL_CLASS_I

inherit
	CLASS_I
		rename
			make as old_make,
			cluster as assembly
		redefine
			external_name, file_name, is_external_class, assembly
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly; a_name, an_external_name: STRING; a_file_location: like base_name) is
			-- Create new instance of Current.
		require
			a_name_not_void: a_name /= Void
			an_external_name_not_void: an_external_name /= Void
			a_file_location_not_void: a_file_location /= Void
		do
				-- Initialize Current with passed information and
				-- compute file date on `file_name'.
			assembly := an_assembly
			name := a_name
			external_name := an_external_name
			base_name := a_file_location
			set_date
		ensure
			name_set: name = a_name
			external_name_set: external_name = an_external_name
			base_name_set: base_name = a_file_location
		end

feature -- Access

	external_name: STRING
			-- Name of class as known in .NET
			
	assembly: ASSEMBLY_I
			-- Cluster is an assembly.

	file_name: FILE_NAME is
			-- Full file name of the class
		do
			create Result.make_from_string (assembly.path)
			Result.extend (classes_directory)
			Result.set_file_name (base_name)
		ensure then
			file_name_not_void: Result /= Void
		end

feature -- Status Report

	is_external_class: BOOLEAN is True
			-- Class is defined outside current system.
			
	is_eiffel_class: BOOLEAN
			-- Is Current class originally written in Eiffel.

	type_from_consumed_type (c: CONSUMED_REFERENCED_TYPE): CLASS_I is
			-- Given an external type `c' get its associated CLASS_I.
		require
			c_not_void: c /= Void
		local
			l_assembly: ASSEMBLY_I
			l_name: STRING
			l_is_array: BOOLEAN
			l_array_type: CONSUMED_ARRAY_TYPE
		do
			l_assembly := assembly.referenced_assemblies.item (c.assembly_id)
			l_array_type ?= c
			l_is_array := l_array_type /= Void
			if l_is_array then
				Result := System.native_array_class
			else
				if c.is_by_ref then
					Result := System.typed_pointer_class
				else
					l_name := c.name
					Result := l_assembly.dotnet_classes.item (l_name)
					if Result = Void then
							-- Case where this is a class from `mscorlib' that is in fact
							-- written as an Eiffel class, e.g. INTEGER, ....
						check
							has_basic_type: basic_type_mapping.has (l_name)
						end
						Result := basic_type_mapping.item (l_name)
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

feature {EXTERNAL_CLASS_C} -- Mapping

	basic_type_mapping: HASH_TABLE [CLASS_I, STRING] is
			-- Mapping between name of basic class in mscorlib and Eiffel CLASS_I.
		once
			create Result.make (20)
			Result.put (System.boolean_class, "System.Boolean")
			Result.put (System.character_class, "System.Char")
			Result.put (System.integer_8_class, "System.SByte")
			Result.put (System.integer_16_class, "System.Int16")
			Result.put (System.integer_32_class, "System.Int32")
			Result.put (System.integer_64_class, "System.Int64")
			Result.put (System.natural_8_class, "System.Byte")
			Result.put (System.natural_16_class, "System.UInt16")
			Result.put (System.natural_32_class, "System.UInt32")
			Result.put (System.natural_64_class, "System.UInt64")
			Result.put (System.pointer_class, "System.IntPtr")
			Result.put (System.pointer_class, "System.UIntPtr")
			Result.put (System.real_32_class, "System.Single")
			Result.put (System.real_64_class, "System.Double")
		ensure
			basic_type_mapping_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	classes_directory: STRING is "classes"
			-- Directory from Assembly location where classes are located.

invariant
	name_not_void: name /= Void
	external_name_not_void: external_name /= Void
	file_name_not_void: file_name /= Void
	
end -- class EXTERNAL_CLASS_I
