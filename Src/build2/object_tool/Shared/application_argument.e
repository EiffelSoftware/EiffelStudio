indexing
	description: "Class representing arguments of an Eiffel routine"
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	APPLICATION_ARGUMENT

creation
	make

feature -- Creation

	make (arg_name, arg_type: STRING) is
			-- Create object.
		require
			arg_name_valid: arg_name /= Void and not arg_name.empty
			arg_type_valid: arg_type /= Void and not arg_type.empty
		do
			argument_name := arg_name
			argument_type := arg_type
		end

feature -- Attributes

	argument_name: STRING
			-- Name of the argument

	argument_type: STRING
			-- Type of the argument

feature 

	eiffel_text: STRING is
			-- Eiffel text corresponding to the declaration.
		do
			create Result.make (0)
			Result.append (argument_name)
			Result.append (": ")
			Result.append (argument_type)
		end

end -- class APPLICATION_ARGUMENT
