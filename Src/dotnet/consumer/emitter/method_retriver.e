indexing
	description: "Retrive methods associated to a property or an event."
	date: "$Date$"
	revision: "$Revision$"

class
	METHOD_RETRIEVER

feature -- Implementation

	property_getter (prop: PROPERTY_INFO): METHOD_INFO is
			-- Get `getter' of `prop' if it exists.
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := prop.get_get_method_boolean (True)
			end
		rescue
			retried := True
			retry
		end

	property_setter (prop: PROPERTY_INFO): METHOD_INFO is
			-- Get `setter' of `prop' if it exists.
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := prop.get_set_method_boolean (True)
			end
		rescue
			retried := True
			retry
		end

	event_adder (event: EVENT_INFO): METHOD_INFO is
			-- Get `adder' of `event' if it exists.
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := event.get_add_method_boolean (True)
			end
		rescue
			retried := True
			retry
		end

	event_remover (event: EVENT_INFO): METHOD_INFO is
			-- Get `remover' of `event' if it exists.
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := event.get_remove_method_boolean (True)
			end
		rescue
			retried := True
			retry
		end

	event_raiser (event: EVENT_INFO): METHOD_INFO is
			-- Get `raiser' of `event' if it exists.
		local
			retried: BOOLEAN
		do
			if not retried then
				Result := event.get_raise_method_boolean (True)
			end
		rescue
			retried := True
			retry
		end

end -- Class METHOD_RETRIVER