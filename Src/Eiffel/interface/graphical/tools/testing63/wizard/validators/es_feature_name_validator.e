indexing
	description: "[
		Objects that validate feature names.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_FEATURE_NAME_VALIDATOR

inherit
	ES_VALIDATOR

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PARSER

	SHARED_ERROR_HANDLER

feature -- Validation

	validate_feature_name (a_feature_name: !STRING)
			-- Is name a vlaid name for an Eiffel feature?
			--
			-- `a_feature_name': Name to be validated.
		do
			reset
			if a_feature_name.is_empty then
				set_error (e_empty_feature_name)
			elseif not is_valid_feature_name (a_feature_name) then
				set_formatted_error (e_invalid_feature_name, [a_feature_name])
			end
		end

	validate_new_feature_name (a_feature_name: !STRING; a_class: !CLASS_I) is
			-- Is name a valid name for a new feature?
			--
			-- `a_feature_name': Name of new Eiffel feature.
			-- `a_class': Class in which new feature will be created.
		local
			l_ast: ?CLASS_AS
			l_file: KL_BINARY_INPUT_FILE
			b: BOOLEAN
		do
			validate_feature_name (a_feature_name)
			if is_valid then
				if a_class.is_compiled and then {l_classc: CLASS_C} a_class.compiled_class then
					if l_classc.feature_named (a_feature_name) /= Void then
						set_formatted_error (e_feature_already_exists, [a_class.name, a_feature_name])
					end
				else
					check
						error_handler_empty: error_handler.error_list.is_empty and
								error_handler.warning_list.is_empty
					end
					create l_file.make (a_class.file_name)
					l_file.open_read
					if l_file.is_open_read then
						entity_feature_parser.parse (l_file)
						l_ast := entity_feature_parser.root_node
						error_handler.wipe_out
						if l_ast /= Void then
							b := True
							if l_ast.feature_of_name (a_feature_name, False) /= Void then
								set_formatted_error (e_feature_already_exists, [a_class.name, a_feature_name])
							end
						end
					end
					if not b then
						set_formatted_error (e_class_file_not_valid, [a_class.name])
					end
				end
			end
		end

feature {NONE} -- Constants

	e_empty_feature_name: STRING = "Feature names can not be empty."
	e_invalid_feature_name: STRING = "$1 is not a valid Eiffel feature name."
	e_feature_already_exists: STRING = "{$1} already contains a feature named $2."
	e_class_file_not_valid: STRING = "Class file {$1} can not be parsed."

end
