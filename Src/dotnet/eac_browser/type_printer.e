indexing
	description: "Print in output the eiffel type with all its eiffelfeatures corresponding to given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_PRINTER

inherit
	CACHE_PATH
	CACHE

create
	make

feature {NONE} -- Initialization

	make (an_output: EV_TEXT) is
			-- Initialiaze `output' with `an_output'.
		require
			non_void_an_output: an_output /= Void
		do
			output := an_output
		ensure
			output_set: output = an_output
		end

feature -- Access

	output: EV_TEXT
			-- output to print type.
			
	assembly_of_type: CONSUMED_ASSEMBLY
			-- assembly where is located `dotnet_type_name'.
			
	dotnet_type_name: STRING
			-- dotnet type name to print.
			
feature -- Basic Operations

	print_type (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_dotnet_type_name'
			-- Print in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
		do
			assembly_of_type := assembly_of_dotnet_type
			dotnet_type_name := a_dotnet_type_name
			internal_print_type
		ensure
			not_empty_output: not output.text.is_empty
		end

feature {NONE} -- Implementation

	internal_print_type is
			-- Print in `output' features corresponding to `dotnet_type_name'.
		local
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
			a_file_name: STRING
		do
			output.remove_text
			create eac
			a_file_name := absolute_type_path (relative_assembly_path (assembly_of_type), dotnet_type_name)
			ct := eac.consumed_type (a_file_name)
			if ct /= Void then
				output.append_text (ct.eiffel_name + "%N" + "%N")
				output.append_text (print_constructors (ct.constructors))
				output.append_text (print_attributes (ct.fields))
				output.append_text (print_procedures (ct.procedures))
				output.append_text (print_functions (ct.functions))
			end
		end

	print_procedures (array: ARRAY [CONSUMED_MEMBER]): STRING is
			-- Print in `output' procedures contained in `array'.
		local
			i, j: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
--			Result: STRING
--			procedures: SORTABLE_ARRAY [STRING]
		do
			create Result.make (50000)
			
			----Result.set_foreground_color (title_color)
			Result.append ("Procedure(s) :")
			Result.append ("%N")
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
				Result.append ("%T")
				Result.append (array.item (i).eiffel_name)
				from
					j := 1
				until
					array.item (i).arguments = Void
					or else j > array.item (i).arguments.count 
				loop
					if j = 1 then
						Result.append (" (")
					else
						Result.append (", ")
					end
					Result.append (array.item (i).arguments.item (j).eiffel_name + ": ")

					l_argument := array.item (i).arguments.item (j).type
					l_array_argument := Void
					l_array_argument ?= l_argument
						-- Is type argument NATIVE_ARRAY?
					if l_array_argument /= Void then
						Result.append ("NATIVE_ARRAY [" + eiffel_type_name (l_array_argument.element_type_name) + "]")
					else
						Result.append (eiffel_type_name (l_argument.name))
					end
					j := j + 1
				end
				if j /= 1 then
					Result.append (")")
				end
				Result.append ("%N")

				i := i + 1
			end
			Result.append ("%N")
		end

	print_constructors (array: ARRAY [CONSUMED_CONSTRUCTOR]): STRING is
			--  Print in `output' constructors contained in `array'.
		local
			i, j: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
		do
			create Result.make (25000)
			
			--Result.set_foreground_color (title_color)
			Result.append ("Creation routine(s) :")
			Result.append ("%N")
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
				Result.append ("%T")
				Result.append (array.item (i).eiffel_name)
				from
					j := 1
				until
					array.item (i).arguments = Void
					or else j > array.item (i).arguments.count 
				loop
					if j = 1 then
						Result.append (" (")
					else
						Result.append (", ")
					end
					Result.append (array.item (i).arguments.item (j).eiffel_name + ": ")					

					l_argument := array.item (i).arguments.item (j).type
					l_array_argument := Void
					l_array_argument ?= l_argument
						-- Is type argument NATIVE_ARRAY?
					if l_array_argument /= Void then
						Result.append ("NATIVE_ARRAY [" + eiffel_type_name (l_array_argument.element_type_name) + "]")
					else
						Result.append (eiffel_type_name (l_argument.name))
					end
					j := j + 1
				end
				if j /= 1 then
					Result.append (")")
				end
				Result.append ("%N")

				i := i + 1
			end
			Result.append ("%N")
		end

	print_functions (array: ARRAY [CONSUMED_FUNCTION]): STRING is
			--  Print in `output' functions contained in `array'.
		local
			i, j: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
		do
			create Result.make (50000)
			
			--Result.set_foreground_color (title_color)
			Result.append ("Function(s) :")
			Result.append ("%N")
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
				Result.append ("%T")
				Result.append (array.item (i).eiffel_name)
				from
					j := 1
				until
					array.item (i).arguments = Void
					or else j > array.item (i).arguments.count 
				loop
					if j = 1 then
						Result.append (" (")
					else
						Result.append (", ")
					end
					Result.append (array.item (i).arguments.item (j).eiffel_name + ": ")					

					l_argument := array.item (i).arguments.item (j).type
					l_array_argument := Void
					l_array_argument ?= l_argument
					if l_array_argument /= Void then
						Result.append ("NATIVE_ARRAY [" + eiffel_type_name (l_array_argument.element_type_name) + "]")
					else
						Result.append (eiffel_type_name (l_argument.name))
					end
					
					j := j + 1
				end
				if j /= 1 then
					Result.append (")")
				end
				l_returned_type := array.item (i).return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					Result.append (": NATIVE_ARRAY [" + eiffel_type_name (l_array_returned_type.element_type_name) + "]")
				else
					Result.append (": " + eiffel_type_name (l_returned_type.name))
				end
				Result.append ("%N")

				i := i + 1
			end
			Result.append ("%N")
		end

	print_attributes (array: ARRAY [CONSUMED_FIELD]): STRING is
			--  Print in `output' attributes contained in `array'.
		local
			i: INTEGER
			l_field: CONSUMED_REFERENCED_TYPE
			l_array_field: CONSUMED_ARRAY_TYPE
			l_literal_field: CONSUMED_LITERAL_FIELD
			l_type_attribute_name: STRING
		do
			create Result.make (20000)
			
			--Result.set_foreground_color (title_color)
			Result.append ("Attribute(s) :")
			Result.append ("%N")
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
				Result.append ("%T")
				Result.append (array.item (i).eiffel_name)
				Result.append (": ")
				l_field := array.item (i).return_type
				l_array_field := Void
				l_array_field ?= l_field
					-- Is it a NATIVE_ARRAY?
				if l_array_field /= Void then
					l_type_attribute_name := l_field.name
					l_type_attribute_name.keep_head (l_type_attribute_name.count - 2)
					Result.append (" NATIVE_ARRAY [" + eiffel_type_name (l_type_attribute_name) + "]")
				else
					Result.append (eiffel_type_name (l_field.name))
				end
				if array.item (i).is_literal then
					l_literal_field ?= array.item (i)
					Result.append ( " is " + l_literal_field.value)
				end
				Result.append ("%N")

				i := i + 1
			end
			Result.append ("%N")
		end

	eiffel_type_name (a_dotnet_type_name: STRING): STRING is
			-- Return the `eiffel_type_name' corresponding to `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		do
			if types.has (a_dotnet_type_name) then
				Result := types.item (a_dotnet_type_name)
			else
				Result := search_eiffel_type_name (a_dotnet_type_name)
			end
		ensure
			non_void_result: Result /= Void
		end
	
	search_eiffel_type_name (a_dotnet_type_name: STRING): STRING is
			-- Return the `eiffel_type_name' corresponding to `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		local
			i, j: INTEGER
			eac: EAC_BROWSER
			l_file_name: STRING
			l_assembly_file_name: STRING
			referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
			cat: CONSUMED_ASSEMBLY_TYPES
			l_dotnet_type_name: STRING
		do
			create eac
			l_file_name := absolute_referenced_assemblies_path (assembly_of_type)
			referenced_assemblies := eac.referenced_assemblies (l_file_name)
			from
				i := 1
			until
				referenced_assemblies = Void
				or else
				i > referenced_assemblies.assemblies.count --or Result /= Void
			loop
