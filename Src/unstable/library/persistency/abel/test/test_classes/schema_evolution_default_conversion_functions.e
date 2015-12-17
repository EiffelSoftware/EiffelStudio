note
	description: "Eigens conversion function, it is only to simplify the work"
	author: "Teseo Schneider"
	date: "30.9.2008"
	revision: "$Revision$"

class
	SCHEMA_EVOLUTION_DEFAULT_CONVERSION_FUNCTIONS

feature -- default tuples to add at the hash table

	variable_changed_name (old_name: STRING): TUPLE [LIST [STRING],FUNCTION [LIST [ANY],ANY]]
			-- agent to change the variable name
		local
			var: ARRAYED_LIST [STRING]
		do
			create var.make (1)
			var.extend (old_name)
			Result := [var, agent change_name (?)]
		end

	variable_constant (value: ANY): TUPLE [LIST [STRING],FUNCTION [LIST [ANY],ANY]]
			-- set a constant value
		local
			var: ARRAYED_LIST [STRING]
		do
			create var.make (1)
			Result := [var, agent constant_function (value,?)]
		end

	variable_changed_type (old_name: STRING; conv_function: FUNCTION [ANY]): TUPLE [LIST [STRING],FUNCTION [LIST [ANY],ANY]]
			-- change the type
		local
			var: ARRAYED_LIST [STRING]
		do
			create var.make (1)
			var.force (old_name)
			Result := [var, agent change_type (?, conv_function)]
		end

feature{NONE} -- functions

	change_name (var: LIST [ANY]): ANY
			-- change the function name
		do
			Result := var.i_th (1)
		end

	constant_function (value: ANY; var: LIST [ANY]): ANY
			-- constant function
		do
			Result := value
		end

	change_type (var: LIST [ANY]; conv_function: FUNCTION [ANY]): ANY
			-- change the function type
		do
			if attached {ANY} var.i_th (1) as arg then
				Result := conv_function.item ([arg])

			else
				Result := conv_function.item (Void)
			end
		end

feature -- conversion type function

	int_to_string (a: INTEGER): STRING
			-- convert a in a string
		do
			Result := a.out
		end

	to_string (a: ANY) :STRING
			-- convert a in a string
		do
			Result := a.out
		end

	to_integer (s: STRING): INTEGER
			-- convert s in a int
		do
			Result := s.to_integer
		end

	to_double (s: STRING): DOUBLE
			-- convert s in a int
		do
			Result := s.to_double
		end

	to_boolan (s: STRING): BOOLEAN
			-- convert s in a int
		do
			Result := s.to_boolean
		end

end
