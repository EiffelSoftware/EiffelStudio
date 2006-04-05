indexing
	description: "Eiffel class feature"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_DEFINITION_ENTRY

inherit
	WIZARD_WRITER

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create root_class_name.make (100)
			create class_creation_feature_name.make (100)
			create export_feature_name.make (100)
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result := root_class_name.twin

			if not class_creation_feature_name.is_empty then
				Result.append (Space_open_parenthesis)
				Result.append (class_creation_feature_name)
				Result.append (Close_parenthesis)
			end
			Result.append (Space)
			Result.append (Colon)
			Result.append (Space)
			Result.append (export_feature_name)
			if feature_index > 0 then
				Result.append (" @ ")
				Result.append_integer (feature_index)
			end

			if feature_alias /= Void and then not feature_alias.is_empty then
				Result.append (" alias ")
				Result.append (feature_alias)
			end

			if call_type /= Void and then not call_type.is_empty then
				Result.append (" call_type ")
				Result.append (call_type)
			end
		end

	root_class_name: STRING
			-- Root class name

	class_creation_feature_name: STRING
			-- Root class creation feature name

	export_feature_name: STRING
			-- Export feature name

	feature_index: INTEGER
			-- Feature index

	feature_alias: STRING
			-- Feature alias

	call_type: STRING
			-- Exported function call type

feature -- Status

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := root_class_name /= Void and not root_class_name.is_empty 
						and export_feature_name /= Void and
						not export_feature_name.is_empty
		end


feature -- Element Change

	set_root_class_name (a_name: like root_class_name) is
			-- Set `root_class_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			root_class_name := a_name.twin
		ensure
			name_set: root_class_name.is_equal (a_name)
		end

	set_class_creation_feature_name (a_feature_name: like class_creation_feature_name) is
			-- Set 'class_creation_feature_name' with 'a_feature_name'.
		require
			non_void_name: a_feature_name /= Void
			valid_name: not a_feature_name.is_empty
		do
			class_creation_feature_name := a_feature_name.twin
		ensure
			name_set: class_creation_feature_name.is_equal (a_feature_name)
		end

	set_export_feature_name (a_feature_name: like export_feature_name) is
			-- Set 'export_feature_name' with 'a_feature_name'
		require
			non_void_name: a_feature_name /= Void
			valid_name: not a_feature_name.is_empty
		do
			export_feature_name := a_feature_name.twin
		ensure
			name_set:export_feature_name.is_equal (a_feature_name)
		end

	set_feature_index (a_index: INTEGER) is
			-- Set 'feature_index' with 'a_index'.
		require
			valid_index: a_index > 0
		do
			feature_index := a_index
		ensure
			index_set: feature_index = a_index
		end

	set_feature_alias (an_alias: like feature_alias) is
			-- Set 'feature_alias' with 'an_alias'
		require
			non_void_alias: an_alias /= Void
			valid_alias: not an_alias.is_empty
		do
			feature_alias := an_alias.twin
		ensure
			alias_set: feature_alias.is_equal (an_alias)
		end

	set_call_type (a_call_type: like call_type) is
			-- Set `call_type' with `a_call_type'.
		require
			non_void_call_type: a_call_type /= Void
		do
			call_type := a_call_type
		ensure
			call_type_set: call_type.is_equal (a_call_type)
		end

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
end -- class WIZARD_WRITER_FEATURE

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
