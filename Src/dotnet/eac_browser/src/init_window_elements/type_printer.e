indexing
	description: "Print in output the eiffel type with all its eiffelfeatures corresponding to given dotnet type name."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_PRINTER

inherit
	FINDER

create
	make

feature {NONE} -- Initialization

	make (an_output: EV_TEXT) is
			-- Initialiaze `output' with `an_output'.
		require
			non_void_an_output: an_output /= Void
		do
			output := an_output
			create feature_selected.make_empty
		ensure
			output_set: output = an_output
			non_void_feature_selected: feature_selected /= Void
		end

feature -- Access

	output: EV_TEXT
			-- output to print type.
			
	assembly_of_type: CONSUMED_ASSEMBLY
			-- assembly where is located `dotnet_type_name'.
			
	dotnet_type_name: STRING
			-- dotnet type name to print.
			
	feature_selected: STRING
			-- feature selected. Empty if no feature selected.
	
	begin_selection, end_selection: INTEGER
			-- begining end ending of the selectionned text.
			
feature -- Basic Operations

	print_type (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING; an_eiffel_feature_name: STRING) is
			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
			-- Set `dotnet_type_name' with `a_dotnet_type_name'
			-- Print in `output' features corresponding to `a_type_name'.
		require
			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
		do
			assembly_of_type := assembly_of_dotnet_type
			dotnet_type_name := a_dotnet_type_name
			feature_selected := an_eiffel_feature_name
			internal_print_type
		ensure
			not_empty_output: not output.text.is_empty
		end

--	print_type_with_selectionned_feature (assembly_of_dotnet_type: CONSUMED_ASSEMBLY; a_dotnet_type_name: STRING; an_eiffel_feature_name: STRING) is
--			-- Set `assembly_of_type' with `assembly_of_dotnet_type' 
--			-- Set `dotnet_type_name' with `a_dotnet_type_name'
--			-- Print in `output' features corresponding to `a_type_name'.
--		require
--			non_void_assembly_of_dotnet_type: assembly_of_dotnet_type /= Void
--			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
--			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
--		do
--			assembly_of_type := assembly_of_dotnet_type
--			dotnet_type_name := a_dotnet_type_name
--			internal_print_type
--		ensure
--			not_empty_output: not output.text.is_empty
--		end
	
feature {NONE} -- Implementation

	internal_print_type is
			-- Print in `output' features corresponding to `dotnet_type_name'.
		local
			ct: CONSUMED_TYPE
			eac: EAC_BROWSER
		do
			output.remove_text
			create eac
			ct := eac.consumed_type (assembly_of_type, dotnet_type_name)
			if ct /= Void then
