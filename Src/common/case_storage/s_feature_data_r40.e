indexing

	description: 
		"Updated version of S_FEATURE_DATA for versions 3.4.0 and up.";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_DATA_R340

inherit

	S_FEATURE_DATA
		redefine
			body, set_body, 
			is_reversed_engineered, set_reversed_engineered,
			is_new_since_last_re, is_deleted_since_last_re
		end

creation

	make

feature -- Properties

	is_deleted_since_last_re: BOOLEAN is
		do
			Result := status_handler.is_deleted_since_last_re (status)
		end

	is_new_since_last_re: BOOLEAN is
		do
			Result := status_handler.is_new_since_last_re (status)
		end

	is_reversed_engineered: BOOLEAN
			-- Is Current class reversed engineered?

	body: S_FREE_TEXT_DATA
			-- Body (with locals and recue) if routine or constant


feature -- Setting

	set_body (b: like body) is
			-- Set body to `b'.
		do
			body := b
		end

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do
			is_reversed_engineered := True
		ensure then
			is_reversed_engineered: is_reversed_engineered
		end

	set_status (s: like status) is
			-- Set status to `s'.
		do
			status := s
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

end -- class S_FEATURE_DATA_R340
