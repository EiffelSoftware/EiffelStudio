indexing
	description: "Eiffel class feature"
	status: "See notice at end of class";
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
			Result := clone (root_class_name)

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
			root_class_name := clone (a_name)
		ensure
			name_set: root_class_name.is_equal (a_name)
		end

	set_class_creation_feature_name (a_feature_name: like class_creation_feature_name) is
			-- Set 'class_creation_feature_name' with 'a_feature_name'.
		require
			non_void_name: a_feature_name /= Void
			valid_name: not a_feature_name.is_empty
		do
			class_creation_feature_name := clone (a_feature_name)
		ensure
			name_set: class_creation_feature_name.is_equal (a_feature_name)
		end

	set_export_feature_name (a_feature_name: like export_feature_name) is
			-- Set 'export_feature_name' with 'a_feature_name'
		require
			non_void_name: a_feature_name /= Void
			valid_name: not a_feature_name.is_empty
		do
			export_feature_name := clone (a_feature_name)
		ensure
			name_set:export_feature_name.is_equal (a_feature_name)
		end

	set_feature_index (an_index: INTEGER) is
			-- Set 'feature_index' with 'an_index'.
		require
			valid_index: an_index > 0
		do
			feature_index := an_index
		ensure
			index_set: feature_index = an_index
		end

	set_feature_alias (an_alias: like feature_alias) is
			-- Set 'feature_alias' with 'an_alias'
		require
			non_void_alias: an_alias /= Void
			valid_alias: not an_alias.is_empty
		do
			feature_alias := clone (an_alias)
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

end -- class WIZARD_WRITER_FEATURE

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
  