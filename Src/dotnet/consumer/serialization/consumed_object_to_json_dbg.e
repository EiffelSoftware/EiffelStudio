note
	description: "[
		JSON serialization of dotnet CONSUMED_... objects.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_OBJECT_TO_JSON_DBG

inherit
	CONSUMED_OBJECT_TO_JSON
		redefine
			consumed_assembly_to_json,
			consumed_assembly_types_to_json,
			consumed_type_to_json,
			consumed_referenced_type_to_json,
			consumed_property_to_json,
			consumed_field_to_json,
			consumed_event_to_json,
			consumed_constructor_to_json,
			consumed_procedure_to_json,
			consumed_function_to_json,
			consumed_argument_to_json
		end

create
	make

feature -- Settings

	is_debug: BOOLEAN
		do
			Result := not is_debug_disabled
		end

	is_debug_disabled: BOOLEAN

feature -- Visitors		

	consumed_assembly_to_json (a: CONSUMED_ASSEMBLY): JSON_OBJECT
		do
			Result := Precursor (a)
			if is_debug then
				check_same_object (a, Result)
			end
		end

	consumed_assembly_types_to_json (t: CONSUMED_ASSEMBLY_TYPES): JSON_OBJECT
		do
			Result := Precursor (t)
			if is_debug then
				check_same_object (t, Result)
			end
		end

	consumed_type_to_json (t: CONSUMED_TYPE): JSON_OBJECT
		do
			Result := Precursor (t)
			if is_debug then
				check_same_object (t, Result)
			end
		end

	consumed_referenced_type_to_json (t: CONSUMED_REFERENCED_TYPE): JSON_OBJECT
		do
			Result := Precursor (t)
			if is_debug then
				check_same_object (t, Result)
			end
		end

	consumed_property_to_json (p: CONSUMED_PROPERTY): JSON_OBJECT
		do
			Result := Precursor (p)
			if is_debug then
				check_same_object (p, Result)
			end
		end

	consumed_field_to_json (f: CONSUMED_FIELD): JSON_OBJECT
		do
			Result := Precursor (f)
			if is_debug then
				check_same_object (f, Result)
			end
		end

	consumed_event_to_json (e: CONSUMED_EVENT): JSON_OBJECT
		do
			Result := Precursor (e)
			if is_debug then
				check_same_object (e, Result)
			end
		end

	consumed_constructor_to_json (c: CONSUMED_CONSTRUCTOR): JSON_OBJECT
		do
			Result := Precursor (c)
			if is_debug then
				check_same_object (c, Result)
			end
		end

	consumed_procedure_to_json (p: CONSUMED_PROCEDURE): JSON_OBJECT
		do
			Result := Precursor (p)
			if is_debug then
				check_same_object (p, Result)
			end
		end

	consumed_function_to_json (f: CONSUMED_FUNCTION): JSON_OBJECT
		do
			Result := Precursor (f)
			if is_debug then
				check_same_object (f, Result)
			end
		end

	consumed_argument_to_json (a: CONSUMED_ARGUMENT): JSON_OBJECT
		do
			Result := Precursor (a)
			if is_debug then
				check_same_object (a, Result)
			end
		end

feature {NONE} -- Helpers		

	check_same_object (o1: ANY; jv2: JSON_VALUE)
		require
			is_debug
		local
			t: TYPE [detachable ANY]
			o2: detachable ANY
			s1, s2: STRING
			j1: JSON_OBJECT
			j2: JSON_VALUE
			f: RAW_FILE
			pretty: JSON_PRETTY_STRING_VISITOR
			s: STRING_8
		do
			t := o1.generating_type
			create j1.make_with_capacity (1)
			if o1 /= Void then
				j1.put (jv2, o1.generator)
			end
			o2 := (create {CONSUMED_OBJECT_FROM_JSON}.make).from_json (j1)

			if o2 = Void then
				if o1 /= Void then
					print (">> CHECK {"+ t.name +"} >> " )
					print ("False: "+ o1.generator +" /= Void%N")
					check same: False end
				end
			elseif o1 /= Void then
				is_debug_disabled := True
				j2 := to_json (o2)
				s2 := j2.representation
				s1 := j1.representation
				if not s1.same_string (s2) then
					print (">> CHECK {"+ t.name +"} >> " )
					print (o1.generator +" ? " + o2.generator)
					print (" => JSON mismatched (" + s1.count.out + " /= " + s2.count.out + ")%N")

					create f.make_create_read_write ("o1.json")
					create s.make (s2.count)
					create pretty.make (s)
					j1.accept (pretty)
					f.put_string (s)
					f.close

					create f.make_create_read_write ("o2.json")
					create s.make (s2.count)
					create pretty.make (s)
					j2.accept (pretty)
					f.put_string (s)
					f.close

					io.put_string (f.path.absolute_path.canonical_path.utf_8_name + "%N")
					io.put_string ("PRESS ENTER...")
					io.read_line
				end
				is_debug_disabled := False
			end
		end

end
