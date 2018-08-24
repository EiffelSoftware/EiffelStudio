note
	description: "Hahsable object."

deferred class
	F_HS_HASHABLE

inherit
	ANY
		undefine
			is_model_equal,
			lemma_transitive
		end

feature -- Access

	hash_code: INTEGER
			-- Hash code.
		note
			explicit: contracts
			status: ghost
		require
			closed
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
end
