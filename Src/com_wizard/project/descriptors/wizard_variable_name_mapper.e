indexing
	description: "Wizard name mapper"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_VARIABLE_NAME_MAPPER

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

feature -- Basic operations

	name_for_class (a_name: STRING; a_type: INTEGER; is_client: BOOLEAN): STRING is
			-- Convert to Eiffel class name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
			valid_type: is_valid_type_kind (a_type)
		local
			i: INTEGER
			privious_upper: BOOLEAN
		do

			from
				i := 1
				create Result.make (0)
				privious_upper := True
			variant 
				a_name.count - i + 1
			until
				i > a_name.count
			loop
				if a_name.item (i).is_upper and not privious_upper then
					Result.append (Underscore)
				end
				Result.extend (a_name.item (i))
				if a_name.item (i).is_upper or (a_name.item (i) = '_') then
					privious_upper := True
				else
					privious_upper := False
				end
				i := i + 1
			end
			from
			until
				Result.item (1) /= '_'
			loop
				Result.tail (Result.count - 1)
			end
			Result.to_upper
			if (a_type = Tkind_enum) then
				Result.append ("_ENUM")
			elseif (a_type = Tkind_record) then
				Result.append ("_RECORD")
			elseif (a_type = Tkind_interface) then
				Result.append ("_INTERFACE")
			elseif (a_type = Tkind_dispatch) then
				Result.append ("_AUTO_INTERFACE")
			elseif (a_type = Tkind_coclass) then
				if is_client then
					Result.append ("_PROXY")
				else
					Result.append ("_COCLASS")
				end
			elseif (a_type = Tkind_alias) then
				Result.append ("_ALIAS")
			elseif (a_type = Tkind_union) then
				Result.append ("_UNION")
			end
		ensure
			non_void_class_name: Result /= Void
			valid_class_name: not Result.empty
		end

	name_for_feature (a_name: STRING): STRING is
			-- Convert to Eiffel feature name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		local
			i: INTEGER
			privious_upper: BOOLEAN
		do
			from
				i := 1
				create Result.make (0)
				privious_upper := True
			variant 
				a_name.count - i + 1
			until
				i > a_name.count
			loop
				if a_name.item (i).is_upper and not privious_upper then
					Result.append (Underscore)
				end
				Result.extend (a_name.item (i))
				if a_name.item (i).is_upper or (a_name.item (i) = '_') then
					privious_upper := True
				else
					privious_upper := False
				end
				i := i + 1
			end
			Result.to_lower
		ensure
			non_void_feature_name: Result /= Void
			valid_feature_name: not Result.empty
		end

	external_feature_name (a_name: STRING): STRING is
			-- Name of external feature name.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.empty
		do
			create Result.make (0)
			Result.append (Ccom_clause)
			Result.append (name_for_feature (a_name))
		ensure
			non_void_feature_name: Result /= Void
			valid_feature_name: not Result.empty
		end

end -- class WIZARD_VARIABLE_NAME_MAPPER

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
