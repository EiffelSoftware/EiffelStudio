indexing
	description: "Eiffel-MATISSE Binding";
	date: "$Date$";
	revision: "$Revision$"

class 
	MT_STREAM

inherit
	MT_CONSTANTS
		export 
			{NONE} all
		end

	MT_STREAM_EXTERNAL

	LINEAR [MT_STORABLE]
		redefine
			exhausted
		end
	
feature -- Access

	next_object: MT_OBJECT is
			-- Get Next object in stream.
			-- This function is provided just because of backward compatibility.
		do
			forth
			if not after then
				Result := item
			end
		end
		
	item: MT_STORABLE is
		do
			Result := current_db.eif_object_from_oid (current_oid)
		end
	
	index: INTEGER

feature -- Status report

	after: BOOLEAN is
		do
			Result := current_oid = End_of_stream
		end

	is_empty: BOOLEAN is
		do
			Result := index = 0 and after
		end
	
	exhausted: BOOLEAN is
		do
			Result := after
		end

	started: BOOLEAN is
		do
			Result := current_oid /= Current_object_not_retrieved
		end
				
feature -- Cursor movement

	start is
		do
			if current_oid = Current_object_not_retrieved then
				current_oid := c_next_object (c_stream)
			end
			if current_oid /= End_of_stream then
				index := 1
			end
		end
	
	finish is
		local
			an_oid: INTEGER
		do
			if not after then
				from
				until
					an_oid = End_of_stream
				loop
					an_oid := c_next_object (c_stream)
					if an_oid /= End_of_stream then
						current_oid := an_oid
					end
				end
			end
		end
	
	forth is
		do
			current_oid := c_next_object (c_stream)
			index := index + 1
		end
feature -- Close

	close is
			-- Close Stream
		do
			c_close_stream (c_stream)
		end

feature {NONE} -- Implementation

	c_stream: INTEGER 
		-- MtStream (type has changed since MATISSE4.0).

feature {NONE}

	current_oid: INTEGER
	
	End_of_stream: INTEGER is -1
	
	Current_object_not_retrieved: INTEGER is 0

invariant
	stream_c_pointer_not_void: c_stream /= Void
	
end -- class MT_STREAM
