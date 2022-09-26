note
	description: "[
		JSON serialization of dotnet CONSUMED_... objects.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_OBJECT_TO_JSON

create
	make,
	make_short

feature {NONE} -- Initialization

	make
		do
			create names
		end

	make_short
		do
			use_shortname := True
			create {CONSUMED_OBJECT_JSON_SHORT_NAMES} names
		end

feature -- Settings

	names: CONSUMED_OBJECT_JSON_NAMES

	use_shortname: BOOLEAN

feature -- Settings change

	set_use_shortname (b: BOOLEAN)
		do
			use_shortname := b
		end

feature -- Visitor

	to_json (obj: ANY): JSON_VALUE
		local
			jresult: JSON_VALUE
			jobj: JSON_OBJECT
		do

			if attached {CONSUMED_TYPE} obj as t then
				jresult := consumed_type_to_json (t)
			elseif attached {CONSUMED_ASSEMBLY_TYPES} obj as l_ass_types then
				jresult := consumed_assembly_types_to_json (l_ass_types)
			elseif attached {CONSUMED_ASSEMBLY_MAPPING} obj as l_ass_mapping then
				create jobj.make_with_capacity (1)
				jobj.put (consumed_assemblies_to_json_array (l_ass_mapping.assemblies), names.assemblies)
				jresult := jobj
			elseif attached {CACHE_INFO} obj as ci then
				create jobj.make_with_capacity (1)
				jobj.put (consumed_assemblies_to_json_array (ci.assemblies), names.assemblies)
				jresult := jobj
			elseif obj.generator.same_string ("CACHE_READER") then
				create jobj.make_with_capacity (1)
				jobj.put (Void, "CACHE_READER")
				jresult := jobj
			else
				print ("To-JSON: FIXME ")
				print (obj.generator)
				print ("%N")
			end
			if jresult = Void then
				create {JSON_NULL} Result
			else
				create jobj.make_with_capacity (1)
				jobj.put (jresult, obj.generator)
				Result := jobj
			end
		end

feature -- Visitors		

	consumed_assemblies_to_json_array (lst: LIST [CONSUMED_ASSEMBLY]): JSON_ARRAY
		do
			create Result.make (lst.count)
			across
				lst as a
			loop
				Result.extend (consumed_assembly_to_json (a))
			end
		end

	consumed_assembly_to_json (a: CONSUMED_ASSEMBLY): JSON_OBJECT
		do
			create Result.make_with_capacity (10)
			Result.put_string (a.unique_id, names.unique_id)
			Result.put_string (a.folder_name, names.folder_name)
			Result.put_string (a.name, names.name)
			Result.put_string (a.version, names.version)
			Result.put_string (a.culture, names.culture)
			Result.put_string (a.key, names.key)
			Result.put_string (a.location.name, names.location)
			Result.put_string (a.gac_path.name, names.gac_path)
			Result.put_boolean (a.is_consumed, names.is_consumed)
			Result.put_boolean (a.is_in_gac, names.is_in_gac)
			Result.put_boolean (a.has_info_only, names.has_info_only)

