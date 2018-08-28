note
	description: "Hahsable object."
	author: "Nadia Polikarpova"

deferred class
	V_HASHABLE

inherit
	ANY
		undefine
			is_model_equal,
			lemma_transitive
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code.
		require
			reads (ownership_domain, subjects)
		deferred
		ensure
			Result = hash_code_
		end

feature -- Specification

	hash_code_: INTEGER
			-- Hash code in terms of abstract state.
		note
			explicit: contracts
			status: ghost
		require
			reads (Current)
		deferred
		ensure
			non_negative: 0 <= Result
		end

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost
			explicit: contracts
		deferred
		ensure then
			agrees_with_hash: Result implies hash_code_ = other.hash_code_
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
