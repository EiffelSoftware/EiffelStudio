indexing
	description: "Inherit clause used in WIZARD_WRITER_CLASS"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_INHERIT_CLAUSE

inherit
	WIZARD_WRITER

creation
	make
		
feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create {LINKED_LIST [STRING]} sources.make
			create {LINKED_LIST [STRING]} destinations.make
			create {LINKED_LIST [WIZARD_WRITER_EXPORT_DIRECTIVE]}exports.make
			create {LINKED_LIST [STRING]} undefines.make
			create {LINKED_LIST [STRING]} redefines.make
			create {LINKED_LIST [STRING]} selects.make
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result := clone (Tab)
			Result.append (name)
			if not sources.empty or not exports.empty or not undefines.empty or
				not redefines.empty or not selects.empty then
				Result.append (New_line_tab_tab)
				if not sources.empty then
					Result.append (Rename_keyword)
						sources.start 
						destinations.start
						Result.append (New_line_tab_tab_tab)
						Result.append (sources.item)
						Result.append (Space)
						Result.append (As_keyword)
						Result.append (Space)
						Result.append (destinations.item)
					from
						sources.forth
						destinations.forth
					until
						sources.after
					loop
						Result.append (Comma)
						Result.append (New_line_tab_tab_tab)
						Result.append (sources.item)
						Result.append (Space)
						Result.append (As_keyword)
						Result.append (Space)
						Result.append (destinations.item)
						sources.forth
						destinations.forth
					end
					Result.append (New_line_tab_tab)
				end
				if not exports.empty then
					Result.append (Export_keyword)
					from
						exports.start
					until
						exports.after
					loop
						Result.append (New_line_tab_tab_tab)
						Result.append (Open_curly_brace)
						Result.append (exports.item.to_class)
						Result.append (Close_curly_brace)
						Result.append (Space)
						from
							exports.item.features.start
							Result.append (exports.item.features.item)
							exports.item.features.forth
						until
							exports.item.features.after
						loop
							Result.append (Comma)
							Result.append (New_line_tab_tab_tab)
							Result.append (tab)
							Result.append (exports.item.features.item)
							exports.item.features.forth
						end
						Result.append (Semicolon)
						exports.forth
					end
					Result.append (New_line_tab_tab)
				end
				if not undefines.empty then
					Result.append (Undefine_keyword)
					Result.append (New_line_tab_tab_tab)
					from
						undefines.start
						Result.append (undefines.item)
						undefines.forth
					until
						undefines.after
					loop
						Result.append (Comma)
						Result.append (New_line_tab_tab_tab)
						Result.append (undefines.item)
						undefines.forth
					end
					Result.append (New_line_tab_tab)
				end
				if not redefines.empty then
					Result.append (Redefine_keyword)
					Result.append (New_line_tab_tab_tab)
					from
						redefines.start
						Result.append (redefines.item)
						redefines.forth
					until
						redefines.after
					loop
						Result.append (Comma)
						Result.append (New_line_tab_tab_tab)
						Result.append (redefines.item)
						redefines.forth
					end
					Result.append (New_line_tab_tab)
				end
				if not selects.empty then
					Result.append (Select_keyword)
					Result.append (New_line_tab_tab_tab)
					from
						selects.start
						Result.append (selects.item)
						selects.forth
					until
						selects.after
					loop
						Result.append (Comma)
						Result.append (New_line_tab_tab_tab)
						Result.append (selects.item)
						selects.forth
					end
					Result.append (New_line_tab_tab)
				end
				Result.append (End_keyword)
			end
		end
	
	can_generate: BOOLEAN is
			-- Can Eiffel code by generated
		do
			Result := name /= Void
		end

	name: STRING
			-- Inherited class name
	
	sources: LIST [STRING]
			-- Rename clause sources

	destinations: LIST [STRING]
			-- Rename clause destinations

	exports: LIST [WIZARD_WRITER_EXPORT_DIRECTIVE]
			-- Export clause

	undefines: LIST [STRING]
			-- Undefined features
	
	redefines: LIST [STRING]
			-- Redefined features
	
	selects: LIST [STRING]
			-- Selected features

feature -- Element Change

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		require	
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end
		
	add_rename (source, destination: STRING) is
			-- Add renaming clause with source `source' and destination `destination'.
		require
			non_void_source: source /= Void
			valid_source: not source.empty
			non_void_destination: destination /= Void
			valid_destination: not destination.empty
		do
			sources.extend (source)
			destinations.extend (destination)
		end
	
	add_redefine (a_feature: STRING) is
			-- Add redefine clause for feature `a_feature'.
		require
			non_void_feature: a_feature/= Void
			valid_feature: not a_feature.empty
		do
			redefines.extend (a_feature)
		ensure
			added: redefines.last = a_feature
		end
	
	add_export (features: LIST [STRING]; a_class: STRING) is
			-- Add export clause for features `features' exported to `class'.
		require
			non_void_features: features /= Void
			valid_features: not features.empty
			non_void_class: a_class /= Void
			valid_class: not a_class.empty
		local
			export_directive: WIZARD_WRITER_EXPORT_DIRECTIVE
		do
			create export_directive.make (features, a_class)
			exports.extend (export_directive)
		end
	
	add_undefine (a_feature: STRING) is
			-- Add undefine clause for feature `a_feature'.
		require
			non_void_features: a_feature/= Void
			valid_features: not a_feature.empty
		do
			undefines.extend (a_feature)
		ensure
			added: undefines.last.is_equal (a_feature)
		end
	
	add_select_clause (a_feature: STRING) is
			-- Add select clause with feature `a_feature'.
		require
			non_void_features: a_feature/= Void
			valid_features: not a_feature.empty
		do
			selects.extend (a_feature)
		ensure
			added: selects.last.is_equal (a_feature)
		end

invariant
	
		valid_rename_clauses: sources.count = destinations.count

end -- class WIZARD_WRITER_INHERIT_CLAUSE

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
  