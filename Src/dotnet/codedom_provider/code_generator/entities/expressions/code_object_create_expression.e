indexing 
	description: "Source code generator for creation expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_OBJECT_CREATE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_target_type: CODE_TYPE_REFERENCE; a_arguments: LIST [CODE_EXPRESSION]) is
			-- Initialize `type', `arguments'.
		require
			non_void_target_type: a_target_type /= Void
		do
			target_type := a_target_type
			arguments := a_arguments
		ensure
			type_set: target_type = a_target_type
			arguments_set: arguments = a_arguments
		end

feature -- Access

	target_type: CODE_TYPE_REFERENCE
			-- Type of created object

	arguments: LIST [CODE_EXPRESSION]
			-- Arguments

	target: STRING
			-- Creation target

	code: STRING is
			-- | Result := "create {`type'}.`creation_routine' [(`arguments', ...)]" if target = Void
			-- | Result := "create `target'.`creation_routine' [(`arguments', ...)]" otherwise
			-- Eiffel code of object create expression
		do
			create Result.make (160)
			if new_line then
				Result.append (indent_string)
			end
			Result.append ("create ")
			if target = Void then
				Result.append_character ('{')
				Result.append (target_type.eiffel_name)
				Result.append_character ('}')				
			else
				Result.append (target)
			end
			Result.append_character ('.')
			Result.append ("make")
			if arguments /= Void then
				from
					arguments.start
					if not arguments.after then
						Result.append (" (")
						Result.append (arguments.item.code)
						arguments.forth
					end
				until
					arguments.after
				loop
					Result.append (", ")
					Result.append (arguments.item.code)
					arguments.forth
				end
				if arguments.count > 0 then
					Result.append_character (')')
				end
			end
			if new_line then
				Result.append_character ('%N')
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := target_type
		end

feature {CODE_ASSIGN_STATEMENT, CODE_METHOD_RETURN_STATEMENT} -- Element Settings

	set_target (a_target: like target) is
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

invariant
	non_void_type: target_type /= Void 
	
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CODE_OBJECT_CREATE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------