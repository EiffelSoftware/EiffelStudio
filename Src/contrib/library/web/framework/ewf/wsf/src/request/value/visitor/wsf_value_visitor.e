note
	description: "[
			Component to visit WSF_VALUE
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_VALUE_VISITOR

feature -- Visitor

	safe_process_value (v: detachable WSF_TABLE)
		do
			if v /= Void then
				v.process (Current)
			end
		end

	process_table (v: WSF_TABLE)
		require
			v_attached: v /= Void
		deferred
		end

	process_string (v: WSF_STRING)
		require
			v_attached: v /= Void
		deferred
		end

	process_multiple_string (v: WSF_MULTIPLE_STRING)
		require
			v_attached: v /= Void
		deferred
		end

	process_any (v: WSF_ANY)
		require
			v_attached: v /= Void
		deferred
		end

	process_uploaded_file (v: WSF_UPLOADED_FILE)
		require
			v_attached: v /= Void
		deferred
		end

;note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
