indexing

	description: "Abstract notion of a view.";
	date: "$Date$";
	revision: "$Revision $"

deferred class VIEW

feature -- Setting

	update_data (data: DATA) is
			-- Update `data' with Current.
		require
			valid_data: data /= Void
		deferred
		end;

end -- class VIEW
