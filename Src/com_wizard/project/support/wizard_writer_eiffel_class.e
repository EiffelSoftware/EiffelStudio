indexing
	description: "Eiffel Class writer"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			description := ""
			create {ARRAYED_LIST [WIZARD_WRITER_INHERIT_CLAUSE]} inherit_clauses.make (20)
			create {ARRAYED_LIST [STRING]} creation_routines.make (20)
			create features.make (10)
			create {ARRAYED_LIST [WIZARD_WRITER_ASSERTION]} invariants.make (20)
		end

feature -- Access
	
	generated_code: STRING is
			-- Generated code
		local
			l_integer: INTEGER
			l_features: LIST [WIZARD_WRITER_FEATURE]
		do
			Result := "indexing%N%Tdescription: %""
			Result.append (description)
			Result.append ("%"%N%Tnote: ")
			Result.append (Wizard_note)
			Result.append ("%N%N")
			if is_deferred then
				Result.append ("deferred ")
			end
			Result.append ("class%N%T")
			Result.append (class_name)
			Result.append ("%N%N")
			if not inherit_clauses.is_empty then
				Result.append ("inherit")
			end
			from
				inherit_clauses.start
			until
				inherit_clauses.after
			loop
				Result.append ("%N")
				Result.append (inherit_clauses.item.generated_code)
				Result.append ("%N")
				inherit_clauses.forth
			end
			if not inherit_clauses.is_empty then
				Result.append ("%N")
			end
			if empty_creation_routines then
				Result.append ("create%N%N")
			else
				from
					creation_routines.start
					if not creation_routines.off then
						Result.append ("create%N%T")
						Result.append (creation_routines.item)
						creation_routines.forth
					end
				until
					creation_routines.off
				loop
					Result.append (",%N%T")
					Result.append (creation_routines.item)
					creation_routines.forth
				end
				if not creation_routines.is_empty then
					Result.append ("%N%N")
				end
			end
			from
				l_integer := Initialization
			until
				l_integer = Externals + 1
			loop
				if features.has (l_integer) then
					Result.append ("feature")
					if l_integer = Initialization or l_integer = Implementation or l_integer = Externals then
						Result.append (" {NONE} ")
					end
					Result.append (" -- ")
					Result.append (feature_clauses.item (l_integer))
					l_features := features.item (l_integer)
					from
						l_features.start
					until
						l_features.after
					loop
						Result.append ("%N%N")
						Result.append (l_features.item.generated_code)
						l_features.forth
					end
					Result.append ("%N%N")
				end
				l_integer := l_integer + 1
			end
			Result.append ("end -- ")
			Result.append (class_name)
			Result.append ("%N%N")
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
				features.put (create {ARRAYED_LIST [WIZARD_WRITER_FEATURE]}.make (20), a_clause)
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- WIZARD_WRITER_EIFFEL_CLASS

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------
