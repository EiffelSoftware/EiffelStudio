indexing 
	description: "Source code generator for delegate invoke expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_DELEGATE_INVOKE_EXPRESSION

inherit
	CODE_EXPRESSION
	
create
	make

feature {NONE} -- Initialization

	make (a_target: CODE_EXPRESSION; a_arguments: LIST [CODE_EXPRESSION]) is
			-- Initialize instance.
		do
			arguments := a_arguments
			target := a_target
		ensure
			arguments_set: arguments = a_arguments
			target_set: target = a_target
		end
		
feature -- Access

	arguments: LIST [CODE_EXPRESSION]
			-- Delegate arguments
	
	target: CODE_EXPRESSION
			-- Target object
			
	code: STRING is
			-- | Result := `target_object' (`arguments', ...)
			-- Eiffel code of delegate invoke expression
			-- NOT SUPPORTED YET !!!
		do
			create Result.make (120)
			Result.append ("must be done (CODE_DELEGATE_INVOKE_EXPRESSION)")
			Result.append (target.code)
			Result.append (" (")
			from
				arguments.start
				if not arguments.after then
					Result.append (arguments.item.code)
				end
				arguments.forth
			until
				arguments.after
			loop
				Result.append (", ")
				Result.append (arguments.item.code)
				arguments.forth
			end
			Result.append_character (')')
			Event_manager.raise_event ({CODE_EVENTS_IDS}.not_supported, ["delegate invoke expression"])
		end
		
feature -- Status Report
	
	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := target.type
		end
	
invariant
	non_void_arguments: arguments /= Void
	non_void_target: target /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class CODE_DELEGATE_INVOKE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------