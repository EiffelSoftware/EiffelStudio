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

feature -- Access

	associated_class (reference_class: CLASS_I): CLASS_I is
			-- Compiled class associated with `type'.
		do
			Result := type.associated_eiffel_class (reference_class)
		end

feature -- Compiled parent computation

	parent_c: PARENT_C is
			-- Compiled version of a parent. The second pass needs:
			-- 1. Internal name for features, that means infix/prefix
			--	features must have a string name
			-- 2. Search table for renaming, redefining, defining and
			--	selecting clauses (which are more efficient than
			--	simple fixed lists for queries).
		local
			renaming_c: HASH_TABLE [STRING, STRING]
			rename_pair: RENAME_AS
			old_name, new_name: FEATURE_NAME
			vhrc2: VHRC2
			export_adapt: EXPORT_ADAPTATION
			s: STRING
		do
			create Result
			Result.set_parent_type (type.actual_type)
			if exports /= Void then
				from
					create export_adapt.make (5)
					Result.set_exports (export_adapt)
					exports.start
				until
					exports.after
				loop
					exports.item.update (export_adapt, Result)
					exports.forth
				end
			end
			if renaming /= Void then
				from
					create renaming_c.make (renaming.count)
					Result.set_renaming (renaming_c)
					renaming.start
				until
					renaming.after
				loop
					rename_pair := renaming.item
					old_name := rename_pair.old_name
					new_name := rename_pair.new_name
					s := old_name.internal_name
					if renaming_c.has (s) then
						create vhrc2
						vhrc2.set_class (System.current_class)
						vhrc2.set_parent (Result.parent)
						vhrc2.set_feature_name (old_name.internal_name)
						vhrc2.set_location (old_name.start_location)
						Error_handler.insert_error (vhrc2)
					else
						renaming_c.put (new_name.internal_name, s)
					end

					renaming.forth
				end
			end
			if redefining /= Void then
				Result.set_redefining (search_table (redefining, Redef))
			end
			if undefining /= Void then
				Result.set_undefining (search_table (undefining, Undef))
			end
			if selecting /= Void then
				Result.set_selecting (search_table (selecting, Selec))
			end
		end

	search_table (clause: like redefining; flag: INTEGER): SEARCH_TABLE [STRING] is
			-- Conversion of `clause' into a search table
		require
			clause_exists: clause /= Void
		local
			vdrs3: VDRS3
			vmss3: VMSS3
			vdus4: VDUS4
			s: STRING
		do
			from
				create Result.make (clause.count)
				clause.start
			until
				clause.after
			loop
				s := clause.item.internal_name;	
				if Result.has (s) then
						-- Twice the same name in a parent clause
					inspect
						flag
					when Redef then
						create vdrs3
					when Undef then
						create vdus4
						vdrs3 := vdus4
					when Selec then
						create vmss3
						vdrs3 := vmss3
					else
					end
					vdrs3.set_class (System.current_class)
					vdrs3.set_parent_name (type.class_name)
					vdrs3.set_feature_name (clause.item.internal_name)
					vdrs3.set_location (clause.item.start_location)
					Error_handler.insert_error (vdrs3)
				else
					Result.put (s)
				end
	
				clause.forth
			end
		end

feature -- Status report

	is_effecting: BOOLEAN is
			-- Is this parent clause redefining or undefining
			-- one or more features?
		do
			Result := undefining /= Void and then not undefining.is_empty
				and then redefining /= Void and then not redefining.is_empty
		end

feature {NONE} -- Implementation

	Redef: INTEGER is 1
	Undef: INTEGER is 2
	Selec: INTEGER is 3

end -- class PARENT_AS
