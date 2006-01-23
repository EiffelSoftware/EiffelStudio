indexing

	description: "General separator implementation"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SEPARATOR_I 

inherit

	PRIMITIVE_I
	
feature -- Status report

	is_horizontal: BOOLEAN is
			-- Is separator oriented horizontal?
		deferred
		end;

feature -- Status setting

	set_double_dashed_line is
			-- Set separator display to be double dashed line.
		deferred
		end;

	set_double_line is
			-- Set separator display to be double line.
		deferred
		end;

	set_horizontal (flag: BOOLEAN) is
			-- Set orientation of the scale to horizontal if `flag',
			-- to vertical otherwise.
		deferred
		ensure
			value_correctly_set: is_horizontal = flag
		end;

	set_no_line is
			-- Make current separator invisible.
		deferred
		end;

	set_single_dashed_line is
			-- Set separator display to be single dashed line.
		deferred
		end;

	set_single_line is
			-- Set separator display to be single line.
		deferred
		end

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




end -- class SEPARATOR_I

