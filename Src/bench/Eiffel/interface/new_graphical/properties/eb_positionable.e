indexing
	description: "Objects that contains information about position shown in Eiffel Studio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_POSITIONABLE
	
feature -- Access

	position: like position_internal is
			-- Position in current object.
			-- Usually character position in text.
		do
			Result := position_internal
		end
	
	pos_container: like pos_container_internal is		
			-- Where current object is shown. i.e an editor
		do
			Result := pos_container_internal
		end
		
	previous_position: like position_internal is
			-- Possible previous position
		do
			Result := previous_position_internal
		end
			
	previous_pos_container: like pos_container_internal is
			-- Possible previous container
		do
			Result := previous_pos_container_internal
		end

feature -- Element Change

	set_position (p: like position_internal) is
			-- Set `previous_position' with `p'.
		require
			p_larger_than_zero: p >= 0
		do
			position_internal := p
		ensure
			position_set: position_internal = p
		end
		
	set_pos_container (a_container: like pos_container_internal) is
			-- Set `container' with `a_container'.
		do
			pos_container_internal := a_container
		ensure
			container_set: pos_container_internal = a_container
		end
		
	set_previous_position (p: like previous_position_internal) is
			-- Set `previous_position' with `p'.
		require
			p_larger_than_zero: p >= 0
		do
			previous_position_internal := p
		ensure
			position_set: previous_position_internal = p
		end
		
	set_previous_pos_container (a_container: like previous_pos_container_internal) is
			-- Set `container' with `a_container'.
		do
			previous_pos_container_internal := a_container
		ensure
			container_set: previous_pos_container_internal = a_container
		end
		
feature {NONE}

	position_internal : INTEGER
	
	pos_container_internal : ANY
	
	previous_position_internal : like position_internal
	
	previous_pos_container_internal : like pos_container_internal
	
end
