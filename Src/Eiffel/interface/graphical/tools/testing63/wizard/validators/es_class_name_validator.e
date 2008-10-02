indexing
	description: "[
		Objects that validate class names.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLASS_NAME_VALIDATOR

inherit
	ES_VALIDATOR

	EIFFEL_SYNTAX_CHECKER
		export
			{NONE} all
		end

feature -- Validation

	validate_class_name (a_class_name: !STRING)
			-- Is name a valid name for an Eiffel class?
			--
			-- `a_class_name': Name to be validated.
		do
			reset
			if a_class_name.is_empty then
				set_error (e_empty_class_name)
			elseif not is_valid_class_name (a_class_name) then
				set_formatted_error (e_invalid_class_name, [a_class_name])
			end
		end

	validate_new_class_name (a_class_name: !STRING; a_project: !E_PROJECT)
			-- Is name a valid name for a new Eiffel class?
			--
			-- `a_class_name': Name for new Eiffel class.
			-- `a_project': Project in which new class will be created.
		local
			l_uni: UNIVERSE_I
		do
			validate_class_name (a_class_name)
			if is_valid then
				l_uni := a_project.universe
				if not l_uni.classes_with_name (a_class_name.as_upper).is_empty then
					set_formatted_error (e_class_already_exists, [a_class_name])
				end
			end
		end

feature {NONE} -- Constants

	e_empty_class_name: STRING = "Eiffel class names can not be empty."
	e_invalid_class_name: STRING = "$1 is not a valid Eiffel class name."
	e_class_already_exists: STRING = "An Eiffel class with the name $1 already exists."


end
