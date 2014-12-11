note
	description: "Mathematical models."
	author: "Nadia polikarpova."

deferred class
	MML_MODEL

feature -- Comparison

	is_model_equal alias "|=|" (other: MML_MODEL): BOOLEAN
			-- Is this model mathematically equal to `other'?
		deferred
		end

	is_model_non_equal alias "|/=|" (other: MML_MODEL): BOOLEAN
			-- Is this model mathematically equal to `other'?
		do
			Result := not is_model_equal (other)
		end

	frozen model_equals (v1, v2: detachable ANY): BOOLEAN
			-- Are `v1' and `v2' mathematically equal?
			-- If they are models use model equality, otherwise reference equality.
		do
			if attached {MML_MODEL} v1 as m1 and attached {MML_MODEL} v2 as m2 then
				Result := m1 |=| m2
			else
				Result := v1 = v2
			end
		end
end
