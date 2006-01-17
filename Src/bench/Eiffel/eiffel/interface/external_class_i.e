indexing
	description: "[
		Representation of a class that has been generated
		in a different compilation or language in .NET context.
		Used to consume external types in Eiffel.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			external_name, is_external_class, assembly
		end

create
	make

feature {NONE} -- Initialization

	make (an_assembly: like assembly; a_name, an_external_name: STRING; a_pos: like file_position) is
			-- Create new instance of Current.
		require
			a_name_not_void: a_name /= Void
			an_external_name_not_void: an_external_name /= Void
			a_pos_non_negative: a_pos >= 0
		do
				-- Initialize Current with passed information and
				-- compute file date on `file_name'.
			assembly := an_assembly
			name := a_name
			external_name := an_external_name
			base_name := classes_file_name
			file_position := a_pos
			set_date
		ensure
			name_set: name = a_name
			external_name_set: external_name = an_external_name
			file_position_set: file_position = a_pos
		end

feature -- Access

	external_name: STRING
			-- Name of class as known in .NET
			
	assembly: ASSEMBLY_I
			-- Cluster is an assembly.
			
	external_consumed_type: CONSUMED_TYPE is
			-- Associated CONSUMED_TYPE instance of Current
		local
			l_reader: like consumed_type_deserializer
		do
			l_reader := consumed_type_deserializer
			l_reader.deserialize (file_name, file_position)
			Result ?= l_reader.deserialized_object
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

	classes_file_name: STRING is "classes.info"
			-- Directory from Assembly location where classes are located.

	file_position: INTEGER
			-- Position of class description in `file_name'

	consumed_type_deserializer: EIFFEL_DESERIALIZER is
			-- Deserializer engine
		once
			create Result
		ensure
			consumed_type_deserializer_not_void: Result /= Void
		end

invariant
	name_not_void: name /= Void
	external_name_not_void: external_name /= Void
	file_name_not_void: file_name /= Void
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EXTERNAL_CLASS_I
