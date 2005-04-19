indexing

	description: "Abstract description of a parent. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class PARENT_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like type; rn: like renaming; e: like exports;
		u: like undefining; rd: like redefining; s: like selecting; ek: like end_keyword) is
			-- Create a new PARENT AST node.
		require
			t_not_void: t /= Void
		do
			type := t
			renaming := rn
			exports := e
			undefining := u
			redefining := rd
			selecting := s
			end_keyword := ek
		ensure
			type_set: type = t
			renaming_set: renaming = rn
			exports_set: exports = e
			undefining_set: undefining = u
			redefining_set: redefining = rd
			selecting_set: selecting = s
			end_keyword_set: end_keyword = ek
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_parent_as (Current)
		end

feature -- Attributes

	type: CLASS_TYPE_AS
			-- Parent type

	renaming: EIFFEL_LIST [RENAME_AS]
			-- Rename clause

	exports: EIFFEL_LIST [EXPORT_ITEM_AS]
			-- Exports for parent

	redefining: EIFFEL_LIST [FEATURE_NAME]
			-- Redefining clause

	undefining: EIFFEL_LIST [FEATURE_NAME]
			-- Undefine clause

	selecting: EIFFEL_LIST [FEATURE_NAME]
			-- Select clause

	end_keyword: LOCATION_AS
			-- End of clause if any of the `rename', `export', `redefine', `undefine'
			-- and `select' is present

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := type.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			if end_keyword /= Void then
				Result := end_keyword
			else
				Result := type.end_location
			end
		end		
		
feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (exports, other.exports) and
				equivalent (redefining, other.redefining) and
				equivalent (renaming, other.renaming) and
				equivalent (selecting, other.selecting) and
				equivalent (type, other.type) and
				equivalent (undefining, other.undefining)
		end

feature -- Status report

	is_effecting: BOOLEAN is
			-- Is this parent clause redefining or undefining
			-- one or more features?
		do
			Result := undefining /= Void and then not undefining.is_empty
				and then redefining /= Void and then not redefining.is_empty
		end

end -- class PARENT_AS
