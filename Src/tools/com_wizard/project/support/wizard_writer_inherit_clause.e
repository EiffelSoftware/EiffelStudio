indexing
	description: "Inherit clause used in WIZARD_WRITER_CLASS"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			create {ARRAYED_LIST [STRING]} sources.make (20)
			create {ARRAYED_LIST [STRING]} destinations.make (20)
			create {ARRAYED_LIST [WIZARD_WRITER_EXPORT_DIRECTIVE]}exports.make (20)
			create {ARRAYED_LIST [STRING]} undefines.make (20)
			create {ARRAYED_LIST [STRING]} redefines.make (20)
			create {ARRAYED_LIST [STRING]} selects.make (20)
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result := Tab.twin
			Result.append (name)
			if not sources.is_empty or not exports.is_empty or not undefines.is_empty or
				not redefines.is_empty or not selects.is_empty then
				Result.append (New_line_tab_tab)
				if not sources.is_empty then
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
				if not exports.is_empty then
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
				if not undefines.is_empty then
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
				if not redefines.is_empty then
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
				if not selects.is_empty then
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
			valid_name: not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name.is_equal (a_name)
		end
		
	add_rename (source, destination: STRING) is
			-- Add renaming clause with source `source' and destination `destination'.
		require
			non_void_source: source /= Void
			valid_source: not source.is_empty
			non_void_destination: destination /= Void
			valid_destination: not destination.is_empty
			valid_names: not source.is_equal (destination)
		do
			sources.extend (source)
			destinations.extend (destination)
		end
	
	add_redefine (a_feature: STRING) is
			-- Add redefine clause for feature `a_feature'.
		require
			non_void_feature: a_feature/= Void
			valid_feature: not a_feature.is_empty
		do
			redefines.extend (a_feature)
		ensure
			added: redefines.last = a_feature
		end
	
	add_export (features: LIST [STRING]; a_class: STRING) is
			-- Add export clause for features `features' exported to `class'.
		require
			non_void_features: features /= Void
			valid_features: not features.is_empty
			non_void_class: a_class /= Void
			valid_class: not a_class.is_empty
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
			valid_features: not a_feature.is_empty
		do
			undefines.extend (a_feature)
		ensure
			added: undefines.last.is_equal (a_feature)
		end
	
	add_select_clause (a_feature: STRING) is
			-- Add select clause with feature `a_feature'.
		require
			non_void_features: a_feature/= Void
			valid_features: not a_feature.is_empty
		do
			selects.extend (a_feature)
		ensure
			added: selects.last.is_equal (a_feature)
		end

invariant
	
		valid_rename_clauses: sources.count = destinations.count

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
end -- class WIZARD_WRITER_INHERIT_CLAUSE

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
