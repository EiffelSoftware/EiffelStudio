indexing
	description: "Retrive methods associated to a property or an event."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	METHOD_RETRIEVER

inherit
	SHARED_LOGGER
		export
			{NONE} all
		end

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
			debug ("log_exceptions")
				log_last_exception
			end
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
			debug ("log_exceptions")
				log_last_exception
			end
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
			debug ("log_exceptions")
				log_last_exception
			end
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
			debug ("log_exceptions")
				log_last_exception
			end
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
			debug ("log_exceptions")
				log_last_exception
			end
			retried := True
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- Class METHOD_RETRIVER