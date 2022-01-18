note
	description: "User-defined Boogie types; consist of a type constructor with zero or more parameters."

class
	IV_USER_TYPE

inherit
	IV_TYPE
		redefine
			default_value,
			type_inv,
			is_equal,
			has_rank,
			rank_leq
		end

create
	make

feature {NONE} -- Initialization

	make (a_constructor: READABLE_STRING_8; a_params: like parameters)
			-- Create a type by applying `a_constructor' to `a_params'.
		require
			a_constructor_exists: a_constructor /= Void
			a_params_exists: a_params /= Void
			all_params_exist: across a_params as p all p /= Void end
		do
			constructor := a_constructor
			parameters := a_params
			parameters.compare_objects
		ensure
			constrcutor_set: constructor = a_constructor
			params_set: parameters = a_params
		end

feature -- Access

	constructor: READABLE_STRING_8
			-- Type constructor.

	parameters: ARRAYED_LIST [IV_TYPE]
			-- Type parameters.

	default_value: IV_EXPRESSION
			-- <Precursor>

	type_inv (a_expr: IV_EXPRESSION): IV_EXPRESSION
			-- Invariant of this type applied to `a_expr'.
		do
			if attached type_inv_function then
				Result := factory.function_call (type_inv_function, << a_expr >>, create {IV_BASIC_TYPE}.make_boolean)
			end
		end

feature -- Element change

	set_default_value (a_value: IV_EXPRESSION)
			-- Set `default_value' to `a_value'.
		require
			correct_type: a_value /= Void and then a_value.type ~ Current
		do
			default_value := a_value
		end

	set_type_inv_function (a_name: READABLE_STRING_8)
			-- Set `type_inv_function' to `a_name'.
		do
			type_inv_function := a_name
		end

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- Process type.
		do
			a_visitor.process_user_type (Current)
		end

feature -- Equality

	is_equal (a_other: like Current): BOOLEAN
			-- Is `a_other' same type as this?
		do
			Result := constructor ~ a_other.constructor and
				parameters ~ a_other.parameters
		end

feature -- Termination

	set_rank_function (a_function: READABLE_STRING_8)
			-- Set `rank_leq_function' to `a_function'.
		do
			rank_leq_function := a_function
		end

	has_rank: BOOLEAN
			-- <Precursor>
		do
			Result := rank_leq_function /= Void
		end

	rank_leq (e1, e2: IV_EXPRESSION): IV_EXPRESSION
			-- <Precursor>	
		do
			Result := factory.function_call (rank_leq_function, << e1, e2 >>, create {IV_BASIC_TYPE}.make_boolean)
		end

feature {NONE} -- Implementation		

	rank_leq_function: READABLE_STRING_8
			-- Name of the Boogie function that defines the well-founded order on this type.

	type_inv_function: READABLE_STRING_8
			-- Name of the Boogie function that defines the invariant on this type.

invariant
	constructor_exists: constructor /= Void
	params_exists: parameters /= Void
	all_params_exist: across parameters as p all p /= Void end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
