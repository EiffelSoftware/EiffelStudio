indexing

	description: 
		"Print the static diagram for cluster.";
	date: "$Date$";
	revision: "$Revision $"


class PRINT_CLUSTER_DIAGRAM 

inherit
	
	EC_COMMAND;
	PS_HEADER;
	CONSTANTS;
	ONCES

creation

	make

feature -- Initialization

	make (cl: CLUSTER_DATA) is
		require
			valid_cluster: cl /= Void;
		do
			cluster := cl
		end;

feature -- colored ??
	colored : BOOLEAN

	set_color (b:BOOLEAN) is do
		colored := b
	end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Write postscript in `file'.
		local
			post_prg_name: STRING;
			post_prg: PLAIN_TEXT_FILE;
			fi_error : BOOLEAN
		do
-- 			if not fi_error then
-- 			--Windows.set_watch_cursor;
-- 			check
-- 				file /= Void;
-- 				file.is_open_write
-- 			end;
-- 			write_postscript_header (file, cluster);
-- 			post_prg_name := clone (environment.Postscript_directory);
-- 			post_prg_name.append_character (environment.directory_separator);
-- 			if not colored then
-- 				post_prg_name.append ("graph_print.ps.lib");
-- 			else
-- 				post_prg_name.append ("graph_print.ps.lib2")
-- 			end
-- 			!!post_prg.make (post_prg_name);
-- 			if post_prg.exists and then post_prg.is_readable then
-- 				post_prg.open_read;
-- 				from
-- 				until
-- 					post_prg.end_of_file
-- 				loop
-- 					post_prg.readline;
-- 					file.putstring (post_prg.laststring);
-- 					file.putstring ("%N")
-- 				end;
-- 				post_prg.close;
-- 				--Windows.restore_cursor;
-- 			else
-- 				--Windows.restore_cursor;
-- 				Windows_manager.popup_error (Message_keys.read_er, post_prg_name,Windows_manager.main_window);
-- 			end
-- 			else
-- 				-- no error occured
-- 				Windows_manager.popup_error ( "E45", "",Windows_manager.main_window)
-- 			end
-- 			rescue
-- 				if not fi_error then
-- 					fi_error := TRUE
-- 					Windows_manager.add_error_message ("error occured in execute of print_cluster_diagram")
-- 					retry
-- 				end
		end

feature {NONE} -- Implementation properties

	cluster: CLUSTER_DATA;

end -- class PRINT_CLUSTER_DIAGRAM
