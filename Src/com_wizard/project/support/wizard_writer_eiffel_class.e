indexing
	description: "Eiffel Class writer"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class 
	WIZARD_WRITER_EIFFEL_CLASS

inherit
	WIZARD_WRITER

	WIZARD_WRITER_FEATURE_CLAUSES

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize writer.
		do
			description := Default_description
			create {LINKED_LIST [WIZARD_WRITER_INHERIT_CLAUSE]} inherit_clauses.make
			create {LINKED_LIST [STRING]} creation_routines.make
			create features.make (10)
			create {LINKED_LIST [WIZARD_WRITER_ASSERTION]} invariants.make
		end

feature -- Access
	
	generated_code: STRING is
			-- Generated code
		local
			an_integer: INTEGER
		do
			Result := clone (indexing_keyword)
			Result.append (New_line_tab)
			Result.append (Description_keyword)
			Result.append (Colon)
			Result.append (Space)
			Result.append (Double_quote)
			Result.append (description)
			Result.append (Double_quote)
			Result.append (New_line_tab)
			Result.append (Note_keyword)
			Result.append (Colon)
			Result.append (Space)
			Result.append (Wizard_note)
			Result.append (New_line)
			Result.append (New_line)
			if is_deferred then
				Result.append (Deferred_keyword)
				Result.append (Space)
			end
			Result.append (Class_keyword)
			Result.append (New_line_tab)
			Result.append (class_name)
			Result.append (New_line)
			Result.append (New_line)
			if not inherit_clauses.is_empty then
				Result.append (Inherit_keyword)
			end
			from
				inherit_clauses.start
			until
				inherit_clauses.after
			loop
				Result.append (New_line)
				Result.append (inherit_clauses.item.generated_code)
				Result.append (New_line)
				inherit_clauses.forth
			end
			if not inherit_clauses.is_empty then
				Result.append (New_line)
			end
			if empty_creation_routines then
				Result.append (Creation_keyword)
				Result.append (New_line)
				Result.append (New_line)
			else
				from
					creation_routines.start
					if not creation_routines.off then
						Result.append (Creation_keyword)
						Result.append (New_line_tab)
						Result.append (creation_routines.item)
						creation_routines.forth
					end
				until
					creation_routines.off
				loop
					Result.append (Comma)
					Result.append (New_line_tab)
					Result.append (creation_routines.item)
					creation_routines.forth
				end
				if not creation_routines.is_empty then
					Result.append (New_line)
					Result.append (New_line)
				end
			end
			from
				an_integer := Initialization
			until
				an_integer = Externals + 1
			loop
				if features.has (an_integer) then
					Result.append (Feature_keyword)
					if 
						an_integer = Initialization or 
						an_integer = Implementation or 
						an_integer = Externals 
					then
						Result.append (Space)
						Result.append (Open_curly_brace)
						Result.append (None_keyword)
						Result.append (Close_curly_brace)
						Result.append (Space)
					end
					Result.append (Space)
					Result.append (Double_dash)
					Result.append (Space)
					Result.append (feature_clauses.item (an_integer))
					from
						features.item (an_integer).start
					until
						features.item (an_integer).after
					loop
						Result.append (New_line)
						Result.append (New_line)
						Result.append (features.item (an_integer).item.generated_code)
						features.item (an_integer).forth
					end
					Result.append (New_line)
					Result.append (New_line)
				end
				an_integer := an_integer + 1
			end
			Result.append (End_keyword)
			Result.append (Space)
			Result.append (Double_dash)
			Result.append (Space)
			Result.append (class_name)
			Result.append (New_line)
			Result.append (New_line)
			Result.append (Class_footer)
		end

	class_name: STRING
			-- Class name
			
	description: STRING
			-- Indexing clause description part

	is_deferred: BOOLEAN
			-- Is class is_deferred

	inherit_clauses: LIST [WIZARD_WRITER_INHERIT_CLAUSE]
			-- Inherit clause elements

	creation_routines: LIST [STRING]
			-- Creation routines

	features: HASH_TABLE [LIST [WIZARD_WRITER_FEATURE], INTEGER]
			-- List of features
	
	invariants: LIST [WIZARD_WRITER_ASSERTION]
			-- List of invariants

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := class_name /= Void and then not class_name.is_empty
		end
				
	Default_description: STRING is "No description available."
			-- Default indexing clause description part

	empty_creation_routines: BOOLEAN
			-- Should `create' be specified without any creation routines?

feature -- Element Change

	set_empty_creation_routines is
			-- Set no creation routines with `create' keyword.
		require
			no_creation_routines: creation_routines.is_empty
		do
			empty_creation_routines := True
		ensure
			empty_creation_routines: empty_creation_routines
		end

	set_class_name (a_class_name: like class_name) is
			-- Set `class_name' with `a_class_name'.
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
		do
			class_name := a_class_name
		ensure
			class_name_set: class_name = a_class_name
		end
	
	set_description (a_description: like description) is
			-- Set `description' with `a_description'.
		require
			non_void_description: a_description /= Void
			valid_description: not a_description.is_empty
		do
			description := a_description
		ensure
			description_set: description = a_description
		end
		
	add_inherit_clause (a_clause: WIZARD_WRITER_INHERIT_CLAUSE) is
			-- Add inherit clause `a_clause' for class `a_class_name'.
		require
			non_void_clause: a_clause /= Void
		do
			inherit_clauses.extend (a_clause)
		ensure
			extended: inherit_clauses.last = a_clause
		end
	
	add_creation_routine (a_creation_routine: STRING) is
			-- Add `a_creation_routine' to creation routines.
		require
			non_void_creation_routines: a_creation_routine /= Void
			valid_creation_routine: not a_creation_routine.is_empty
		do
			creation_routines.extend (a_creation_routine)
		ensure
			extended: creation_routines.last = a_creation_routine
		end
	
	add_feature (a_feature: WIZARD_WRITER_FEATURE; a_clause: INTEGER) is
			-- Add `a_feature' to list of features.
		require
			non_void_feature: a_feature /= Void
			valid_clause: is_valid_clause (a_clause)
		do
			if not features.has (a_clause) then
				features.put (create {LINKED_LIST [WIZARD_WRITER_FEATURE]}.make, a_clause)
			end
			check
				features.has (a_clause)
			end
			features.item (a_clause).extend (a_feature)
		end

	add_invariant (an_invariant: WIZARD_WRITER_ASSERTION) is
			-- Add `an_invariant' to invariants list.
		require
			non_void_invariant: an_invariant /= Void
		do
			invariants.force (an_invariant)
		ensure
			extended: invariants.last = an_invariant
		end
	
	set_deferred is
			-- Set `is_deferred' to `True'.
		do
			is_deferred := True
		ensure
			is_deferred: is_deferred
		end
	
	set_effective is
			-- Set `is_deferred' to `False'.
		do
			is_deferred := False
		ensure
			effective: not is_deferred
		end

invariant

	non_void_creation_routines: creation_routines /= Void
	non_void_features: features /= Void
	non_void_invariants: invariants /= Void
	non_void_inherit_clauses: inherit_clauses /= Void
	valid_empty_creation_routines: empty_creation_routines implies creation_routines.is_empty

end -- WIZARD_WRITER_EIFFEL_CLASS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  