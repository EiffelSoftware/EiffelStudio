indexing
	description: "The implementation of a centered bulletin; %
				% use the `set_size' in the vision class to %
				% center the elements."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class

	CENTERED_BULLETIN_IMP

inherit

	CENTERED_BULLETIN_I
		select
			set_size
		end

	BULLETIN_IMP
		rename
			set_size as implementation_set_size
		redefine
			make
		end

creation

	make

feature -- Initialization

	make (a_bulletin: CENTERED_BULLETIN; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Initialize.
		do
			{BULLETIN_IMP} Precursor (a_bulletin, man, oui_parent)
			parent_bulletin := a_bulletin
		end

	set_size (new_width, new_height: INTEGER) is
			-- Call `parent_bulletin' `set_size', where the center
			-- position is computed.
		do
			parent_bulletin.set_size (new_width, new_height)
		end

	parent_bulletin: CENTERED_BULLETIN
			-- Bulletin of which `Current' is the implementation.

end -- class CENTERED_BULLETIN_IMP
