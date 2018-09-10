note
	description: "A sample hashable object."

class
	EB2_KEY

inherit
	V_HASHABLE
		redefine
			is_model_equal
		end

create
	set_value

feature -- Access

	value: INTEGER
			-- State.

	hash_code: INTEGER
			-- Hash code.
		do
			Result := value.abs
		end

feature -- Modification

	set_value (v: INTEGER)
			-- Set `value' to `v'.
		do
			value := v
		ensure
			value = v
		end

feature -- Specification		

	hash_code_: INTEGER
			-- Hash code in terms of abstract state.
		note
			status: functional, ghost
		do
			Result := value.abs
		end

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost
			explicit: contracts
		do
			Result := value.abs = other.value.abs
		ensure then
			definition: Result = (value.abs = other.value.abs)
		end

	lemma_transitive (x: like Current; ys: MML_SET [like Current])
			-- Property that follows from transitivity of `is_model_equal'.
		note
			status: lemma
		do
		end

end