--				output.set_pebble (ct.eiffel_name)
--				output.set_pebble_position (output.x_position, output.y_position)
				output.append_text (ct.eiffel_name + "%N" + "%N")
				output.append_text (print_constructors (ct.constructors))
				output.append_text (print_attributes (ct.fields))
				output.append_text (print_procedures (ct.procedures))
				output.append_text (print_functions (ct.functions))
			end
			output.scroll_to_line (1)
		end

	print_procedures (array: ARRAY [CONSUMED_MEMBER]): STRING is
			-- Return all signatures procedures contained in `array'.
		local
			i: INTEGER
			procedures: SORTABLE_ARRAY [STRING]
		do
			create Result.make (50000)
			
			Result.append ("Procedure(s) :")
			Result.append ("%N")
			from
				i := 1
				create procedures.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				procedures.put (print_feature (array.item (i)) + "%N", i)

				i := i + 1
			end
			
			from
				i := 1
				procedures.sort
			until
				i > procedures.count
			loop
				Result.append (procedures.item (i))
				i := i + 1
			end
			Result.append ("%N")
		end

	print_feature (a_feature: CONSUMED_MEMBER): STRING is
			-- Return feature's siganture without its returned_type contained in `a_feature'.
		require
			non_void_feature: a_feature /= Void
		local
			i: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
		do
			create Result.make (1000)
			
			Result.append ("%T")
			Result.append (a_feature.dotnet_name + " : ")
			Result.append (a_feature.eiffel_name)
			from
				i := 1
			until
				a_feature.arguments = Void
				or else i > a_feature.arguments.count 
			loop
				if i = 1 then
					Result.append (" (")
				else
					Result.append (", ")
					--Result.append ("%N%T%T%T")
				end
				Result.append (a_feature.arguments.item (i).eiffel_name + ": ")

				l_argument := a_feature.arguments.item (i).type
				l_array_argument := Void
				l_array_argument ?= l_argument
					-- Is type argument NATIVE_ARRAY?
				if l_array_argument /= Void then
					Result.append ("NATIVE_ARRAY [" + eiffel_type_name (assembly_of_type, l_array_argument.element_type.name) + "]")
				else
					Result.append (eiffel_type_name (assembly_of_type, l_argument.name))
				end
				i := i + 1
			end
			if i /= 1 then
				Result.append (")")
			end
		end
		
	print_constructors (array: ARRAY [CONSUMED_CONSTRUCTOR]): STRING is
			-- Return all signatures constructors contained in `array'.
		local
			i, j: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
		do
			create Result.make (25000)
			
			Result.append ("Creation routine(s) :")
			Result.append ("%N")
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
--				Result.append (print_feature (array.item (i)))
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
						Result.append ("NATIVE_ARRAY [" + eiffel_type_name (assembly_of_type, l_array_argument.element_type.name) + "]")
					else
						Result.append (eiffel_type_name (assembly_of_type, l_argument.name))
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
			-- Return all signatures functions contained in `array'.
		local
			i: INTEGER
			signature_function: STRING
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
			functions: SORTABLE_ARRAY [STRING]
		do
			create Result.make (50000)
			
			--Result.set_foreground_color (title_color)
			Result.append ("Function(s) :")
			Result.append ("%N")
			from
				i := 1
				create functions.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				signature_function := print_feature (array.item (i))

				l_returned_type := array.item (i).return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					signature_function.append (": NATIVE_ARRAY [" + eiffel_type_name (assembly_of_type, l_array_returned_type.element_type.name) + "]")
				else
					signature_function.append (": " + eiffel_type_name (assembly_of_type, l_returned_type.name))
				end
				signature_function.append ("%N")
				
				functions.put (signature_function, i)

				i := i + 1
			end
			
			from
				i := 1
				functions.sort
			until
				i > functions.count
			loop
				Result.append (functions.item (i))
				i := i + 1
			end
			
			Result.append ("%N")
		end

	print_attributes (array: ARRAY [CONSUMED_FIELD]): STRING is
			-- Return all signatures attributes contained in `array'.
		local
			i: INTEGER
			signature_field: STRING
			attributes: SORTABLE_ARRAY [STRING]
			l_field: CONSUMED_FIELD
			l_constante_field: CONSUMED_LITERAL_FIELD
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
		do
			create Result.make (20000)
			
			Result.append ("Attribute(s) :")
			Result.append ("%N")
			from
				i := 1
				create attributes.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				l_field := array.item (i)
				signature_field := print_feature (l_field)

				l_returned_type := l_field.return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					signature_field.append (": NATIVE_ARRAY [" + eiffel_type_name (assembly_of_type, l_array_returned_type.element_type.name) + "]")
				else
					signature_field.append (": " + eiffel_type_name (assembly_of_type, l_returned_type.name))
				end

				l_constante_field ?= l_field
					-- Is it a constante?
				if l_constante_field /= Void then
					signature_field.append (" is " + l_constante_field.value)				
				end
				signature_field.append ("%N")

				attributes.put (signature_field, i)

				i := i + 1
			end

			from
				i := 1
				attributes.sort
			until
				i > attributes.count
			loop
				Result.append (attributes.item (i))
				i := i + 1
			end
			
			Result.append ("%N")
		end

--	eiffel_type_name (a_dotnet_type_name: STRING): STRING is
--			-- Return the `eiffel_type_name' corresponding to `a_dotnet_type_name'.
--		require
--			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
--			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
--		do
--			if types.has (a_dotnet_type_name) then
--				Result := types.item (a_dotnet_type_name)
--			else
--				Result := search_eiffel_type_name (a_dotnet_type_name)
--			end
--		ensure
--			non_void_result: Result /= Void
--		end
--	
--	search_eiffel_type_name (a_dotnet_type_name: STRING): STRING is
--			-- Return the `eiffel_type_name' corresponding to `a_dotnet_type_name'.
--		require
--			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
--			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
--		local
--			i, j: INTEGER
--			eac: EAC_BROWSER
--			l_file_name: STRING
--			l_assembly_file_name: STRING
--			referenced_assemblies: CONSUMED_ASSEMBLY_MAPPING
--			cat: CONSUMED_ASSEMBLY_TYPES
--			l_dotnet_type_name: STRING
----			des_dlg: DESERIALIZATION_DLG
--		do
--			create eac
--			l_file_name := absolute_referenced_assemblies_path (assembly_of_type)
--			referenced_assemblies := eac.referenced_assemblies (assembly_of_type)
--
----			create des_dlg
----			des_dlg.show_modal_to_window (Current);
--			(create {EV_ENVIRONMENT}).application.process_events
--			from
--				i := 1
--			until
--				referenced_assemblies = Void
--				or else
--				i > referenced_assemblies.assemblies.count --or Result /= Void
--			loop
----				des_dlg.set_progress_bar ((i * 100 / referenced_assemblies.assemblies.count).rounded)
--				
--				l_assembly_file_name := absolute_info_assembly_path (referenced_assemblies.assemblies.item (i)) 
--				cat := eac.consumed_assembly (referenced_assemblies.assemblies.item (i))
--				from
--					j := 1
--				until
--					cat = Void
--					or else
--					j > cat.dotnet_names.count --or Result /= Void
--				loop
--					l_dotnet_type_name := cat.dotnet_names.item (j)
--					if l_dotnet_type_name /= Void and then l_dotnet_type_name.is_equal (a_dotnet_type_name) then
--						Result := cat.eiffel_names.item (j)
--					end
--						-- Put in cache all type found
--					if not types.has (l_dotnet_type_name) and then l_dotnet_type_name /= Void and then cat.eiffel_names.item (j) /= Void then
--						types.extend (cat.eiffel_names.item (j), l_dotnet_type_name)
--					end
--					j := j + 1
--				end
--				i := i + 1
--			end
----			des_dlg.destroy
--
--			if Result = Void then
--				Result := a_dotnet_type_name
--			end
--		ensure
--			non_void_result: Result /= Void
--		end
		
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
	non_void_feature_selected: feature_selected /= Void

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


end -- class TYPE_PRINTER

