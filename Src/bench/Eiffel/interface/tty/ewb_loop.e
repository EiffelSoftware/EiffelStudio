
class EWB_LOOP

inherit

	EWB_CMD;
	SHARED_EWB_HELP

feature

	name: STRING is "command loop";

	loop_execute is do end;

	execute is
		do
			init_project;
			if not error_occurred then
				if project_is_new then
					make_new_project
				else
					retrieve_project
				end
			end;
			if not error_occurred then
				ewb_iterate				
			end;
		end;

feature -- Initialization

	commands: EXTEND_TABLE [EWB_CMD, STRING] is
		local
			ewb_ancestors: EWB_ANCESTORS;
			ewb_clients: EWB_CLIENTS;
			ewb_comp: EWB_COMP;
			ewb_depend: EWB_DEPEND;
			ewb_descendants: EWB_DESCENDANTS;
			ewb_finalize: EWB_FINALIZE;
			ewb_flat: EWB_FLAT;
			ewb_freeze: EWB_FREEZE;
			ewb_fs: EWB_FS;
			ewb_future: EWB_FUTURE;
			ewb_history: EWB_HISTORY;
			ewb_past: EWB_PAST;
			ewb_senders: EWB_SENDERS;
			ewb_suppliers: EWB_SUPPLIERS;
		once
			!! Result.make (14);

			!! ewb_comp;
			!! ewb_freeze;
			!! ewb_finalize.make (False);

			!! ewb_ancestors.null;
			!! ewb_clients.null;
			!! ewb_depend.null;
			!! ewb_descendants.null;
			!! ewb_flat.null;
			!! ewb_fs.null;
			!! ewb_future.null;
			!! ewb_history.null;
			!! ewb_past.null;
			!! ewb_senders.null;
			!! ewb_suppliers.null;

			Result.put (ewb_ancestors, "ancestors");
			Result.put (ewb_clients, "clients");
			Result.put (ewb_comp, "melt");
			Result.put (ewb_depend, "dependents");
			Result.put (ewb_descendants, "descendants");
			Result.put (ewb_finalize, "finalize");
			Result.put (ewb_flat, "flat");
			Result.put (ewb_freeze, "freeze");
			Result.put (ewb_fs, "flatshort");
			Result.put (ewb_history, "implementers");
			Result.put (ewb_future, "dversions");
			Result.put (ewb_past, "aversions");
			Result.put (ewb_senders, "callers");
			Result.put (ewb_suppliers, "suppliers");
		end;

	display_commands is
		local
			key: STRING
		do
			io.putstring ("==== ISE Eiffel3 - Interactive Batch Version (v3.2) ====%N%N");
			from
				commands.start
			until
				commands.after
			loop
				key := commands.key_for_iteration;
				if help_messages.has (key) then
					io.putstring ("%T");
					io.putstring (key);
					io.putstring (": ");
					io.putstring (help_messages.item (key));
					io.putstring (".%N");
				end;
				commands.forth
			end;
			io.putstring ("%Tmelt: melt changes.%N");
			io.putstring ("%Tquit: terminate session.%N");
			io.putstring ("%Thelp: print list of commands.%N%N");
		end;

	last_request: STRING;

	get_user_request is
		local
			done: BOOLEAN
		do
			from
			until
				done
			loop
				io.putstring ("Command => ");
				get_name;
				if last_input.empty then
					done := False
				elseif commands.has (last_input) then
					last_request := last_input;
					done := True;
				elseif
					((last_input.count >= 1) and then (last_input.item (1) = 'q'))
				then
					last_request := "quit";
					done := True
				elseif
					((last_input.count >= 1) and then (last_input.item (1) = 'h'))
				then
					last_request := "help";
					done := True
				else
					done := False;
					io.putstring ("Invalid command%N");
				end;
			end;
		end;

feature -- Command loop

	ewb_iterate is
		local
			done: BOOLEAN;
			cmd: EWB_CMD
		do
			from
				display_commands
			until
				done
			loop
				get_user_request;
				if
					last_request.is_equal ("quit")
				then
					done := True;
				elseif
					last_request.is_equal ("help")
				then
					display_commands
				else
					cmd := commands.item (last_request);
					if cmd /= Void then
						cmd.loop_execute;
					end;
				end;
			end;
		end;

end
