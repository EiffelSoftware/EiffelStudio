note
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
			is_external_class,
			set_changed,
			reset_options
		end

	CONF_CLASS_ASSEMBLY
		rename
			file_name as base_name,
			group as assembly,
			check_changed as set_date
		undefine
			is_compiled
		redefine
			assembly,
			class_type,
			options
		end

create {CONF_COMP_FACTORY}
	make_assembly_class

feature -- Access

	set_changed (b: BOOLEAN)
			-- Assign `b' to `changed'.
		do
			changed := b
		end

	options: CONF_OPTION
			-- <Precursor>
		do
			if options_internal /= Void then
				Result := options_internal
			else
				Result := Precursor
				if workbench.is_compiling then
					options_internal := Result
						-- We can cache the result as we know that it will be reset after compilation.
				end
			end
		end

	assembly: ASSEMBLY_I
			-- Cluster is an assembly.

	external_consumed_type: CONSUMED_TYPE
			-- Associated CONSUMED_TYPE instance of Current
		local
			l_reader: like consumed_type_deserializer
		do
			l_reader := consumed_type_deserializer
			if attached type_file as l_type_file and then (create {RAW_FILE}.make_with_name (l_type_file)).exists then
				l_reader.deserialize (l_type_file, type_position)
				if l_reader.successful then
					Result := {CONSUMED_TYPE} / l_reader.deserialized_object
				end
			end
		end

	config_class: CONF_CLASS_ASSEMBLY
			-- Configuration class.
		do
			Result := Current
		end

	type_from_consumed_type (c: CONSUMED_REFERENCED_TYPE): CLASS_I
			-- Given an external type `c' get its associated CLASS_I.
		require
			c_not_void: c /= Void
		local
			l_name: STRING
		do
			if attached {CONSUMED_ARRAY_TYPE} c then
				Result := System.native_array_class
			else
				if c.is_by_ref then
					Result := System.typed_pointer_class
				else
					l_name := c.name
							-- Case where this is a class from `mscorlib' that is in fact
							-- written as an Eiffel class, e.g. INTEGER, ....
					Result := basic_type_mapping.item (l_name)
					if Result = Void then
						Result := {CLASS_I} / assembly.class_by_dotnet_name (l_name, c.assembly_id)
						check has_result: Result /= Void end
					end
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	class_to_recompile: EXTERNAL_CLASS_C
		do
			create Result.make (Current)
		end

feature -- Status Report

	is_external_class: BOOLEAN = True
			-- Class is defined outside current system.

feature {EXTERNAL_CLASS_C} -- Mapping

	basic_type_mapping: HASH_TABLE [CLASS_I, STRING]
			-- Mapping between name of basic class in mscorlib and Eiffel CLASS_I.
		once
			create Result.make (20)
			Result.put (System.boolean_class, "System.Boolean")
			Result.put (System.character_8_class, "System.Char")
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

feature {COMPILER_EXPORTER} -- Setting

	reset_options
			-- <Precursor>
		do
				-- Reset any previous cached options.
			options_internal := Void
		end

feature {NONE} -- Implementation

	options_internal: like options
		-- Temporary store for internal options.

feature {NONE} -- Implementation

	consumed_type_deserializer: EIFFEL_DESERIALIZER
			-- Deserializer engine
		once
			-- FIXME: may be dangerous to use once here.
			Result := {EIFFEL_SERIALIZATION}.deserializer (system.clr_runtime_version)
		ensure
			consumed_type_deserializer_not_void: Result /= Void
		end

feature {NONE} -- Type anchor

	class_type: EXTERNAL_CLASS_I
			-- <Precursor>
		do
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EXTERNAL_CLASS_I
