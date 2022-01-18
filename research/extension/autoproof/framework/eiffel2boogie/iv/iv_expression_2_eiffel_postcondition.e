note
	description: "Takes an IV_EXPRESSION and outputs the corresponding eiffel postcondition."

class
	IV_EXPRESSION_2_EIFFEL_POSTCONDITION

inherit

	IV_EXPRESSION_VISITOR

create make

feature {NONE}

	make
		do
			output := ""
			create bound_variabls.make
		end

feature -- Access

	output: STRING
		--result eiffel expression as a string

feature -- Basic operations

	reset
		do
			output := ""
			create bound_variabls.make
		end

feature -- Visitor

	process_binary_operation (a_operation: IV_BINARY_OPERATION)
			-- Process `a_operation'.
		do
			print_space
			print_character ('(')
			a_operation.left.process (Current)
			print_space
			print_string (get_operator (a_operation.operator))
			print_space
			a_operation.right.process (Current)
			print_character (')')
			print_space
		end

	process_conditional_expression (a_conditional: IV_CONDITIONAL_EXPRESSION)
			-- <Precursor>
		do
			check False end
		end

	process_entity (a_entity: IV_ENTITY)
			-- Process `a_entity'.
		local
			sub_string: STRING -- substring of a_entity.name that comes after '.', if the name contains a dot.
			index: INTEGER--index of '.'
			is_bound_variable: BOOLEAN
		do
			is_bound_variable := False
			if a_entity.name.has ('.') then --if the name is something like APPLICATION.ij2, remove the first part.
				print_space
				index := a_entity.name.character_32_last_index_of ('.', a_entity.name.count)
				sub_string := a_entity.name.substring (index + 1, a_entity.name.count)
				print_string (sub_string)
				print_space
			elseif bound_variabls.has (a_entity.name) then --doesn't seem to recognize same names, tested again in next else clause. This part could probably be omitted.
				print_space
				print_string (a_entity.name)
				print_string (".item")
				print_space
			else
				-- for running variables e.g. across  ..  as ij all ij.item end
				across bound_variabls as bs
				loop
					if bs.is_equal (a_entity.name) then
						is_bound_variable := True
					end
				end
				print_space
				print_string (a_entity.name)
				if is_bound_variable then
					print_string (".item")
				end
				print_space
			end
		end

	process_exists (a_exists: IV_EXISTS)
			-- Process `a_exists'.
		do --This shouldn't be needed. Eiffel code doesn't have a structure which would be mapped to this..
			-- otherwise it should probably be translated to something equivalent like:  not ( across .. as .. all not a_exists.expression.right.process(Current) end)
			print_space
			print_character ('"')
			print_string ("ERROR, implement process_exists")
			print_character ('"')
			print_space
		end

	process_forall (a_forall: IV_FORALL)
			-- Process `a_forall'.

		local
			left: IV_EXPRESSION
			right: IV_EXPRESSION
		do
			if attached {IV_BINARY_OPERATION} a_forall.expression as bin then
				left := bin.left
				right := bin.right
				print_string ("across ")
				print_space
				if attached {IV_BINARY_OPERATION} left as bounds_expression then -- if bounds are represented as a binary operation, i.e. of the form 2<= i and i>=8
					if attached {IV_BINARY_OPERATION} bounds_expression.left as lower_bound then --these should all be true if we get here.
						lower_bound.left.process (Current)
						print_string (" |..| ")
						if attached {IV_BINARY_OPERATION} bounds_expression.right as upper_bound then
							upper_bound.right.process (Current)
						end
					end
				elseif attached {IV_FUNCTION_CALL} left as bounds_expression then -- if the bounds are an array.
					if bounds_expression.name.is_equal ("ARRAY.$is_index") then
						bounds_expression.arguments.i_th (2).process (Current)
						print_space
					end
				else
					print_string (" error in process_forall (IV_EXPRESSION_2_EIFFEL_POSTCONDITION)")
				end

				print_string (" as ")
				print_string (a_forall.bound_variables.i_th (1).name) --assumes there is only 1 bounded variable, since it's representing Eiffel code.
				--store bound variables, so if bound variable is named i_1 e.g., it should be translated to i_1.item
				bound_variabls.force (a_forall.bound_variables.i_th (1).name)
				print_string (" all ")
				right.process (Current)
				print_string (" end ")
			else --this shouldn't be possible if assumptions are correct, but helps debugging if something fails.
				print_space
				print_string ("%Nerror in forall: [")
				a_forall.expression.process (Current)
				print_string (" ] ")
				print_space
			end
		end

	process_function_call (a_call: IV_FUNCTION_CALL)
			-- Process `a_call'.
		do
			-- there might be other cases, these were all the ones I encountered.
			if a_call.name.has_substring ("ARRAY") and a_call.name.has_substring ("count") then --array.count
				print_space
				a_call.arguments.last.process (Current) --last argument should be name of array that count is called on
				if output.item (output.count).is_equal (' ') then-- beauty procedure, so a.count instead of a .count
					remove_last_char
				end
				print_string (".count")
				print_space

			elseif a_call.name.is_equal ("ARRAY.$item") then --array.item()

				print_space
				a_call.arguments.i_th (2).process (Current) --name of the array that item is called on
				if output.item (output.count).is_equal (' ') then-- beauty procedure, so a.count instead of a .count
					remove_last_char
				end
				print_string ("[")
				a_call.arguments.last.process (Current) -- index
				print_string ("]")
				print_space

			elseif a_call.name.is_equal ("$TUPLE.item") then

				print_space
				a_call.arguments.i_th (2).process (Current) --name of the array that item is called on
				if output.item (output.count).is_equal (' ') then-- beauty procedure, so a.count instead of a .count
					remove_last_char
				end
				print_string ("[")
				a_call.arguments.last.process (Current) -- index
				print_string ("]")
				print_space

			else-- default case, if function wasn't recognised
				print_space
				print_string (a_call.name)
				--print arguments
				print_character ('(')
				across a_call.arguments as args loop
					args.process (Current)
					print_character (',')
				end
				remove_last_char --remove last comma
				print_character (')')
				print_space
			end
		end

	process_map_access (a_map_access: IV_MAP_ACCESS)
			-- Process `a_map_access'.
		local
			i:INTEGER
		do
			i:=0
			across a_map_access.indexes as ins loop
				ins.process (Current)
				if output.item (output.count).is_space then
					output.remove_tail (1)
				end
				i:=i+1
				if i< a_map_access.indexes.count then
					print_string(".")
				end
			end
		end

	process_map_update (a_map_update: IV_MAP_UPDATE)
			-- Process `a_map_update'.
		do
			check not_implemented: False end
		end

	process_unary_operation (a_operation: IV_UNARY_OPERATION)
			-- Process `a_operation'.
		do
			print_space
			print_character ('(')
			print_string (get_operator (a_operation.operator))
			print_space
			a_operation.expression.process (Current)
			print_character (')')
			print_space
		end

	process_value (a_value: IV_VALUE)
			-- Process `a_value'.
		do
			print_space
			print_string (a_value.value)
			print_space
		end

feature {IV_EXPRESSION_2_EIFFEL_POSTCONDITION} -- Implementation

	bound_variabls: LINKED_LIST [STRING]
		--list of bound variables. have to be printed as name.item instead of name in forall.

	print_space
		do
			output.append (" ")
		end

	print_character (a_char: CHARACTER)
		require
			char_not_void: a_char /= Void
		do
			output.append_character (a_char)
		end

	print_string (a_string: STRING)
		require
			string_not_void: a_string /= Void
		do
			output.append (a_string)
		end
	remove_last_char
		--remove the last character of the output
		do
			output.remove_tail (1)
		end
	get_operator (a_operator: STRING): STRING
		--change operator syntax from boogie to eiffel.
		--this list might be incomplete, but couldn't find any more cases.
		do
			Result := a_operator -- if no case is matched, return the same operator.
			if a_operator.is_equal ("&&") then
				Result := "and"
			elseif a_operator.is_equal ("||") then
				Result := "or"
			elseif a_operator.is_equal ("==") then
				Result := "="
			elseif a_operator.is_equal ("!=") then
				Result := "/="
			elseif a_operator.is_equal ("!") then
				Result := "not"
			end
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
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
