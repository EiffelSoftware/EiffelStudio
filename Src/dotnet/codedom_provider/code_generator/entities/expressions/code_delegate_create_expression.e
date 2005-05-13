indexing 
	description: "Source code generator for delegate creation expression"
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

end -- class CODE_DELEGATE_CREATE_EXPRESSION

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