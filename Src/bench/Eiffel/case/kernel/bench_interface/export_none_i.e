indexing

	description: 
		"Export status for features exported to no classes.%
		%Kept for compatibility only (in 3.4). To be replaced %
		%by a propoer instance of EXPORT_SET_I.";
	date: "$Date$";
	revision: "$Revision $"

class EXPORT_NONE_I

inherit

	EXPORT_I
		redefine
			is_none, export_string
		end

feature -- Properties

	is_none: BOOLEAN is
		do
			Result := True
		end;

feature -- Comparison

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		do
			Result := other.is_none
		end;

feature -- Output

	generate (text_area: TEXT_AREA) is
		do
			text_area.append_string (export_string)
		end

	generate_c (text_area: TEXT_AREA) is
        do
            text_area.append_string (export_string)
        end
	

	export_list_string: STRING is "NONE"
			-- String containing the list of authorized clients 
			-- (without brackets)

	export_string: STRING is " {NONE}"
			-- String containing the export clause

feature {NONE} -- Inapplicable

	make_from_storer (s_export: S_EXPORT_I) is
		do
			check
				not_called: False
			end			
		end

	storage_info: S_EXPORT_NONE_I is
		do
			check
				not_called: False
			end		
		end

end -- class EXPORT_NONE_I
