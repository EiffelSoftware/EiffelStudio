indexing
	description: "Server for routines' body indexed by body index."
	date: "$Date$"
	revision: "$Revision$"

class
	BODY_SERVER 

inherit
	READ_SERVER [FEATURE_AS]
		rename
			ast_server as offsets
		export
			{ANY} merge, Tmp_body_server
		redefine
			item, trace
		end

create
	make
	
feature 

	cache: BODY_CACHE is
			-- Cache for routine tables
		once
			create Result.make
		end
		
	item (an_id: INTEGER): FEATURE_AS is
			-- Body of id `an_id'. Look first in the temporary
			-- body server. It not present, look in itself.
		require else
			has_an_id: Tmp_body_server.has (an_id) or else has (an_id)
		do
debug
io.error.put_string ("item ");
io.error.put_integer (an_id)
end;
			if Tmp_body_server.has (an_id) then
debug
io.error.put_string (" in tmp_server%N")
end;
				Result := Tmp_body_server.item (an_id);
			else
debug
io.error.put_string (" in BODY_SERVER%N")
end;
				Result := server_item (an_id);
			end;
		end;

	info (an_id: INTEGER): READ_INFO is
			-- Info for item of id `an_id'.
		require
			has_an_id: Tmp_body_server.has (an_id) or else has (an_id);
		do
			if Tmp_body_server.has (an_id) then
				Result := Tmp_body_server.tbl_item (an_id)
			else
				Result := tbl_item (an_id)
			end;
		end;

	trace is
		do
			from
				start
				io.error.put_string ("Keys:%N");
			until
				after
			loop
				io.error.put_string ("%T");
				io.error.put_integer (key_for_iteration);
				if item_for_iteration = Void then
					io.error.put_string (" VOID ELEMENT");
				end;
				io.error.put_new_line;
				forth
			end;
			io.error.put_string ("O_N_TABLE:%N");
		end;

end
