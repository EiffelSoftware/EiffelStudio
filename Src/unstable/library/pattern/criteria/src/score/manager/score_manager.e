note
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCORE_MANAGER

feature -- Access

	all_criteria: ITERABLE [TUPLE [name: detachable READABLE_STRING_GENERAL; criteria: READABLE_STRING_GENERAL]]
		deferred
		end

	remember_criteria (a_name: detachable READABLE_STRING_GENERAL; a_criteria: READABLE_STRING_GENERAL)
		deferred
		ensure
			criteria_remembered: a_name /= Void implies attached criteria_by_name (a_name)
		end

	forget_criteria (a_name: READABLE_STRING_GENERAL)
		deferred
		ensure
			criteria_forgotten: criteria_by_name (a_name) = Void
		end

	criteria_by_name (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_GENERAL
		do
			across
				all_criteria as f
			until
				Result /= Void
			loop
				if attached f.name as n and then n.same_string (a_name) then
					Result := f.criteria
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
