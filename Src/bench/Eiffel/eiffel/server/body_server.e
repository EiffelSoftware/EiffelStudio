-- Server for routine tables

class
	BODY_SERVER 

inherit
	READ_SERVER [FEATURE_AS, BODY_ID]
		rename
			ast_server as offsets
		export
			{ANY} merge, Tmp_body_server
		redefine
			item, ontable, updated_id, change_id, trace
		end

creation
	make
	
feature 

	ontable: O_N_TABLE [BODY_ID] is
			-- Mapping table between old ids and new ids.
			-- Used by `change_id'
		require else
			True
		once
			Result := System.onbidt
		end;

	updated_id (i: BODY_ID): BODY_ID is
		do
			Result := ontable.item (i)
debug
if not equal (Result, i) then
	io.error.putstring ("updated_id: ");
	i.trace;
	io.error.putstring (" to ");
	Result.trace;
	io.error.new_line;
end;
end;
		end;

	cache: BODY_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	item (an_id: BODY_ID): FEATURE_AS is
			-- Body of id `an_id'. Look first in the temporary
			-- body server. It not present, look in itself.
		require else
			has_an_id: Tmp_body_server.has (an_id) or else has (an_id)
		do
debug
io.error.putstring ("item ");
an_id.trace
end;
			if Tmp_body_server.has (an_id) then
debug
io.error.putstring (" in tmp_server%N")
end;
				Result := Tmp_body_server.item (an_id);
			else
debug
io.error.putstring (" in BODY_SERVER%N")
end;
				Result := server_item (an_id);
			end;
		end;

	info (an_id: BODY_ID): READ_INFO is
			-- Info for item of id `an_id'.
		require
			has_an_id: Tmp_body_server.has (an_id) or else has (an_id);
		do
			if Tmp_body_server.has (an_id) then
				Result := Tmp_body_server.tbl_item (updated_id(an_id));
			else
				Result := tbl_item (updated_id(an_id));
			end;
		end;

	change_id (new_value, old_value: BODY_ID) is
		require else
			Tmp_body_server.has (old_value)
		do
debug
io.error.putstring ("change_id ");
old_value.trace;
io.error.putstring (" to ");
new_value.trace;
io.error.new_line;
end;
			if has (old_value) then
debug
io.error.putstring ("Changed in BODY_SERVER%N");
end;
				{READ_SERVER} Precursor (new_value, old_value)
			end;
			if Tmp_body_server.has (old_value) then
debug
io.error.putstring ("Changed in TMP_BODY_SERVER%N");
end;
				Tmp_body_server.change_id (new_value, old_value)
			end;
debug
io.error.putstring ("TRACE of TMP_BODY_SERVER%N");
Tmp_body_server.trace
end;
		end;

	trace is
		local
			i: INTEGER;
		do
			from
				start
				io.error.putstring ("Keys:%N");
			until
				after
			loop
				io.error.putstring ("%T");
				key_for_iteration.trace;
				if item_for_iteration = Void then
					io.error.putstring (" VOID ELEMENT");
				end;
				io.error.new_line;
				forth
			end;
			io.error.putstring ("O_N_TABLE:%N");
			ontable.trace;
		end;

end
