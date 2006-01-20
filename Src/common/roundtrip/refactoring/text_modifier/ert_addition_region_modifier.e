indexing
	description: "Region modifier for adding (prepending or appending) text to AST node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERT_ADDITION_REGION_MODIFIER

inherit
	ERT_REGION_MODIFIER
		undefine
			is_equal
		end

feature -- Vadility

	can_prepend (other_region: like region): BOOLEAN is
			-- Can `other_region' be prepended by some text according to current modifier?
		do
			Result := True
		end

	can_append (other_region: like region): BOOLEAN is
			-- Can `other_region' be appended by some text according to current modifier?
		do
			Result := True
		end

	can_replace (other_region: like region): BOOLEAN is
			-- Can `other_region' be replaced by some text according to current modifier?
		do
			Result := True
		end

	can_remove (other_region: like region): BOOLEAN is
			-- Can `other_region' be removed according to current modifier?
		do
			Result := True
		end

	is_text_available (other_region: like region): BOOLEAN is
			-- Is text of `other_region' available according to current modifier?
		do
			Result := True
		end

feature -- Status reporting

	is_prepended_to (a_index: INTEGER): BOOLEAN is
			-- Dose current modifier prepend to `a_index'?
		require
			a_index_not_negative: a_index > 0
		deferred
		end

	is_appended_to (a_index: INTEGER): BOOLEAN is
			-- Dose current modifier append to `a_index'?
		require
			a_index_not_negative: a_index > 0
		deferred
		end

feature

	text: STRING
			-- Text to be prepended/appended

invariant

	text_not_void: text /= Void

end
