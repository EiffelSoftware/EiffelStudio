indexing
	description: "Print in lines the eiffel type with all its eiffel features corresponding to the given dotnet type name."
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	DISPLAY_TYPE_FACTORY

inherit
	CACHE_PATH
	COLOR_CONSTANT
	FINDER

create
	make,
	make_with_selected_feature

feature -- Initialization

	make (a_type: SPECIFIC_TYPE) is
			-- Initialiaze `type' with `a_type'.
			-- Initialize alse `lines' and `feature_selected'.
		require
			non_void_a_type: a_type /= Void
		do
			type := a_type
			create lines.make (0)
			lines.start
			create l_line.make
			create feature_selected.make_empty
		ensure
			type_set: type = a_type implies type /= Void
			lines_set: lines /= Void
			non_void_feature_selected: feature_selected /= Void
		end

	make_with_selected_feature  (a_type: SPECIFIC_TYPE; a_selected_feature_name: STRING) is
			-- Initialiaze `lines' with `an_output'.
		require
			non_void_a_type: a_type /= Void
			non_void_selected_feature_name: a_selected_feature_name /= Void
		do
			type := a_type
			create lines.make (0)
			lines.start
			create l_line.make
			create feature_selected.make_from_string (a_selected_feature_name)
			internal_print_type
		ensure
			type_set: type = a_type implies type /= Void
			lines_set: lines /= Void
			non_void_feature_selected: feature_selected /= Void
		end

feature -- Access

	lines: ARRAYED_LIST [DISPLAYED_LINE]
			-- List of line to display.
			
	type: SPECIFIC_TYPE
			-- Type to display.

	feature_selected: STRING
			-- feature selected. Empty if no feature selected.

feature {NONE} -- Implementation

	l_line: DISPLAYED_LINE
			-- current line.

feature {NONE} -- Implementation

	internal_print_type is
			-- Print in `lines' features corresponding to `dotnet_type_name'.
		do
			if type /= Void then
				print_header
				print_constructors (type.type.constructors)
				print_attributes (type.type.fields)
				print_procedures (type.type.procedures)
				print_functions (type.type.functions)
			end

		end
	
	print_header is
			-- header.
		local
			l_entity: ENTITY_LINE
		do
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (type.type.eiffel_name, Title_color))
			new_line;
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("               --   ", Text_color))
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (type.type.dotnet_name, Text_color))
			new_line; new_line
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (Tabulation, Text_color))
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("Parent: " , Text_color))

			if type.type.parent /= Void then
				create l_entity.make_with_image_and_color (type.type.parent.name, eiffel_feature_color)
				l_entity.set_data (type.type.parent)
				l_line.entities.extend (l_entity)
			else
				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("No parent" , Text_color))
			end
			new_line; new_line
		end
		

	print_procedures (array: ARRAY [CONSUMED_PROCEDURE]) is
			-- Store signatures procedures contained in `array'.
		local
			i: INTEGER
			procedures: SORTABLE_ARRAY [COMPARABLE_CONSUMED_PROCEDURE]
		do
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("Procedure(s) :", title_color))
			new_line
			from
				i := 1
				create procedures.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				procedures.put (create {COMPARABLE_CONSUMED_PROCEDURE}.make_with_consumed_procedure (array.item (i)), i)

				i := i + 1
			end
			
			from
				i := 1
				procedures.sort
			until
				i > procedures.count
			loop
				print_feature (procedures.item (i))
				new_line
				i := i + 1
			end
			new_line
		end

	print_feature (a_feature: CONSUMED_MEMBER) is
			-- Store feature's siganture without its returned_type contained in `a_feature'.
		require
			non_void_feature: a_feature /= Void
		local
			i: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
			output_string: STRING
			l_entity: ENTITY_LINE
		do
			if a_feature.eiffel_name.is_equal (feature_selected) then
				l_line.set_selected (True)
			else
				l_line.set_selected (False)
			end
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (Tabulation, text_color))

			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (a_feature.dotnet_name, dotnet_feature_color))

			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" : ", text_color))

			create l_entity.make_with_image_and_color (a_feature.eiffel_name, eiffel_feature_color)
			l_entity.set_data (a_feature)
			l_line.entities.extend (l_entity)
