indexing

	description: 
		"Ancestor of arrow heads used to draw relations.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EC_ARROW_HEAD

inherit

	CONSTANTS;
	EC_CLOSED_FIG

feature -- Setting

	build (first_point, last_point : EC_COORD_XY) is
			-- Build an arrow's head
		deferred
		end; -- build

	set_drawing_attributes is
			-- set the drawing attributes for arrow's head
		do
			!!path.make;
			!!interior.make;
		end -- set_drawing_attributes

	set_color (a_color: EV_COLOR) is
		require
		--	valid_color: a_color /= Void
		do
		--	path.set_foreground_color (a_color);
		--	interior.set_foreground_color (a_color);	
		end;

feature -- Properties

	type : INTEGER
			-- 1 -> inheritance
			-- 2 -> client-supplier
			-- 3 -> aggregation

feature -- Access

	base (first_point, last_point : EC_COORD_XY) : EC_COORD_XY is
			-- Base intersection point between arrow's body and arrow's head
			-- 'first_point' and 'last_point' are the extremity of
			-- arrow's body
		require
			has_first : first_point /= Void;
			has_last : last_point /= Void
		deferred
		end -- base


end -- class EC_ARROW_HEAD
