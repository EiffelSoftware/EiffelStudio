indexing

	description: 
		"Specify undoable actions to move a figure with%
		%others in a list (movables_list).";
	date: "$Date$";
	revision: "$Revision $"

deferred class MOVABLE_U

inherit

	SINGLE_MOVE_U
		export
			{MULTIPLE_MOVE_U} redo, undo, entity
		end;
	COMPARABLE
		undefine
			is_equal
		end;

feature -- Access

	precedence: INTEGER is
		local
			linkable: LINKABLE_DATA;
			handle_d: HANDLE_DATA
		do
			linkable ?= entity;
			handle_d ?= entity;
			if handle_d /= Void then
				Result := 1
			elseif linkable /= Void then
				Result := 2
			end
		end;

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is 'Current' less than 'other' ?
		do
			Result := precedence < other.precedence
		end -- "<"

feature {NONE} -- Implementation

	name: STRING is ""

	graphical_update is
		local
			a_handle: HANDLE_DATA
		do
			a_handle ?= entity;
			if a_handle /= Void then
				workareas.move_handle (a_handle)
			else
				workareas.change_data (entity)
			end
		end -- graphical_update

end -- class MOVABLE_U
