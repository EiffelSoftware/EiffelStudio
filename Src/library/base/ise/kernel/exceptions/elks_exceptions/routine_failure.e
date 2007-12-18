indexing
	description: "[
		Exception representing a routine failure.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_FAILURE

inherit
	LANGUAGE_EXCEPTION

feature -- Access

	routine_name: STRING
			-- Name of the failing routine

	class_name: STRING
			-- Class of the failure

	frozen code: INTEGER is
			-- Exception code
		once
			Result := {EXCEP_CONST}.routine_failure
		end

feature {EXCEPTION_MANAGER} -- Element change

	frozen set_routine_name (a_routine_name: like routine_name) is
			-- Set `routine_name' with `a_routine_name'
		do
			routine_name := a_routine_name
		ensure
			routine_name_set: routine_name = a_routine_name
		end

	frozen set_class_name (a_class_name: like class_name) is
			-- Set `class_name' with `a_class_name'
		do
			class_name := a_class_name
		ensure
			class_name_set: class_name = a_class_name
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING is "Routine failure."

end
