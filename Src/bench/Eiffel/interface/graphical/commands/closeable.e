indexing
	description: "Abstract notion of a closeable window.";
	date: "$Date$";
	revision: "$Revision$"

deferred class CLOSEABLE

feature {NONE} -- Implementation

	close is
			-- Close Current.
		deferred
		end;

end -- class CLOSEABLE