--				create ca.make (referenced_assemblies.assemblies.item (i).name, referenced_assemblies.assemblies.item (i).version, referenced_assemblies.assemblies.item (i).culture, referenced_assemblies.assemblies.item (i).key)
--				l_assembly_file_name := absolute_referenced_assemblies_path (ca)

				l_assembly_file_name := absolute_info_assembly_path (referenced_assemblies.assemblies.item (i)) 
				cat := eac.consumed_assembly (l_assembly_file_name)
				from
					j := 1
				until
					cat = Void
					or else
					j > cat.dotnet_names.count --or Result /= Void
				loop
					l_dotnet_type_name := cat.dotnet_names.item (j)
					if l_dotnet_type_name /= Void and then l_dotnet_type_name.is_equal (a_dotnet_type_name) then
						Result := cat.eiffel_names.item (j)
					end
						-- Put in cache all type found
					if not types.has (l_dotnet_type_name) and then l_dotnet_type_name /= Void and then cat.eiffel_names.item (j) /= Void then
						types.extend (cat.eiffel_names.item (j), l_dotnet_type_name)
					end
					j := j + 1
				end
				i := i + 1
			end
			
			if Result = Void then
				Result := a_dotnet_type_name
					-- Put in cache all type found
				if not types.has (l_dotnet_type_name) then
					types.extend (a_dotnet_type_name, a_dotnet_type_name)
				end
			end
		ensure
			non_void_result: Result /= Void
		end
		
feature {NONE} -- Implementation

	title_color: EV_COLOR is
			-- foreground color of titles (attributes, procedures, creation routines, functions).
		once
			create Result.make_with_8_bit_rgb (0, 0, 255) 
		ensure
			result_set: Result /= Void
		end

	type_color: EV_COLOR is
			-- foreground color of types.
		once
			create Result.make_with_8_bit_rgb (125, 125, 0) 
		ensure
			result_set: Result /= Void
		end

	feature_color: EV_COLOR is
			-- foreground color of features.
		once
			create Result.make_with_8_bit_rgb (0, 255, 0) 
		ensure
			result_set: Result /= Void
		end
		
	attribute_color: EV_COLOR is
			-- foreground color of attributes.
		once
			create Result.make_with_8_bit_rgb (0, 125, 125) 
		ensure
			result_set: Result /= Void
		end

invariant
	non_void_output: output /= Void

end -- class TYPE_PRINTER

