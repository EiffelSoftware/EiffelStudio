indexing 
	description: "Source code generator for method reference expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_ROUTINE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_routine: like routine; a_target: like target) is
			-- Initialize instance.
		require
			non_void_routine: a_routine /= Void
			non_void_target: a_target /= Void
		do
			routine := a_routine
			target := a_target
		ensure
			routine_set: routine = a_routine
			target_set: target = a_target
		end
		
feature -- Access

	routine: STRING
			-- Routine name
			
	target: CODE_EXPRESSION
			-- Target expression
			
	code: STRING is
			-- | Result := "`target_object'.`routine_name'"
			-- | OR		:= "`routine_name'" if `target_object.name' is_equal "Current" or "current_type.name"
			-- | OR		:= "feature {`target_object'}.`routine_name'" if typeof `target_object' is CODE_TYPE_REFERENCE_EXPRESSION.
			
			-- | Set `dummy_variable' to true if `returned_type_routine' /= Void
			-- Eiffel code of routine reference expression
		local
			l_type_ref_exp: CODE_TYPE_REFERENCE_EXPRESSION
			l_base: CODE_BASE_REFERENCE_EXPRESSION
		do
			create Result.make (120)
			l_base ?= target
			if l_base = Void then
				if member /= Void then
					if not is_current_generated_type (target.type) then
						l_type_ref_exp ?= target
						if l_type_ref_exp /= Void then
							Result.append ("feature {")
							Result.append (l_type_ref_exp.code)
							Result.append ("}.")
						else
							Result.append (target.code)
							Result.append (".")
						end
					end
					if Resolver.is_generated (member.implementing_type) then
						Result.append (member.eiffel_name)
					else
						Result.append (member.overloaded_eiffel_name)
					end
				end
			else
				l_base.set_type (type)
				Result := "Precursor"
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			if member /= Void then
				Result := member.result_type
			end
			if Result = Void then
				Result := None_type_reference
			end
		end
		
feature {NONE} -- Implementation

	member: CODE_MEMBER_REFERENCE is
			-- Corresponding member
		require
			in_generation: current_state = Code_generation
		local
			l_base: CODE_BASE_REFERENCE_EXPRESSION
		do
			if not member_searched then
				member_searched := True
				l_base ?= target
				if l_base = Void then
					internal_member := target.type.member_from_name (routine)
					if internal_member = Void then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, [routine, target.type.name])
					end
				end
			end
			Result := internal_member
		end
	
	internal_member: CODE_MEMBER_REFERENCE
			-- Cached `member'
	
	member_searched: BOOLEAN
			-- Was `member' called?

invariant
	non_void_routine: routine /= Void
	non_void_target: target /= Void
	
end -- class CODE_ROUTINE_REFERENCE_EXPRESSION

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