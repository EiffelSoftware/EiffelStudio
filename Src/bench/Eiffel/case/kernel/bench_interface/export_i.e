indexing

	description: 
		"Export status for features.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EXPORT_I 

feature -- Initialization

	make_from_storer (s_export: S_EXPORT_I) is
		require
			s_export_exists: s_export /= Void
		deferred
		end

feature -- Properties

	is_none: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_NONE
		do
		end;

	is_set: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_SET_I ?
			-- (For future use)
		do
			-- Do nothing
		end;

	is_all: BOOLEAN is
			-- Is the current object an instance of S_EXPORT_ALL_I ?
		do
			-- Do nothing
		end;

feature -- Comparison

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is Current same_as `other'?
		require
			valid_other: other /= Void
		deferred
		end;

feature -- Output

	generate (text_area: TEXT_AREA) is
		require
			valid_text_area: text_area /= Void
		deferred
		end

	generate_c (text_area: TEXT_AREA) is
        require
            valid_text_area: text_area /= Void
        deferred
        end


	export_list_string: STRING is
			-- String containing the list of authorized clients 
			-- (without brackets)
		deferred
		end

	export_string: STRING is
			-- String containing the export clause
		do
			Result := export_list_string
			if not Result.empty then
				Result.prepend (" {")
				Result.extend ('}')
			end		
		end

	export_string_c:STRING is
			-- String containing the export clause ( C)
		do
			Result := export_list_string
			if not Result.empty then
				Result.prepend (" :")		
			end
		end

feature -- Storage

	storage_info: S_EXPORT_I is
		deferred
		ensure
			valid_result: Result /= Void
		end

end -- class EXPORT_I
