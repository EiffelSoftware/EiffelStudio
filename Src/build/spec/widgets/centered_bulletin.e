indexing
	description: "A bulletin whose elements are all centered by %
				% calling `set_size'."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

deferred class
	CENTERED_BULLETIN

inherit 

	BULLETIN
		redefine
			create_ev_widget,
			set_size,
			set_width,
			set_height,
			implementation
		end

feature

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a bulletin with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier := clone (a_name);
			!CENTERED_BULLETIN_IMP! implementation.make (Current, man, a_parent);
			implementation.set_widget_default;
			set_default
		end;

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set width and height to `new_width'
			-- and `new_height'.
		do
			implementation.implementation_set_size (new_width, new_height)
		end

	set_width (new_width:INTEGER) is
			-- Set width to `new_width'.
		do
			implementation.implementation_set_width (new_width)
		end

	set_height (new_height: INTEGER) is
			-- Set height to `new__height'.
		do
			implementation.implementation_set_height (new_height)
		end

	implementation: CENTERED_BULLETIN_I

	is_centered: BOOLEAN is
			-- Is this bulletin centered?
		deferred
		end

end -- class CENTERED_BULLETIN
