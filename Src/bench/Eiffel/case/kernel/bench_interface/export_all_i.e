indexing

	description: 
		"Export status for features exported to all classes. %
		%Kept for compatibility only (in 3.4). To be replaced %
		%by a proper instance of EXPORT_SET_I.";
	date: "$Date$";
	revision: "$Revision $"

class EXPORT_ALL_I

inherit

	EXPORT_I
		redefine
			is_all
		end

feature -- Properties

	is_all: BOOLEAN is
		do
			Result := true
		end;

feature -- Comparison

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		do
			Result := other.is_all
		end;

feature -- Output

	export_list_string: STRING is ""
			-- String containing the export clause

	generate (text_area: TEXT_AREA) is
		do
		end

	generate_c (text_area: TEXT_AREA) is 
		do
		end

feature {NONE} -- Inapplicable

	make_from_storer (s_export: S_EXPORT_I) is
		do
			check
				not_called: False
			end			
		end

	storage_info: S_EXPORT_ALL_I is
		do
			check
				not_called: False
			end
		end

end -- class EXPORT_ALL_I