--			Result.put_boolean (a.text, names.text)
		end

	consumed_assembly_types_to_json (t: CONSUMED_ASSEMBLY_TYPES): JSON_OBJECT
		local
			jarr: JSON_ARRAY
			s: READABLE_STRING_GENERAL
			i: INTEGER
		do
			create Result.make_with_capacity (5)
			Result.put_integer (t.count, names.count)
			create jarr.make_empty
			across
				t.eiffel_names as n
			loop
				s := n
				if s = Void then
					jarr.extend (create {JSON_NULL})
				else
					jarr.extend (create {JSON_STRING}.make_from_string_general (s))
				end
			end
			Result.put (jarr, names.eiffel_names)

			create jarr.make_empty
			across
				t.dotnet_names as n
			loop
				s := n
				if s = Void then
					jarr.extend (create {JSON_NULL})
				else
					jarr.extend (create {JSON_STRING}.make_from_string_general (s))
				end
			end
			Result.put (jarr, names.dotnet_names)

			create jarr.make_empty
			across
				t.flags as f
			loop
				jarr.extend (create {JSON_NUMBER}.make_integer (f))
			end
			Result.put (jarr, names.flags)

			create jarr.make_empty
			print (" position:")
			i := -1
			across
				t.positions as p
			loop
				if p = 0 and i /= 0 then
					print (" " + p.out)
				end
				i := p
				jarr.extend (create {JSON_NUMBER}.make_integer (p))
			end
			print ("%N")
			Result.put (jarr, names.positions)
		end

	consumed_type_to_json (t: CONSUMED_TYPE): JSON_OBJECT
		local
			j: JSON_OBJECT
			jarr: JSON_ARRAY
		do
			create j.make
			j.put_string (t.eiffel_name, names.eiffel_name)
			if t.eiffel_name.is_case_insensitive_equal_general ("RT_TYPE") then
				print ("EMDC RT_TYPE%N")
				do_nothing
			end
			if t.dotnet_name.is_case_insensitive_equal_general ("RT_BASIC_TYPE") then
				print ("EMDC RT_BASIC_TYPE%N")
				do_nothing
			end
			j.put_string (t.dotnet_name, names.dotnet_name)
			if t.is_interface then
				j.put_boolean (t.is_interface, names.is_interface)
			end
			if t.is_deferred then
				j.put_boolean (t.is_deferred, names.is_deferred)
			end
			if t.is_frozen then
				j.put_boolean (t.is_frozen, names.is_frozen)
			end
			if t.is_expanded then
				j.put_boolean (t.is_expanded, names.is_expanded)
			end
			if t.is_enum then
				j.put_boolean (t.is_enum, names.is_enum)
			end

			if attached t.parent as p then
				if p.name.same_string (t.dotnet_name) then
					print ("To-JSON: parent same as current: " + t.dotnet_name + "%N")
				else
					j.put (consumed_referenced_type_to_json (p), names.parent)
				end
			end
			if attached t.interfaces as l_interfaces and then not l_interfaces.is_empty then
				create jarr.make (l_interfaces.count)
				across
					l_interfaces as i
				loop
					jarr.extend (consumed_referenced_type_to_json (i))
				end
				j.put (jarr, names.interfaces)
			end

			if attached t.properties as l_properties and then not l_properties.is_empty then
				create jarr.make (l_properties.count)
				across
					l_properties as p
				loop
					jarr.extend (consumed_property_to_json (p))
				end
				j.put (jarr, names.properties)
			end
			if attached t.constructors as l_constructors and then not l_constructors.is_empty then
				create jarr.make (l_constructors.count)
				across
					l_constructors as c
				loop
					jarr.extend (consumed_constructor_to_json (c))
				end
				j.put (jarr, names.constructors)
			end
			if attached t.functions as l_functions and then not l_functions.is_empty then
				create jarr.make (l_functions.count)
				across
					l_functions as f
				loop
					jarr.extend (consumed_function_to_json (f))
				end
				j.put (jarr, names.functions)
			end
			if attached t.procedures as l_procedures and then not l_procedures.is_empty then
				create jarr.make (l_procedures.count)
				across
					l_procedures as p
				loop
					jarr.extend (consumed_procedure_to_json (p))
				end
				j.put (jarr, names.procedures)
			end
			if attached t.fields as l_fields and then not l_fields.is_empty then
				create jarr.make (l_fields.count)
				across
					l_fields as f
				loop
					jarr.extend (consumed_field_to_json (f))
				end
				j.put (jarr, names.fields)
			end
			if attached t.events as l_events and then not l_events.is_empty then
				create jarr.make (l_events.count)
				across
					l_events as e
				loop
					jarr.extend (consumed_event_to_json (e))
				end
				j.put (jarr, names.events)
			end

			if attached t.associated_reference_type as l_ass_type then
				j.put (consumed_referenced_type_to_json (l_ass_type), names.associated_reference_type)
			end

