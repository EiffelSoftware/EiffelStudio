indexing

	description: "View information for inheritance relationships.";
	date: "$Date$";
	revision: "$Revision $"

class INHERIT_VIEW

inherit

	RELATION_VIEW
		rename
			make as relation_make,
			update_data as relation_update_data
		end;
	RELATION_VIEW
		rename
			make as relation_make
		redefine
			update_data
		select
			update_data
		end

creation

	make

feature -- Initialization

	make (relation_data: INHERIT_DATA) is
			-- Initialize Current with `relation_data'.
		do
			update_from (relation_data);
			relation_make (relation_data)
		end;

feature -- Properties

	is_implementation: BOOLEAN;
			-- Is this link a result of the implementation
			--| False implies for inheritance relationship
			--| that the ancestor was inherited for
			--| implementation reason (not abstraction)

feature -- Setting

	update_from (relation_data: INHERIT_DATA) is
			-- Update Current from `relation_data'.
		do
			is_implementation := relation_data.is_implementation
		ensure
			updated: is_implementation = relation_data.is_implementation
		end;

	update_data (relation_data: INHERIT_DATA) is
			-- Update `relation_data' from Current.
		do
			relation_data.set_implementation (is_implementation);
			relation_update_data (relation_data);
		end;

end -- class INHERIT_VIEW
