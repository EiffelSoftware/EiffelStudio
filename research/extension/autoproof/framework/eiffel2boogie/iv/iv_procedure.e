class
	IV_PROCEDURE

inherit

	IV_DECLARATION

inherit {NONE}

	IV_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
			-- Initialize procedure with name `a_name'.
		do
			name := a_name.twin
			create arguments.make
			create results.make
			create contracts.make
			create implementations.make
			contracts.compare_objects
		ensure
			name_set: name ~ a_name
		end

feature -- Access

	name: READABLE_STRING_8
			-- Procedure name.

	arguments: LINKED_LIST [IV_ENTITY_DECLARATION]
			-- Procedure arguments.

	results: LINKED_LIST [IV_ENTITY_DECLARATION]
			-- Result values.

	contracts: LINKED_LIST [IV_CONTRACT]
			-- List of contracts (pre- and postconditions).

	implementations: LINKED_LIST [IV_IMPLEMENTATION]
			-- Implementations of procedure (can be empty).

feature -- Element change

	add_argument (a_arg: IV_ENTITY)
			-- Add argument with name `a_name' and type `a_type'.
		require
			a_arg_attached: attached a_arg
		do
			arguments.extend (create {IV_ENTITY_DECLARATION}.make (a_arg.name, a_arg.type))
		ensure
			argument_added: arguments.last.name ~ a_arg.name
			argument_added: arguments.last.type = a_arg.type
			argument_added: arguments.last.property = Void
		end

	add_argument_with_property (a_arg: IV_ENTITY; a_property: detachable IV_EXPRESSION)
			-- Add argument with name `a_name' and type `a_type'.
		require
			a_arg_attached: attached a_arg
			a_property_valid: attached a_property implies a_property.type.is_boolean
		do
			arguments.extend (create {IV_ENTITY_DECLARATION}.make (a_arg.name, a_arg.type))
			arguments.last.set_property (a_property)
		ensure
			argument_added: arguments.last.name ~ a_arg.name
			argument_added: arguments.last.type = a_arg.type
			argument_added: arguments.last.property = a_property
		end

	add_result (a_name: STRING; a_type: IV_TYPE)
			-- Add result with name `a_name' and type `a_type'.
		require
			a_name_valid: is_valid_name (a_name)
			a_type_attached: attached a_type
		do
			results.extend (create {IV_ENTITY_DECLARATION}.make (a_name, a_type))
		ensure
			result_added: results.last.name ~ a_name
			result_added: results.last.type = a_type
			result_added: results.last.property = Void
		end

	add_result_with_property (a_name: STRING; a_type: IV_TYPE; a_property: detachable IV_EXPRESSION)
			-- Add result with name `a_name' and type `a_type'.
		require
			a_name_valid: is_valid_name (a_name)
			a_type_attached: attached a_type
			a_property_valid: attached a_property implies a_property.type.is_boolean
		do
			results.extend (create {IV_ENTITY_DECLARATION}.make (a_name, a_type))
			results.last.set_property (a_property)
		ensure
			result_added: results.last.name ~ a_name
			result_added: results.last.type = a_type
			result_added: results.last.property = a_property
		end

	add_contract (a_contract: IV_CONTRACT)
			-- Add contract `a_contract' to `contracts'.
		require
			a_contract_attached: attached a_contract
		do
			if not contracts.has (a_contract) then
				contracts.extend (a_contract)
			end
		ensure
			contract_added: contracts.has (a_contract)
		end

	add_implementation (a_implementation: IV_IMPLEMENTATION)
			-- Add implementation `a_implementation'.
		require
			a_implementation_attached: attached a_implementation
			a_implementation_valid: a_implementation.procedure = Current
		do
			implementations.extend (a_implementation)
		ensure
			implementation_added: implementations.last = a_implementation
		end

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_procedure (Current)
		end

invariant
	name_attached: attached name
	name_valid: is_valid_name (name)
	arguments_attached: attached arguments
	contracts_attached: attached contracts
	implementations_attached: attached implementations
	implementations_valid: across implementations as i all i.procedure = Current end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
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
