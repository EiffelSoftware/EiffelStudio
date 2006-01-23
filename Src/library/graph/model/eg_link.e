indexing
	description: "An EG_LINK connects two EG_LINKABLEs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_LINK

inherit
	EG_ITEM
		redefine
			default_create
		end
	
create
	make_with_source_and_target,
	make_directed_with_source_and_target
	
feature {NONE} -- Initialization

	default_create is
			-- Create an EG_LINK.
		do
			Precursor {EG_ITEM}
			create is_directed_change_actions
			is_directed_change_actions.compare_objects
		end

	make_with_source_and_target (a_source, a_target: like source) is
			-- Make a link connecting `a_source' with `a_target'.
		require
			source_not_void: a_source /= Void
			target_not_void: a_target /= Void
		do
			default_create
			source := a_source
			source.add_link (Current)
			target := a_target
			if a_source /= a_target then
				target.add_link (Current)
			end
			is_directed := False
		ensure
			source_set: source = a_source
			target_set: target = a_target
			not_is_directed: not is_directed
		end	
		
	make_directed_with_source_and_target (a_source, a_target: like source) is
			-- 	Make a directed link from `a_source' to `a_target'.
		require
			source_not_void: a_source /= Void
			target_not_void: a_target /= Void
		do
			make_with_source_and_target (a_source, a_target)
			is_directed := True
		ensure
			source_set: source = a_source
			target_set: target = a_target
			is_directed: is_directed
		end	

feature -- Status report

	is_directed: BOOLEAN
			-- Is the link directed from `source' to `target'?
			
	is_reflexive: BOOLEAN is
			-- Is the link reflexive?
		do
			Result := source = target
		ensure
			result_equal_source_equal_target: Result = (source = target)
		end
		
feature -- Status Settings

	set_is_directed (b: BOOLEAN) is
			-- Set `is_directed' to `b'.
		do
			if b /= is_directed then		
				is_directed := b	
				is_directed_change_actions.call (Void)
			end
		ensure
			set: is_directed = b
		end

feature -- Access

	source: EG_LINKABLE
			-- The source of the link.
			
	target: like source
			-- The target of the link.
			
	is_directed_change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Called when `is_directed' changes.
			
invariant
	source_not_void: source /= Void
	target_not_void: target /= Void
	is_directed_change_actions_not_void: is_directed_change_actions /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_LINK

