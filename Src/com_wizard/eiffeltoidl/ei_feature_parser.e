indexing
	description: "Feature parser"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_FEATURE_PARSER

inherit
	EI_APP_CONSTANTS

feature -- Access

	parsed_feature: EI_FEATURE
			-- Parsed feature

feature -- Status report

	succeed: BOOLEAN
			-- Operation succeed.

feature -- Basic operations

	parse_routine (inputs: LINKED_LIST[STRING]) is
		require
			non_void_input: inputs /= Void
			valid_input: not inputs.empty
			valid_feature_input: inputs.first.substring_index (Feature_indicator, 1) /= 0
		local
			l_comment: STRING
		do
			succeed := False
			if inputs.first.substring_index (Constant_indicator, 1) < 1 and -- Do not check constant
					inputs.first.substring_index (Infix_feature_indicator, 1) < 1 and -- Remove infix feature
					inputs.first.substring_index (Prefix_feature_indicator, 1) < 1 then -- Remove prefix feature

				create l_comment.make (100)

				inputs.first.replace_substring_all (Feature_indicator, Empty_string)

				parse_signature (inputs.first)

				from
					inputs.start
					inputs.forth
				until
					inputs.after or else
					inputs.item.substring_index (Comment_indicator, 1) <= 0
				loop
					if inputs.item.substring_index (Comment_indicator, 1) > 0 then
						inputs.item.replace_substring_all (Comment_indicator, Empty_string)
						inputs.item.left_adjust
						inputs.item.right_adjust
						l_comment.append (inputs.item)
						l_comment.append ("%N")
					end
					inputs.forth
				end

				if succeed and not l_comment.empty then
					parsed_feature.set_comment (l_comment)
				end
			end
		end

feature {NONE} -- Implementation

	parse_signature (input: STRING) is
			-- Parse 'input'.
		require
			non_void_input: input /= Void
			valid_input: not input.empty
		local
			l_name, l_parameter, l_result_type: STRING
			index, colon_index, space_index: INTEGER
		do
			input.replace_substring_all (Feature_indicator, Empty_string)
			colon_index := input.index_of (Colon_character , 1) - 1
			space_index := input.index_of (Space_character, 1) - 1

			if colon_index > space_index then
				l_name := input.substring (1, space_index)
			elseif colon_index < space_index then
				l_name := input.substring (1, colon_index)
			else
				l_name := input.substring (1, input.count)
			end

			if not l_name.empty then
				create parsed_feature.make (l_name)
				succeed := True
	
				index := input.index_of (Open_parenthesis_char, 1)
				if index > 0 then
					l_parameter := input.substring (index, input.index_of (Close_parenthesis_char, 1))
					input.replace_substring_all (l_parameter, Empty_string)
					parse_parameters (l_parameter)
				end

				index := input.index_of (Colon_character, 1)
				if index > 0 then
					l_result_type := input.substring (index +1, input.count)
					l_result_type.left_adjust
					l_result_type.right_adjust
					if l_result_type.substring_index (Like_word, 1) = 1 then
						l_result_type := l_result_type.substring (l_result_type.index_of (Space_character, 1) + 1, l_result_type.count)
					end
					parsed_feature.set_result_type (l_result_type)
				end
			end
		end
	
	parse_parameters (input: STRING) is
			-- Parse list of parameters in 'input'.
		require
			valid_feature: parsed_feature /= Void
			valid_input: input /= Void and then not input.empty
		local
			l_buffer: STRING
			index: INTEGER
			no_item: BOOLEAN
		do
			input.remove (1)
			input.remove (input.count)

			from
				no_item := False
			until
				input.index_of (Colon_character, 1) < 1 or
				no_item
			loop
				index := input.index_of (Semicolon_character, 1)
				if index > 0 then
					l_buffer := input.substring (1, index - 1)
					parse_parameter (l_buffer)
					input.tail (input.count - index)
					input.left_adjust
				else
					input.right_adjust
					parse_parameter (input)
					no_item := True
				end
			end
		ensure
			parse_succeed: not parsed_feature.parameters.empty
		end

	parse_parameter (input: STRING) is
			-- Parse a parameter set from 'input'.
		require
			valid_feature: parsed_feature /= Void
			valid_input: input /= Void and then not input.empty
		local
			l_type: STRING
			para: EI_PARAMETER
			colon_index, comma_index: INTEGER
		do
			colon_index := input.index_of (Colon_character, 1)
			l_type := input.substring (colon_index+1, input.count)
			l_type.left_adjust

			if l_type.substring_index (Like_word, 1) = 1 then
				l_type.replace_substring_all (Like_word, Empty_string)
				l_type.left_adjust
			end

			from
				comma_index := input.index_of (Comma_character, 1)
			until
				comma_index < 1
			loop
				if comma_index > 0 then
					create para.make (input.substring (1, comma_index-1), l_type)
					input.tail (input.count - comma_index - 1)
					input.left_adjust
				end
				parsed_feature.add_parameter (para)
				comma_index := input.index_of (Comma_character, 1)
			end
			colon_index := input.index_of (Colon_character, 1)
			create para.make (input.substring (1, colon_index - 1), l_type)
			parsed_feature.add_parameter (para)
		end

end -- class EI_FEATURE_PARSER
