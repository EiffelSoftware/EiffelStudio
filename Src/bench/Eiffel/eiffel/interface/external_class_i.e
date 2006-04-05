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
			group as assembly
		redefine
			is_external_class
		end

	CONF_CLASS_ASSEMBLY
		rename
			file_name as base_name,
			name as original_name,
			renamed_name as name,
			group as assembly,
			check_changed as set_date
		undefine
			is_compiled
		redefine
			assembly,
			class_type
		end

create {CONF_COMP_FACTORY}
	make_assembly_class

feature -- Access

	assembly: ASSEMBLY_I
			-- Cluster is an assembly.

	external_consumed_type: CONSUMED_TYPE is
			-- Associated CONSUMED_TYPE instance of Current
		local
			l_reader: like consumed_type_deserializer
		do
			l_reader := consumed_type_deserializer
			l_reader.deserialize (type_file, type_position)
			Result ?= l_reader.deserialized_object
		end

	config_class: CONF_CLASS_ASSEMBLY is
			-- Configuration class.
		do
			Result := Current
		end

feature -- Status Report

	is_external_class: BOOLEAN is True
			-- Class is defined outside current system.

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

	consumed_type_deserializer: EIFFEL_DESERIALIZER is
			-- Deserializer engine
		once
			create Result
		ensure
			consumed_type_deserializer_not_void: Result /= Void
		end

feature {NONE} -- Type anchor

	class_type: EXTERNAL_CLASS_I;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
