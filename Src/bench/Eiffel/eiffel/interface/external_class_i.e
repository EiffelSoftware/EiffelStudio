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
			make as old_make
		redefine
			external_name, file_name, is_external_class, cluster
		end

create
	make

feature {NONE} -- Initialization

	make (a_name, an_external_name: STRING; a_file_location: like file_name) is
			-- Create new instance of Current.
		require
			a_name_not_void: a_name /= Void
			an_external_name_not_void: an_external_name /= Void
			a_file_location_not_void: a_file_location /= Void
		do
				-- Initialize Current with passed information and
				-- compute file date on `file_name'.
			name := a_name
			external_name := an_external_name
			file_name := a_file_location
			set_date
		ensure
			name_set: name = a_name
			external_name_set: external_name = an_external_name
			file_name_set: file_name = a_file_location
		end

feature -- Access

	external_name: STRING
			-- Name of class as known in .NET
			
	file_name: FILE_NAME
			-- File where XML data of current class is stored.

	cluster: ASSEMBLY_I
			-- Cluster is an assembly.

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
			l_result: CLASS_I
			l_name: STRING
			l_is_array: BOOLEAN
			l_array_type: CONSUMED_ARRAY_TYPE
--			l_gen_type: GEN_TYPE_I
		do
			l_assembly := cluster.referenced_assemblies.item (c.assembly_id)
			l_array_type ?= c
			l_is_array := l_array_type /= Void
			if l_is_array then
				Result := System.native_array_class
				--TO DO
--				create l_generics.make (1, 1)
--				l_generics.put (type_from_consumed_type (l_array_type.element_type), 1)
--				create {GEN_TYPE_I} Result.make (
--					System.native_array_class.compiled_class.class_id) --, l_generics)
			else
				l_name := c.name
				l_result := l_assembly.dotnet_classes.item (l_name)
				if l_result = Void then
						-- Case where this is a class from `mscorlib' that is in fact
						-- written as an Eiffel class, e.g. INTEGER, ....
					if l_name.is_equal ("System.Byte") or l_name.is_equal ("System.SByte") then
						l_result := System.integer_8_class
					elseif l_name.is_equal ("System.Int16") or l_name.is_equal ("System.UInt16") then
						l_result := System.integer_16_class
					elseif l_name.is_equal ("System.Int32") or l_name.is_equal ("System.UInt32") then
						l_result := System.integer_32_class
					elseif l_name.is_equal ("System.Int64") or l_name.is_equal ("System.UInt64") then
						l_result := System.integer_64_class
					elseif l_name.is_equal ("System.IntPtr") or l_name.is_equal ("System.UIntPtr") then
						l_result := System.pointer_class
					elseif l_name.is_equal ("System.Double") then
						l_result := System.double_class
					elseif l_name.is_equal ("System.Single") then
						l_result := System.real_class
					elseif l_name.is_equal ("System.Char") then
						l_result := System.character_class
					elseif l_name.is_equal ("System.Boolean") then
						l_result := System.boolean_class
					end
				end

				Result := l_result
				
			end
		ensure
			result_not_void: Result /= Void
		end

invariant
	name_not_void: name /= Void
	external_name_not_void: external_name /= Void
	file_name_not_void: file_name /= Void
	
end -- class EXTERNAL_CLASS_I