--			internal_flags: INTEGER_32

			if attached {CONSUMED_NESTED_TYPE} t as nt then
				j.put (consumed_referenced_type_to_json (nt.enclosing_type), names.enclosing_type)
			end

			Result := j
		end

	consumed_referenced_type_to_json (t: CONSUMED_REFERENCED_TYPE): JSON_OBJECT
		local
			j: JSON_OBJECT
		do
			create j.make
			j.put_string (t.name, names.name)
			j.put_integer (t.assembly_id, names.assembly_id)
			if attached {CONSUMED_ARRAY_TYPE} t as at then
				j.put (consumed_referenced_type_to_json (at.element_type), names.element_type)
			end
			Result := j
		end

	consumed_property_to_json (p: CONSUMED_PROPERTY): JSON_OBJECT
		local
			j: JSON_OBJECT
		do
			j := consumed_entity_to_json (p)
			if attached p.getter as g then
				j.put (consumed_function_to_json (g), names.getter)
			end
			if attached p.setter as s then
				j.put (consumed_procedure_to_json (s), names.setter)
			end
			Result := j
		end

	consumed_field_to_json (f: CONSUMED_FIELD): JSON_OBJECT
		local
			j: JSON_OBJECT
		do
			j := consumed_member_to_json (f)
			if attached f.setter as s then
				j.put (consumed_procedure_to_json (s), names.setter)
			end
			if attached {CONSUMED_LITERAL_FIELD} f as lf then
				j.put_string (lf.value, names.value)
			end
			Result := j
		end

	consumed_event_to_json (e: CONSUMED_EVENT): JSON_OBJECT
		local
			j: JSON_OBJECT
		do
			j := consumed_entity_to_json (e)
			if attached e.adder as a then
				j.put (consumed_procedure_to_json (a), names.adder)
			end
			if attached e.remover as r then
				j.put (consumed_procedure_to_json (r), names.remover)
			end
			if attached e.raiser as r then
				j.put (consumed_procedure_to_json (r), names.raiser)
			end
			Result := j
		end

	consumed_constructor_to_json (c: CONSUMED_CONSTRUCTOR): JSON_OBJECT
		local
			j: JSON_OBJECT
			jarr: JSON_ARRAY
		do
			j := consumed_entity_to_json (c)
			if attached c.arguments as args and then not args.is_empty then
				create jarr.make (args.count)
				across
					args as a
				loop
					jarr.extend (consumed_argument_to_json (a))
				end
				j.put (jarr, names.arguments)
			end
			Result := j
		end

	consumed_entity_to_json (e: CONSUMED_ENTITY): JSON_OBJECT
		local
			j: JSON_OBJECT
			jarr: JSON_ARRAY
		do
			create j.make_with_capacity (10)
			j.put_string (e.eiffel_name, names.eiffel_name)
			j.put_string (e.dotnet_eiffel_name, names.dotnet_eiffel_name)
			j.put_string (e.dotnet_name, names.dotnet_name)

			j.put (consumed_referenced_type_to_json (e.declared_type), names.declared_type)
			if attached e.return_type as rt then
				j.put (consumed_referenced_type_to_json (rt), names.return_type)
			end
			if attached e.arguments as args and then not args.is_empty then
				create jarr.make (args.count)
				across
					args as a
				loop
					jarr.extend (consumed_argument_to_json (a))
				end
				j.put (jarr, names.arguments)
			end

			if e.is_frozen then
				j.put_boolean (e.is_frozen, names.is_frozen)
			end
			if e.is_public then
				j.put_boolean (e.is_public, names.is_public)
			end
			if e.is_static then
				j.put_boolean (e.is_static, names.is_static)
			end
			if e.is_literal then
				j.put_boolean (e.is_literal, names.is_literal)
			end
			if e.is_init_only then
				j.put_boolean (e.is_init_only, names.is_init_only)
			end
			if e.is_artificially_added then
				j.put_boolean (e.is_artificially_added, names.is_artificially_added)
			end
			if e.is_property_or_event then
				j.put_boolean (e.is_property_or_event, names.is_property_or_event)
			end
			if e.is_new_slot then
				j.put_boolean (e.is_new_slot, names.is_new_slot)
			end
			if e.is_virtual then
				j.put_boolean (e.is_virtual, names.is_virtual)
			end
			if e.is_infix then
				j.put_boolean (e.is_infix, names.is_infix)
			end
			if e.is_prefix then
				j.put_boolean (e.is_prefix, names.is_prefix)
			end
			if e.is_constructor then
				j.put_boolean (e.is_constructor, names.is_constructor)
			end
			-- ... see {CONSUMED_ENTITY}
			Result := j
		end

	consumed_member_to_json (m: CONSUMED_MEMBER): JSON_OBJECT
		do
			Result := consumed_entity_to_json (m)
		end

	consumed_procedure_to_json (p: CONSUMED_PROCEDURE): JSON_OBJECT
		do
			Result := consumed_entity_to_json (p)
			if p.is_attribute_setter then
				Result.put_boolean (p.is_attribute_setter, names.is_attribute_setter)
			end
		end

	consumed_function_to_json (f: CONSUMED_FUNCTION): JSON_OBJECT
		do
			Result := consumed_procedure_to_json (f)
		end

	consumed_argument_to_json (a: CONSUMED_ARGUMENT): JSON_OBJECT
		local
			j: JSON_OBJECT
		do
			create j.make_with_capacity (3)
			j.put_string (a.eiffel_name, names.eiffel_name)
			j.put_string (a.dotnet_name, names.dotnet_name)
			j.put (consumed_referenced_type_to_json (a.type), names.type)
			Result := j
		end


end