--			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (a_feature.eiffel_name, eiffel_feature_color))

			from
				i := 1
			until
				a_feature.arguments = Void
				or else i > a_feature.arguments.count 
			loop
				if i = 1 then
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" (", text_color))
				else
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (", ", text_color))
				end
				
--				if l_line.number_pixels >= Max_pixel_per_line then
--					new_line
--					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (New_line_indent, text_color))
--				end
	
				output_string := a_feature.arguments.item (i).eiffel_name
				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (output_string, argument_color))

				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": ", text_color))

				l_argument := a_feature.arguments.item (i).type
				l_array_argument := Void
				l_array_argument ?= l_argument
					-- Is type argument NATIVE_ARRAY?
				if l_array_argument /= Void then
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("NATIVE_ARRAY", type_color))

					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" [", text_color))
					
					output_string := eiffel_type_name (type.assembly, l_array_argument.element_type.name)
					create l_entity.make_with_image_and_color (output_string, type_color)
					l_entity.set_data (l_array_argument.element_type)
					l_line.entities.extend (l_entity)

					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("]", text_color))
				else
					output_string := eiffel_type_name (type.assembly, l_argument.name)
					create l_entity.make_with_image_and_color (output_string, type_color)
					l_entity.set_data (l_argument)
					l_line.entities.extend (l_entity)
				end
				i := i + 1
			end
			if i /= 1 then
				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (")", text_color))
			end
		end
	
	print_constructors (array: ARRAY [CONSUMED_CONSTRUCTOR]) is
			-- Store all signatures constructors contained in `array'.
		local
			i, j: INTEGER
			l_argument: CONSUMED_REFERENCED_TYPE
			l_array_argument: CONSUMED_ARRAY_TYPE
			output_string: STRING
			l_entity: ENTITY_LINE
		do
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("Creation routine(s) :", Title_color))
			new_line
			from
				i := 1
			until
				array = Void 
				or else i > array.count
			loop
				if feature_selected.is_equal (array.item (i).eiffel_name) then
					l_line.set_selected (True)
				else
					l_line.set_selected (False)
				end

				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (Tabulation, text_color))

				create l_entity.make_with_image_and_color (array.item (i).eiffel_name, eiffel_feature_color)
				l_entity.set_data (array.item (i))
				l_line.entities.extend (l_entity)
--				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (array.item (i).eiffel_name, eiffel_feature_color))

				from
					j := 1
				until
					array.item (i).arguments = Void
					or else j > array.item (i).arguments.count 
				loop
					if j = 1 then
						l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" (", text_color))
					else
						l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (", ", text_color))
					end

					output_string := array.item (i).arguments.item (j).eiffel_name
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (output_string, argument_color))

					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": ", text_color))

					l_argument := array.item (i).arguments.item (j).type
					l_array_argument := Void
					l_array_argument ?= l_argument
						-- Is type argument NATIVE_ARRAY?
					if l_array_argument /= Void then
						l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("NATIVE_ARRAY", type_color))
						
						l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" [", text_color))
						
						output_string := eiffel_type_name (type.assembly, l_array_argument.element_type.name)
						create l_entity.make_with_image_and_color (output_string, type_color)
						l_entity.set_data (l_array_argument.element_type)
						l_line.entities.extend (l_entity)
						
						l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("]", text_color))
					else
						output_string := eiffel_type_name (type.assembly, l_argument.name)
						create l_entity.make_with_image_and_color (output_string, type_color)
						l_entity.set_data (l_argument)
						l_line.entities.extend (l_entity)
					end
					j := j + 1
				end
				if j /= 1 then
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (")", text_color))
				end
				new_line
				
				i := i + 1
			end
			new_line
		end

	print_functions (array: ARRAY [CONSUMED_FUNCTION]) is
			-- Store all signatures functions contained in `array'.
		local
			i: INTEGER
			signature_function: STRING
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
			functions: SORTABLE_ARRAY [COMPARABLE_CONSUMED_PROCEDURE]
			output_string: STRING
			l_entity: ENTITY_LINE
		do
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("Function(s) :", title_color))
			new_line
			from
				i := 1
				create functions.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				functions.put (create {COMPARABLE_CONSUMED_PROCEDURE}.make_with_consumed_procedure (array.item (i)), i)

				i := i + 1
			end
			
			from
				i := 1
				functions.sort
			until
				i > functions.count
			loop
				print_feature (functions.item (i))
				
				l_returned_type := functions.item (i).return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": NATIVE_ARRAY", type_color))

					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" [", text_color))

					output_string := eiffel_type_name (type.assembly, l_array_returned_type.element_type.name)
					create l_entity.make_with_image_and_color (output_string, type_color)
					l_entity.set_data (l_array_returned_type.element_type)
					l_line.entities.extend (l_entity)

					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("]", text_color))
				else
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": ", text_color))

					output_string := eiffel_type_name (type.assembly, l_returned_type.name)
					create l_entity.make_with_image_and_color (output_string, type_color)
					l_entity.set_data (l_returned_type)
					l_line.entities.extend (l_entity)
				end

				new_line
				i := i + 1
			end
			
			new_line
		end

	print_attributes (array: ARRAY [CONSUMED_FIELD]) is
			-- Store all signatures attributes contained in `array'.
		local
			i: INTEGER
			signature_field: STRING
			attributes: SORTABLE_ARRAY [COMPARABLE_CONSUMED_FIELD]
			l_field: CONSUMED_FIELD
			l_constante_field: CONSUMED_LITERAL_FIELD
			l_returned_type: CONSUMED_REFERENCED_TYPE
			l_array_returned_type: CONSUMED_ARRAY_TYPE
			output_string: STRING
			l_entity: ENTITY_LINE
		do
			l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("Attribute(s) :", title_color))
			new_line
			from
				i := 1
				create attributes.make (1, array.count)
			until
				array = Void 
				or else i > array.count
			loop
				attributes.put (create {COMPARABLE_CONSUMED_FIELD}.make_with_consumed_field (array.item (i)), i)

				i := i + 1
			end

			from
				i := 1
				attributes.sort
			until
				i > attributes.count
			loop
				if feature_selected.is_equal (attributes.item (i).eiffel_name) then
					l_line.set_selected (True)
				else
					l_line.set_selected (False)
				end

				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (Tabulation, text_color))

				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (attributes.item (i).dotnet_name, dotnet_feature_color))

				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": ", text_color))

				create l_entity.make_with_image_and_color (attributes.item (i).eiffel_name, eiffel_feature_color)
				l_entity.set_data (attributes.item (i))
				l_line.entities.extend (l_entity)
--				l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (attributes.item (i).eiffel_name, eiffel_feature_color))
				
				l_returned_type := attributes.item (i).return_type
				l_array_returned_type := Void
				l_array_returned_type ?= l_returned_type
					-- Is it a NATIVE_ARRAY?
				if l_array_returned_type /= Void then
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": NATIVE_ARRAY", type_color))
					
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" [", text_color))
					
					output_string := eiffel_type_name (type.assembly, l_array_returned_type.element_type.name)
					create l_entity.make_with_image_and_color (output_string, type_color)
					l_entity.set_data (l_array_returned_type.element_type)
					l_line.entities.extend (l_entity)
					
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color ("]", text_color))
				else
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (": ", text_color))
					
					output_string := eiffel_type_name (type.assembly, l_returned_type.name)
					create l_entity.make_with_image_and_color (output_string, type_color)
					l_entity.set_data (l_returned_type)
					l_line.entities.extend (l_entity)
				end

				l_constante_field ?= l_field
					-- Is it a constante?
				if l_constante_field /= Void then
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (" is ", text_color))
					
					l_line.entities.extend (create {ENTITY_LINE}.make_with_image_and_color (l_constante_field.value, constant_color))
				end
				
				new_line
				i := i + 1
			end
			
			new_line
		end

feature {NONE} -- Implementation

	new_line is
			-- put l_line in lines
		do
			lines.extend (l_line)
			create l_line.make
		end
		
	Tabulation: STRING is "      "
			-- representation of a tabulation in spaces.
	
	Max_pixel_per_line: INTEGER is 400
			-- Number max of char per line.
	
	New_line_indent: STRING is "                                                            "
			-- indent when new line but still the same signature.

invariant
	non_void_type_set: type /= Void
	non_void_lines: lines /= Void
	non_void_feature_selected: feature_selected /= Void

end -- class DISPLAY_TYPE_FACTORY

