indexing

	description: 
		"Updated version of S_FEATURE_DATA for versions 3.4.0 and up.";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_DATA_R40

inherit

	S_FEATURE_DATA
		redefine
			body, set_body, 
			is_reversed_engineered,set_reversed_engineered,
			is_new_since_last_re, is_deleted_since_last_re,
			is_once, is_constant
		end

creation

	make

feature -- Properties

	is_constant: BOOLEAN is
			-- Is Current feature a constant ?
		do
			Result := status_handler.is_constant (status)
		end

	is_deleted_since_last_re: BOOLEAN is
		do
			Result := status_handler.is_deleted_since_last_re (status)
		end

	is_new_since_last_re: BOOLEAN is
		do
			Result := status_handler.is_new_since_last_re (status)
		end

	is_once: BOOLEAN is
			-- Is Current feature a once?
		do
			Result := status_handler.is_once (status)
		end

	is_reversed_engineered: BOOLEAN is
			-- Is Current class reversed engineered?
		do
			Result := status_handler.is_reversed_engineered (status)
		end

	body: S_FEATURE_BODY
			-- Body (with locals and recue) if routine or constant


feature -- Setting

	set_body (b: LINKED_LIST [ STRING ] ) is
			-- Set body to `b'.
		do
			if b/= Void then
				!! body.make ( b.count)
				from	
					b.start
				until
					b.after
				loop
					body.put_i_th(b.item, b.index)
					b.forth
				end
			else
				!! body.make (1)
			end
		end

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do
			status := status_handler.set_reversed_engineered (status)
		ensure then
			is_reversed_engineered: is_reversed_engineered
		end

	set_status (s: like status) is
			-- Set status to `s'.
		do
			status := s
		end

    set_is_constant is
        do
            status := status_handler.set_is_constant (status)
        end

    set_is_once is
        do
            status := status_handler.set_is_once (status)
        end

feature {FEATURE_DATA} -- Implementation

	status_handler: FEATURE_STATUS_HANDLER is
			-- Used to encode/decode boolean properties in `status'.
		once
			!! Result
		end

feature {NONE} -- Implementation

	status: INTEGER
			-- Used to represent many boolean values (we should use
			-- a bit mask, which would be _much_ more convenient but 
			-- it's not reliable enough, so we use the `status_handler').

end -- class S_FEATURE_DATA_R40





