indexing
	description: "A picture color button whose borders are drawn %
				% when the mouse pointer enter the button.";
	date: "$Date$";
	revision: "$Revision$"

class
	ACTIVE_PICT_COLOR_B

inherit
	PICT_COLOR_B

creation
	make, make_unmanaged

feature -- Status

	active: BOOLEAN
			-- Is button active?
		do
		end

	set_active (flag: BOOLEAN) is
			-- Set `active' to `flag'.
		do
		end

end -- class ACTIVE_PICT_COLOR_B
