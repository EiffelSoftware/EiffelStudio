indexing 
	description: "Source code generator for delegate creation expression"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"
	
class
	CODE_DELEGATE_CREATE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_delegate_type: like delegate_type; a_method: like method; a_target: like target) is
			-- Initialize `delegate_type', `method_name' and `target'.
		require
			non_void_delegate_type: a_delegate_type /= Void
			non_void_method: a_method /= Void
			non_void_target: a_target /= Void
		do
			delegate_type := a_delegate_type
			method := a_method
			target := a_target
		ensure
			delegate_type_set: delegate_type = a_delegate_type
			method_set: method = a_method
			target_set: target = a_target
		end
		
feature -- Access

	delegate_type: CODE_TYPE_REFERENCE
			-- Type of delegate to create
	
	target: CODE_EXPRESSION
			-- Target object
			
	method: STRING
			-- method name
	
	code: STRING is
			-- | Result := "create {`delegate_type'}.constructor_name (`target_object.expression', $`method_name')"
			-- Eiffel code of delegate create expression
		local
			l_member: CODE_MEMBER_REFERENCE
			l_type: CODE_TYPE_REFERENCE
		do
			create Result.make (160)
			
			if new_line then
				Result.append (indent_string)
			end
			Result.append ("create")
			Result.append (" {")
			Result.append (delegate_type.eiffel_name)
			Result.append ("}.make (")
			Result.append (target.code)
			Result.append (", $")
			l_type := target.type
			l_member := l_type.member_from_name (method)
			if l_member /= Void then
				Result.append (l_member.eiffel_name)
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, [method, l_type.name])
			end
			Result.append_character (')')
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := delegate_type
		end

invariant
	non_void_method: method /= Void
	non_void_delegate_type: delegate_type /= Void
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
end -- class CODE_DELEGATE_CREATE_EXPRESSION

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