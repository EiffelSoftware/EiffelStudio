indexing
	description: "Input class information"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_CLASS_DATA_INPUT

inherit
	EI_DATA_INPUT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			class_not_found := True
		end

feature -- Status report

	class_not_found: BOOLEAN
			-- Whether class in project.

feature -- Basic operations

	input_from_file (input_file: PLAIN_TEXT_FILE) is
			-- Input features from text file.
		local
			raw_features: LINKED_LIST[STRING]
			l_name, l_description: STRING
			feature_parser: EI_FEATURE_PARSER
		do
			if input_file.is_closed then
				input_file.open_read
			end

			from
				input_file.start
			until
				input_file.end_of_file
			loop
				input_file.read_line

				if not input_file.last_string.is_empty then
					if input_file.last_string.substring_index (Class_header_indicator,1) > 0 then
						class_not_found := False  

						input_file.read_line
						l_name := clone (input_file.last_string)
						l_name.left_adjust
						l_name.right_adjust

						create eiffel_class.make (l_name)

						from
						until
							input_file.end_of_file
						loop
							input_file.read_line

							if not input_file.last_string.is_empty then
								if input_file.last_string.substring_index (Feature_indicator, 1) > 0 then									if raw_features /= Void and not raw_features.is_empty then
										create feature_parser
										feature_parser.parse_routine (raw_features)
										if feature_parser.succeed then
											eiffel_class.add_feature (feature_parser.parsed_feature)
										end
										raw_features := Void
									end
	
									create raw_features.make
									raw_features.extend (clone (input_file.last_string))
								elseif 
									input_file.last_string.substring_index ("--", 1) = 1 
								then
									raw_features.extend (clone (input_file.last_string))
								end
							end
						end
						if raw_features /= Void and not raw_features.is_empty then
							create feature_parser
							feature_parser.parse_routine (raw_features)
							if feature_parser.succeed then
								eiffel_class.add_feature (feature_parser.parsed_feature)
							end
						end

					elseif input_file.last_string.substring_index (Description_indicator, 1) = 1 then
						l_description := parsed_description (clone (input_file.last_string))
					end
				end
			end
			input_file.close

			if not class_not_found then
				if eiffel_class /= Void and l_description /= Void and not l_description.is_empty then
					eiffel_class.set_description (l_description)
				end
				parse_eiffel_type
			end
		end

feature {NONE} -- Implementation

	parse_eiffel_type is
			-- Parse through the feature list to set the 'like' type to appropriate type.
		require
			valid_class: eiffel_class /= Void
		local
			l_feature: EI_FEATURE
			parameter_list: LINKED_LIST[EI_PARAMETER]
		do
			-- Put type name to 'like ' type.
			if not eiffel_class.features.is_empty then
				from
					eiffel_class.features.start
				until
					eiffel_class.features.off
				loop
					l_feature := eiffel_class.features.item_for_iteration
					if l_feature.result_type.is_equal (Current_type) then
						l_feature.set_result_type (eiffel_class.name)
					elseif eiffel_class.features.has (l_feature.result_type) then
						l_feature.set_result_type (eiffel_class.features.item (l_feature.result_type).result_type)
					end

					parameter_list := eiffel_class.features.item_for_iteration.parameters
	
					-- Check parameter for 'like' type
					if not parameter_list.is_empty then
						from
							parameter_list.start
						until
							parameter_list.after
						loop
							if parameter_list.item.type.is_equal (Current_type) then
								parameter_list.item.set_type (eiffel_class.name)
							elseif eiffel_class.features.has (parameter_list.item.type) then
								parameter_list.item.set_type (eiffel_class.features.item (parameter_list.item.type).result_type)
							end

							parameter_list.forth
						end
					end
					eiffel_class.features.forth
				end
			end
		end

	parsed_description (desc: STRING): STRING is
			-- Description parsed from 'desc'
		require
			non_void_input: desc /= Void
			valid_desc : not desc.is_empty
		local
			s_pos, e_pos: INTEGER
		do
			s_pos := desc.index_of (Double_quote_character, 1) + 1
			e_pos := desc.last_index_of (Double_quote_character, desc.count) - 1

			if s_pos > e_pos then
				Result := ""
			else
				Result := desc.substring (s_pos, e_pos)
			end
		end

end -- class EI_CLASS_DATA_INPUT
