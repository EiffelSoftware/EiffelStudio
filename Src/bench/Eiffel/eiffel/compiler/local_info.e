indexing
	description: "Info about local variable of a feature"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_INFO 
	
feature -- Access

	position: INTEGER
			-- Position of the local in the sequence of local
			-- declarations

	type: TYPE_A
			-- Local type

	actual_type: TYPE_A is
			-- Actual type of `type'.
		require
			type_exists: type /= Void
		do
			Result := type.actual_type
		end

feature -- Setting

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		require
			valid_index: i > 0
		do
			position := i
		ensure
			position_set: position = i
		end

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t
		end

end
