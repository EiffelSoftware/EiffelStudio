indexing

	description: 
		"Stone that represents views other than currently edited view."
	date: "$Date$";
	revision: "$Revision $"

class 
	OTHER_VIEW_STONE

inherit

	EC_STONE
		redefine
			destroy_data
		end;
	ONCES;
	WARNING_CALLER

creation

	make

feature {NONE} -- Initialization 

	make (a_data: like data) is
			-- Set data  to `a_data'.
		require
			valid_a_data: a_data /= Void;
		do
			data := a_data;
		ensure
			data_set: data = a_data
		end;

feature  -- Properties

	data: SYSTEM_VIEW_INFO
		-- Data associated with stone

	destroy_command: DESTROY is
			-- Destroy command to remove Current stone and its
			-- data.
		do
			--!! Result.make (data);
		end;

	is_valid: BOOLEAN is
			-- Is Current stone valid?
		do
			Result  := True
		end;

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated with 
	--		-- Current stone during transport.
	--	do
		--	Result := Cursors.comment_cursor
	--	end;

	stone_type_pnd: EV_PND_TYPE is 
			-- Current stone type
		do
			Result := stone_types.other_view_name_type_pnd
		end


feature -- Update

	cancel_action is
		do
		end;

	ok_action is
		local
			view_file_name: FILE_NAME;
			view_file: RAW_FILE;
			list: SYSTEM_VIEW_LIST
		do
--			if not rescued then
--				list := System.retrieve_view_list;
--				if list /= Void then
--					list.delete_view_with_id (data.view_id, Environment.view_file_name)
--				end;
--				Windows.update_view_window
--			else
--				rescued := False;
--				io.error.putstring ("Error: deleting view%N")
--			end
--		rescue
--			rescued := True
--			retry
		end;

	process (com: EC_COMMAND) is
			-- Process Current stone dropped in a correct hole 
			-- with command `com' 
		do
		end;

feature -- Duplication

	copy_data (a_stone: like Current) is
			-- Copy `a_stone' data to Current.
		do
		end;

feature -- Removal

	destroy_data is
			-- Destroy command to remove Current stone and its
			-- data.
		do
--			Windows.warning (Windows.view_window, Message_keys.delete_view_confirm_wa, data.view_name, Current)
		end;

feature {NONE} -- Implementation

	rescued: BOOLEAN;

end -- class  OTHER_VIEW_STONE

