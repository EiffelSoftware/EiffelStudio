indexing
	description: "Identifier for an e_feature.%
				%Trouble with e_feature is is_equal and hash_code,%
				%which rely only on the name of the feature."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_ID

inherit
	HASHABLE
		redefine
			is_equal
		end

create
	make

feature -- Initialization

	make (f: E_FEATURE) is
			-- Create `Current' depending on `f'.
		require
			valid_feature: f /= Void
		do
			e_feature := f
		end

feature -- Access

	hash_code: INTEGER is
			-- Hash code for `Current'.
			-- Depend on both the feature name and its associated class.
		do
			Result := e_feature.hash_code + e_feature.associated_class.hash_code
		end

	e_feature: E_FEATURE
			-- Feature represented by `Current'.

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

	is_equal (other: like Current): BOOLEAN is
			-- Does `Current' represent the same feature as `other'
			-- (same name, same associated class).
		do
			Result := 	other.e_feature.is_equal (e_feature) and then
						other.e_feature.associated_class.is_equal (
							e_feature.associated_class)
		end

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	valid_feature: e_feature /= Void

end -- class EB_FEATURE_ID
