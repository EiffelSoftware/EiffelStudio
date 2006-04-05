indexing
	description	: "Converts Eiffel specific data into dotnet data."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	CODE_TYPE_CONVERTER_EIFFEL_TO_DOTNET

inherit
	CODE_AST_HISTORIC
	
	CODE_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_SHARED_METADATA_ACCESS
		export
			{NONE} all
		end

feature -- Implementation

	Eiffel_base_types: HASH_TABLE [STRING, STRING] is
			-- Eiffel base types.
		once
			create Result.make (8)
			Result.put ("System.Byte", "INTEGER_8")
			Result.put ("System.Int16", "INTEGER_16")
			Result.put ("System.Int32", "INTEGER")
			Result.put ("System.Int64", "INTEGER_64")
			Result.put ("System.Real", "DOUBLE")
			Result.put ("System.Charater", "CHARACTER")
			Result.put ("System.Boolean", "BOOLEAN")
		end

	Known_eiffel_types: HASH_TABLE [STRING, STRING] is
			-- Eiffel base types.
		once
			create Result.make (40)
		end

	is_array_type (an_eiffel_type_name: STRING): BOOLEAN is
			-- Is `an_eiffel_type_name' array type?
		require
			non_void_an_eiffel_type_name: an_eiffel_type_name /= Void
			not_empty_an_eiffel_type_name: not an_eiffel_type_name.is_empty
		do
			if an_eiffel_type_name.has_substring ("NATIVE_ARRAY [") then
				Result := True
			end
		end

	dotnet_type_name (an_eiffel_type_name: STRING): STRING is
			-- Convert `an_eiffel_type_name' into its corresponding dotnet type name.
		require
			non_void_an_eiffel_type_name: an_eiffel_type_name /= Void
			not_empty_an_eiffel_type_name: not an_eiffel_type_name.is_empty
		local
			l_cat: CONSUMED_ASSEMBLY_TYPES
			l_counter: INTEGER
			l_eiffel_type_name: STRING
			l_referenced_assemblies: LIST [CODE_REFERENCED_ASSEMBLY]
			l_array_type: BOOLEAN
		do
			if Eiffel_base_types.has (an_eiffel_type_name) then
				Result := Eiffel_base_types.item (an_eiffel_type_name)
			elseif Known_eiffel_types.has (an_eiffel_type_name) then
				Result := Known_eiffel_types.item (an_eiffel_type_name)
			else
				if is_array_type (an_eiffel_type_name) then
					an_eiffel_type_name.remove_head (("NATIVE_ARRAY [").count)
					an_eiffel_type_name.keep_head (an_eiffel_type_name.count - 1)
					l_array_type := True
				end
				an_eiffel_type_name.to_upper

				l_referenced_assemblies := (create {CODE_SHARED_REFERENCED_ASSEMBLIES}).Referenced_assemblies
				from
					l_referenced_assemblies.start
				until
					l_referenced_assemblies.after or Result /= Void
				loop
			--		l_cat := l_cache_reflection.assembly_types (l_referenced_assemblies.item.assembly.get_name)
					if l_cat /= Void then
						from
							l_counter := 1
						until
							l_counter > l_cat.eiffel_names.count or Result /= Void
						loop
							if l_cat.eiffel_names.item (l_counter) /= Void then
								create l_eiffel_type_name.make_from_string (l_cat.eiffel_names.item (l_counter))
								l_eiffel_type_name.prepend (l_referenced_assemblies.item.assembly_prefix)
								l_eiffel_type_name.to_upper
								if l_eiffel_type_name.is_equal (an_eiffel_type_name) then
									Result := l_cat.dotnet_names.item (l_counter)
								end
							end
							l_counter := l_counter + 1
						end
						l_referenced_assemblies.forth
					else
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_consumed_assembly, [l_referenced_assemblies.item.assembly.get_name])
					end
				end

				if l_array_type then
					Result.append ("[]")
				end
				
				if Result = Void then
					-- We must have a user .Net type therefore we return its Eiffel Name as its .Net name
					Result := an_eiffel_type_name
				end

				Known_eiffel_types.put (Result, an_eiffel_type_name)
			end
		ensure
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end

	dotnet_type (an_attribute: STRING): STRING is
			-- dotnet type associated to a name.
		require
			non_void_an_attribute: an_attribute /= Void
			not_empty_an_attribute: not an_attribute.is_empty
			is_attribute_or_variable: is_attribute (an_attribute) or is_variable (an_attribute)
		local
			l_attribute: STRING
		do
			l_attribute := an_attribute.as_lower
			if Type_attributes.has (l_attribute) then
				Result := Type_attributes.item (l_attribute)
			elseif Variables.has (an_attribute) then
				Result := Variables.item (l_attribute)
			end
		ensure
			non_void_dotnet_type: Result /= Void
		end

	dotnet_type_expression (an_expression: SYSTEM_DLL_CODE_EXPRESSION): STRING is
			-- 
		local
			l_attribute: SYSTEM_DLL_CODE_FIELD_REFERENCE_EXPRESSION
			l_attribute_name: STRING
			l_property_ref_exp: SYSTEM_DLL_CODE_PROPERTY_REFERENCE_EXPRESSION
			l_variable_ref_exp: SYSTEM_DLL_CODE_VARIABLE_REFERENCE_EXPRESSION
			l_method_name: STRING
			l_this_ref_exp: SYSTEM_DLL_CODE_THIS_REFERENCE_EXPRESSION
			l_ct: CONSUMED_TYPE
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_counter: INTEGER
		do
			l_attribute ?= an_expression
			if l_attribute /= Void then
				create l_attribute_name.make_from_cil (l_attribute.field_name)
				Result := dotnet_type (l_attribute_name)
				if Result.item (Result.count - 1).is_equal ('[') and then Result.item (Result.count).is_equal (']') then
					Result.remove_tail (2)					
				end
			else
				l_variable_ref_exp ?= an_expression
				if l_variable_ref_exp /= Void then
					Result := Variables.item (l_variable_ref_exp.variable_name)
					check
						Result_not_void: Result /= Void	
					end
				end
				l_property_ref_exp ?= an_expression
				if l_property_ref_exp /= Void then
					l_attribute ?= l_property_ref_exp.target_object
					if l_attribute /= Void then
						create l_attribute_name.make_from_cil (l_attribute.field_name)
						--Result := dotnet_type (l_attribute_name)
						l_ct := consumed_type (dotnet_type (l_attribute_name))
						create l_method_name.make_from_cil (l_property_ref_exp.property_name)
						l_properties := l_ct.properties
						from
							l_counter := 1
						until
							l_counter > l_properties.count
						loop
							if
								l_properties.item (l_counter).getter /= Void and then 
								l_properties.item (l_counter).getter.dotnet_name.is_equal (l_method_name)
							then
								Result := l_properties.item (l_counter).getter.return_type.name
							end
							l_counter := l_counter + 1
						end
					else
						l_variable_ref_exp ?= an_expression
						if l_variable_ref_exp /= Void then
							Result := Variables.item (l_variable_ref_exp.variable_name)
							check
								Result_not_void: Result /= Void	
							end
						else
							Result := Parent
						end
					end
				end
				
					-- If the expression type is 'This' then we return the type of the parent.
				l_this_ref_exp ?= an_expression
				if l_this_ref_exp /= Void then
					Result := parent
				end
			end
		end

	dotnet_feature_name (an_eiffel_feature_name: STRING; dotnet_type_target_feature: STRING): STRING is
			-- Retrieve the `dotnet_feature_name' associated to `an_eiffel_feature_name'.
		require
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
			not_empty_an_eiffel_feature_name: not an_eiffel_feature_name.is_empty
			non_void_type_target: dotnet_type_target_feature /= Void
			not_empty_type_target: not dotnet_type_target_feature.is_empty
		local
			l_counter_2: INTEGER
			l_ct: CONSUMED_TYPE
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_events: ARRAY [CONSUMED_EVENT]
			l_fields: ARRAY [CONSUMED_FIELD]
			l_procedures: ARRAY [CONSUMED_PROCEDURE]
			l_functions: ARRAY [CONSUMED_FUNCTION]
			l_eiffel_feature_name: STRING
		do
			l_eiffel_feature_name := an_eiffel_feature_name.as_lower
			l_ct := consumed_type (dotnet_type_target_feature)
			l_properties := l_ct.properties
			from
				l_counter_2 := 1
			until
				l_counter_2 > l_properties.count or Result /= Void
			loop
				if l_properties.item (l_counter_2).getter /= Void then
					if l_properties.item (l_counter_2).getter.eiffel_name.is_equal (l_eiffel_feature_name) then
						Result := l_properties.item (l_counter_2).dotnet_name
					end
				end
				if l_properties.item (l_counter_2).setter /= Void then
					if l_properties.item (l_counter_2).setter.eiffel_name.is_equal (l_eiffel_feature_name) then
						Result := l_properties.item (l_counter_2).dotnet_name
					end
				end
				l_counter_2 := l_counter_2 + 1
			end

			l_events := l_ct.events
			from
				l_counter_2 := 1
			until
				l_counter_2 > l_events.count or Result /= Void
			loop
				if l_events.item (l_counter_2).adder /= Void then
					if l_events.item (l_counter_2).adder.eiffel_name.is_equal (l_eiffel_feature_name) then
						Result := l_events.item (l_counter_2).dotnet_name
					end
				end
				l_counter_2 := l_counter_2 + 1
			end

			l_fields := l_ct.fields
			from
				l_counter_2 := 1
			until
				l_counter_2 > l_fields.count or Result /= Void
			loop
				if l_fields.item (l_counter_2) /= Void then
					if l_fields.item (l_counter_2).eiffel_name.is_equal (l_eiffel_feature_name) then
						Result := l_fields.item (l_counter_2).dotnet_name
					end
				end
				l_counter_2 := l_counter_2 + 1
			end

			l_functions := l_ct.functions
			from
				l_counter_2 := 1
			until
				l_counter_2 > l_functions.count or Result /= Void
			loop
				if l_functions.item (l_counter_2) /= Void then
					if l_functions.item (l_counter_2).eiffel_name.is_equal (l_eiffel_feature_name) then
						Result := l_functions.item (l_counter_2).dotnet_name
					end
				end
				l_counter_2 := l_counter_2 + 1
			end

			l_procedures := l_ct.procedures
			from
				l_counter_2 := 1
			until
				l_counter_2 > l_procedures.count or Result /= Void
			loop
				if l_procedures.item (l_counter_2) /= Void then
					if l_procedures.item (l_counter_2).eiffel_name.is_equal (l_eiffel_feature_name) then
						Result := l_procedures.item (l_counter_2).dotnet_name
					end
				end
				l_counter_2 := l_counter_2 + 1
			end

			if Result = Void then
				Result := an_eiffel_feature_name
			end
		ensure
			non_void_dotnet_feature_name : Result /= Void
			not_empty_dotnet_feature_name: not Result.is_empty
		end

	consumed_type (a_dotnet_type_name: STRING): CONSUMED_TYPE is
			-- Retrieve consumed_type associated to `a_dotnet_type_name'.
		require
			valid_a_dotnet_type_name: a_dotnet_type_name /= Void and then not a_dotnet_type_name.is_empty
		local
			l_ca: ARRAY [CONSUMED_ASSEMBLY]
			l_counter: INTEGER
		do
			cache_reflection.Types_cache.search (a_dotnet_type_name)
			if cache_reflection.Types_cache.found_item /= Void then
				Result ?= cache_reflection.Types_cache.found_item
			else		
				l_ca := cache_reflection.consumed_assemblies
				from
					l_counter := 1
				until
					l_counter > l_ca.count or Result /= Void
				loop
					Result := consumed_type_from_dotnet_type_name (l_ca.item (l_counter), a_dotnet_type_name)
					l_counter := l_counter + 1
				end
				
				check
					Type_found: Result /= Void
				end
				cache_reflection.Types_cache.put (Result, a_dotnet_type_name)			
			end
		ensure
			non_void_consumed_type: Result /= Void
		end

	consumed_type_from_dotnet_type_name (ca: CONSUMED_ASSEMBLY; dotnet_type_target_feature: STRING): CONSUMED_TYPE is
			-- 
		do
			Result := cache_reflection.consumed_type_from_dotnet_type_name (ca, dotnet_type_target_feature)
		end

feature -- Status Setting

	is_property_setter (an_eiffel_name: STRING; a_dotnet_type_name: STRING): BOOLEAN is
			-- Is `an_eiffel_name' name of an property setter member?
		require
			valid_eiffel_name: an_eiffel_name /= Void and then not an_eiffel_name.is_empty
			valid_a_dotnet_type_name: a_dotnet_type_name /= Void and then not a_dotnet_type_name.is_empty
		local
			l_ct: CONSUMED_TYPE
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_counter: INTEGER
			l_eiffel_name: STRING
		do
			l_ct := consumed_type (a_dotnet_type_name)
			l_properties := l_ct.properties
			l_eiffel_name := an_eiffel_name.as_lower
			from
				l_counter := 1
			until
				l_counter > l_properties.count or Result
			loop
				if 
					l_properties.item (l_counter).setter /= Void and then 
					l_properties.item (l_counter).setter.eiffel_name.is_equal (l_eiffel_name)
				then
					Result := True
				end
				l_counter := l_counter + 1
			end
		end

	is_property_getter (an_eiffel_name: STRING; a_dotnet_type_name: STRING): BOOLEAN is
			-- Is `an_eiffel_name' name of a property setter member?
		require
			valid_eiffel_name: an_eiffel_name /= Void and then not an_eiffel_name.is_empty
			valid_a_dotnet_type_name: a_dotnet_type_name /= Void and then not a_dotnet_type_name.is_empty
		local
			l_ct: CONSUMED_TYPE
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_counter: INTEGER
			l_eiffel_name: STRING
		do
			l_eiffel_name := an_eiffel_name.as_lower
			l_ct := consumed_type (a_dotnet_type_name)
			l_properties := l_ct.properties
			from
				l_counter := 1
			until
				l_counter > l_properties.count or Result
			loop
				if 
					l_properties.item (l_counter).getter /= Void and then 
					l_properties.item (l_counter).getter.eiffel_name.is_equal (l_eiffel_name)
				then
					Result := True
				end
				l_counter := l_counter + 1
			end
		end

	is_event_adder (an_eiffel_name: STRING; a_dotnet_type_name: STRING): BOOLEAN is
			-- Is `an_eiffel_name' name of an event adder member?
		require
			valid_eiffel_name: an_eiffel_name /= Void and then not an_eiffel_name.is_empty
			valid_a_dotnet_type_name: a_dotnet_type_name /= Void and then not a_dotnet_type_name.is_empty
		local
			l_ct: CONSUMED_TYPE
			l_events: ARRAY [CONSUMED_EVENT]
			l_counter: INTEGER
			l_eiffel_name: STRING
		do
			l_eiffel_name := an_eiffel_name.as_lower
			l_ct := consumed_type (a_dotnet_type_name)
			l_events := l_ct.events
			from
				l_counter := 1
			until
				l_counter > l_events.count or Result
			loop
				if 
					l_events.item (l_counter).adder /= Void and then 
					l_events.item (l_counter).adder.eiffel_name.is_equal (l_eiffel_name)
				then
					Result := True
				end
				l_counter := l_counter + 1
			end
		end
		
	is_field (an_eiffel_name: STRING; a_dotnet_type_name: STRING): BOOLEAN is
			-- Is `an_eiffel_name' name of field?
		require
			valid_eiffel_name: an_eiffel_name /= Void and then not an_eiffel_name.is_empty
			valid_a_dotnet_type_name: a_dotnet_type_name /= Void and then not a_dotnet_type_name.is_empty
		local
			l_ct: CONSUMED_TYPE
			l_fields: ARRAY [CONSUMED_FIELD]
			l_counter: INTEGER
			l_eiffel_name: STRING
		do
			l_eiffel_name := an_eiffel_name.as_lower
			l_ct := consumed_type (a_dotnet_type_name)
			l_fields := l_ct.fields
			from
				l_counter := 1
			until
				l_counter > l_fields.count or Result
			loop
				if 
					l_fields.item (l_counter).eiffel_name /= Void and then 
					l_fields.item (l_counter).eiffel_name.is_equal (l_eiffel_name)
				then
					Result := True
				end
				l_counter := l_counter + 1
			end
		end

	is_constructor (an_eiffel_name: STRING): BOOLEAN is
			-- Is `an_eiffel_name' constructor of current class?
		require
			valid_eiffel_name: an_eiffel_name /= Void and then not an_eiffel_name.is_empty
		local
			l_eiffel_name: STRING
		do
			l_eiffel_name := an_eiffel_name.as_lower
			from
				Constructors.start
			until
				Constructors.after or Result
			loop
				if Constructors.item.is_equal (l_eiffel_name) then
					Result := True
				end
				Constructors.forth
			end
		end

feature {NONE} -- HACK

	Parent: STRING is "System.Windows.Forms.Form"
			-- I suppose that parent is a Form.

feature {NONE} -- Implementation - Cache

	Constructors: LINKED_LIST [STRING] is
			-- List of constructors.
		once
			create Result.make
		ensure
			non_void_constructors: Result /= Void
		end

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
end -- Class CODE_TYPE_CONVERTER_EIFFEL_TO_DOTNET