indexing

	description: "Data representing handles in the%
		%workarea of static diagrams.";
	date: "$Date$";
	revision: "$Revision $"

-- Abstraction of handles which build relations
class HANDLE_DATA

inherit

	COORD_XY_DATA
		undefine
			stone_type
		end

feature -- Properties

	shared: INTEGER;
			-- How many relations share this handle ?

	is_shared: BOOLEAN is
			-- Is current handle being shared by more
			-- than one relation?
		do
			Result := shared > 1
		end;

	is_being_used: BOOLEAN is
			-- Is current handle being used?
		do
			Result := shared > 0
		end ;

	stone_type: INTEGER is
			-- Stone type of Current
		do
			Result := Stone_types.handle_type
		end;


feature -- Setting

	set_shared (value: like shared) is
			-- Set shared to `value'.
		require
			value >= 0
		do
			shared := value
		ensure
			shared = value
		end -- set_shared

	set_from ( cl : LINKABLE_DATA ) is
		do
			from_link := cl
		end
		
	from_link : LINKABLE_DATA

invariant

	valid_shared: shared >= 0

end -- class HANDLE_DATA
