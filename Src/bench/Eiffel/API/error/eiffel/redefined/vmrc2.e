-- Error when there is an addtional unvalid selection

class VMRC2 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
		end

feature

	selection_body_id: INTEGER;
			-- Body id of the selected feature

	unvalid_body_id: INTEGER;
			-- Body id of the unvalid selected feature

	selection_written_in: INTEGER;
			-- Class id where the selected feature is written in

	unvalid_written_in: INTEGER;
			-- Class id where the unvalid selected feature is written in

	selection_name: STRING;
			-- Name of the selected feature

	unvalid_name: STRING;
			-- Name of the unvalid selected feature

	
feature 

	code: STRING is "VMRC";
			-- Error code

	init (selected: FEATURE_I; unvalid: FEATURE_I) is
			-- Initialization
		require
			good_argument: not (selected = Void or else unvalid = Void);
		do
			selection_body_id := selected.body_id;
			unvalid_body_id := unvalid.body_id;
			selection_written_in := selected.written_in;
			unvalid_written_in := unvalid.written_in;
			selection_name := selected.feature_name;
			unvalid_name := unvalid.feature_name;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			io.error.putstring ("%Tunvalid selection: ");
			io.error.putstring (unvalid_name);
			io.error.putstring (" [ written in ");
			io.error.putstring
				(System.class_of_id (unvalid_written_in).class_name);
			io.error.putstring ("]%N%Tfeature ");
			io.error.putstring (selection_name);
			io.error.putstring (" written in ");
			io.error.putstring
				(System.class_of_id (selection_written_in).class_name);
			io.error.putstring (" is already selected.%N");
		end;

end
