indexing
	description: "Attribute description of generic type"
	date: "$Date$"
	revision: "$Revision$"

class GENERIC_DESC

inherit
	ATTR_DESC
		redefine
			has_formal, instantiation_in, same_as
		end

feature -- Access

	type_i: TYPE_I
		-- Type having some generic parameters	

	sk_value: INTEGER is
			-- Sk value
		do
			check False end
		end

	level: INTEGER is 
			-- Sort level
		do
			Result := Formal_level
		end

feature -- Settings

	set_type_i (t: TYPE_I) is
			-- Assign `t' to `type_i'.
		require
			t_not_void: t /= Void
		do
			type_i := t
		ensure
			type_i_set: type_i = t
		end

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_generic: GENERIC_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				other_generic ?= other
				Result := (other_generic /= Void) and then identical_types (other_generic.type_i)
			end
		end

	identical_types (otype : TYPE_I) : BOOLEAN is
			-- Are `type_i' and `otype' identical?
		do
			if type_i = Void then
				Result := (otype = Void)
			else
				if otype /= Void then
					Result := type_i.is_identical (otype) and then
							  otype.is_identical (type_i)
				end
			end
		end

feature -- Status report

	has_formal: BOOLEAN is True
			-- Has the current description a formal generic one ?

feature -- Instantiation

	instantiation_in (class_type: CLASS_TYPE): ATTR_DESC is
			-- Instantiation of the current description in		
			-- `class_type'.
		local
			gen_type: GEN_TYPE_I
			l_type: TYPE_I
			l_ref: REFERENCE_DESC
			l_exp: EXPANDED_DESC
		do
			gen_type ?= class_type.type
			l_type := type_i.instantiation_in (gen_type)
			Result := l_type.description
			l_ref ?= Result
			if l_ref /= Void then
				if type_i.is_formal then
					if l_type.is_reference then
						l_ref.set_type_i (type_i)
					end
				else
					l_ref.set_type_i (l_type)
				end
			end
			l_exp ?= Result
			if l_exp /= Void then
				if type_i.is_formal then
					if l_type.is_reference then
						l_exp.set_type_i (type_i)
					end
				else
					l_exp.set_type_i (l_type)
				end
			end

			Result.set_feature_id (feature_id)
			Result.set_attribute_name (attribute_name)
			Result.set_rout_id (rout_id)
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Useless
		do
			check False end
		end

feature -- Debug

	trace is
			-- Debug purpose
		do
			io.error.putstring (attribute_name)
			io.error.putstring ("Generic desc: ")
			type_i.trace
		end

end
