indexing

	description: 
		"This has the feature_data as an function thus%
		%takes longer to retrieve the data information.%
		%Need to make sure that the associated class data%
		%has been requested into memory before retrieving%
		%the feature data.";
	date: "$Date$";
	revision: "$Revision $"

class RENAME_FEATURE_STONE

inherit
		
	FEATURE_STONE
		redefine
			request_for_information,
			free_information,
			--setup_namer, 
			copy_data, 
			--set,
			data, title_label
		end

creation

	make

feature -- Initialization

	make (r_data: like rename_data; data_cont: FEATURE_DATA) is
			-- Set rename_data to `r_data' and 
			-- data_container to `data_cont'.
		require
			valid_r_data: r_data /= Void;
			valid_data_cont: data_cont /= Void
		do
			rename_data := r_data;
			data_container := data_cont
		ensure
			set: data_container = data_cont and then
				rename_data = r_data
		end;

feature -- Properties

	rename_data: RENAME_DATA;
			-- Rename data holding feature information

	data_container: FEATURE_DATA;
			-- Feature where rename data is contained in 

	class_data: CLASS_DATA is
			-- Associated class data for the rename data
		do
			Result := rename_data.origin_class_data
		ensure
			Result = rename_data.origin_class_data
		end;

	data: FEATURE_DATA is
			-- Feature data of Current stone
		do	
			Result := class_data.feature_with_name 
						(rename_data.origin_feature_name);
		end;

	title_label: STRING is
			-- Title for namer window
		do
			Result := rename_data.focus
		end;

feature -- Update

	request_for_information is
			-- Request information for class_data.
		do
			class_data.request_for_information;
		end;

	free_information is
			-- Request information for class_data.
		do
			class_data.free_information
		end;

feature -- Setting

	--set (namer: NAMER_WINDOW) is
	--		-- Set information from `namer'.
	--	local
	---		a_data: like rename_data;
	--		replace_command: REPLACE_DATA_U
	--	do
	--		a_data := clone (rename_data);
	--		a_data.update_from_namer (namer);
	--		!! replace_command.make (data_container,
	--				rename_data, a_data);
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
	--		-- Setup `namer' from data.
	--	local
	--		tmp: STRING;
	--	do
	--		namer.set_up (False, False)
	--		!! tmp.make (0);
	--		tmp.append (rename_data.focus);
	--		namer.set_text (tmp);
	--		namer.set_list_of_features;
	--	end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current;
		local
			a_data: like rename_data;
			replace_command: REPLACE_DATA_U;
		do
			a_data := clone (a_stone.rename_data);
			!! replace_command.make (data_container,
					rename_data, a_data);
		end;

end -- class RENAME_FEATURE_STONE
