indexing
	description: "Reference description"
	date: "$Date$"
	revision: "$Revision$"

class REFERENCE_DESC 

inherit
	ATTR_DESC
		rename
			Reference_level as level
		redefine
			same_as
		end

feature -- Access

	type_i: TYPE_I
			-- Class type of a reference attribute

	sk_value: INTEGER is
		do
			Result := Sk_ref
		end

feature -- Settings

	set_type_i (t: like type_i) is
			-- Assign `t' to `type_i'.
		require
			t_not_void: t /= Void
		do
			type_i := t
		ensure
			set: type_i = t
		end

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			l_ref: REFERENCE_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				l_ref ?= other
				Result := (l_ref /= void) and then (type_i /= Void and l_ref.type_i /= Void) and then
					type_i.same_as (l_ref.type_i)
			end
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.putstring ("SK_REF")
		end

feature -- Debug

	trace is
		do
			io.error.putstring (attribute_name)
			io.error.putstring ("[REFERENCE]")
		end

end
