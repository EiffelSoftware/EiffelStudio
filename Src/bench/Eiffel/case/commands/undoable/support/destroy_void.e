indexing

	description:
		"";
	date: "$Date$";
	revision: "$Revision$"

class DESTROY_VOID

	inherit
		DESTROY

	feature
		--from DESTROY

		name	: STRING	is "Destroy Nothing"

		redo	is
		do
		end
	
		undo	is
		do
		end

		update	is
		do
		end

end -- class DESTROY_VOID
