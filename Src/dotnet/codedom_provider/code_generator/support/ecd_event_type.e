indexing
	description: "Objects that represent the different type of events."

class
	EVENT_TYPE

feature {NONE} -- Implementation

	adder: STRING is "add_"
			-- Adder event.

	remover: STRING is "remove_"
			-- Remover event.

	raiser: STRING is "raise_"
			-- Raiser event.

feature -- Status Repport

	valid_event_type (an_event_type: STRING): BOOLEAN is
			-- Is `an_event_type' valid?
		require
			non_void_an_event_type: an_event_type /= Void
		do
			Result := an_event_type.is_equal (adder) or an_event_type.is_equal (remover) or an_event_type.is_equal (raiser)
		end
		
end -- class EVENT_TYPE
