indexing
	description: "Abstract representation of a feature that can be encapsulated"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCAPSULATED_I

inherit
	FEATURE_I
		redefine
			can_be_encapsulated, generation_class_id,
			to_melt_in, to_generate_in, transfer_to
		end

feature -- Access

	can_be_encapsulated: BOOLEAN is True
			-- Current feature can be encapsulated (eg attribute or
			-- constantn definition with a deferred routine)

	generate_in: INTEGER
			-- Class id where an equivalent feature has to be generated
			-- `0' means no need for an encapsulation

	generation_class_id: INTEGER is
			-- Id of the class where the feature has to be generated in
		do
			if generate_in /= 0 then
				Result := generate_in
			else
				Result := written_in
			end
		end

feature -- Status

	to_melt_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := to_generate_in (a_class)
		end

	to_generate_in (a_class: CLASS_C): BOOLEAN is
			-- Has the current feature in class `a_class" ?
		do
			Result := a_class.class_id = generate_in
		end

feature -- Element change

	transfer_to (other: like Current) is
			-- Transfer data from `Current' to `other'.
		do
			Precursor {FEATURE_I} (other)
			if generate_in > 0 then
				other.set_generate_in (generate_in)
			end
		end

feature -- Setting

	set_generate_in (class_id: INTEGER) is
			-- Assign `class_id' to `generate_in'.
		require
			valid_class_id: class_id > 0
		do
			generate_in := class_id
		ensure
			generate_in_set: generate_in = class_id
		end

end -- class ENCAPSULATED_I
