indexing
	description: "Provide an interface to open a stream";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	MT_STREAMABLE 

feature {NONE}  -- Access 

	open_stream: MT_STREAM is
		deferred
		end

end -- class MT_STREAMABLE
