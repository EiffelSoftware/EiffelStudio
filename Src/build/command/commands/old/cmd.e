
deferred class CMD 	

inherit

	CMD_STONE;
	APP_SHARED
		export
			{NONE} all
		end;
	EDITABLE;
	WINDOWS

feature

	create_editor is
		local
			ed: CMD_EDITOR
		do
			if command_editor = Void then
				ed := window_mgr.cmd_editor;
				ed.set_command (Current);
				window_mgr.display (ed)
			else
				command_editor.raise
			end
		end

feature -- Instance

	has_instances: BOOLEAN is
			-- Does Current have instances ?
		local
			s: STATE;
			b: BEHAVIOR
		do
			from
				graph.start
			until
				graph.offright or Result
			loop
				s ?= graph.key_for_iteration;
				if not (s = Void) then
					from
						s.start
					until
						s.after or Result
					loop
						b := s.output.original_stone;
						from
							b.start
						until
							b.after or
							Result
						loop
							Result := (b.output.associated_command = Current);
							b.forth
						end;
						s.forth
					end;
				end;
				graph.forth
			end
		end;

feature -- Stone

	original_stone: CMD is
		do
			Result := Current
		end;

	source: WIDGET is do end;

	symbol: PIXMAP;

	set_symbol (p: PIXMAP) is
		do
			symbol := p
		end;

feature -- Stone

	command_editor: CMD_EDITOR;

	set_editor (ed: CMD_EDITOR) is
		do
			command_editor := ed
		end;

	reset is
		do
			command_editor := Void
		end;

	edited: BOOLEAN is
		do
			Result := not (command_editor = Void)
		end;

feature -- Code generation 

	eiffel_inherit_text: STRING is
		local
			temp: STRING;
			n: LOCAL_NAMER
		do
			!!n.make ("argument");
			!!Result.make (0);
				temp := eiffel_type.duplicate;
				temp.to_upper;
			Result.append (temp);
			Result.append ("%N%T%Trename%N%T%T%Texecute as ");
				temp.to_lower;
			Result.append (temp);
			Result.append ("_execute,");
			Result.append ("%N%T%T%Tmake as ");
				temp.to_lower;
			Result.append (temp);
			Result.append ("_make");
			from
				arguments.start
			until
				arguments.after
			loop
				Result.append (",%N%T%T%T");
				n.next;
				Result.append (n.value);
				Result.append (" as ");
				Result.append (temp);
				Result.append ("_");
				Result.append (n.value);
				arguments.forth
			end;
			Result.append ("%N%T%Tend;%N%T");
				temp.to_upper;
			Result.append (temp);
			Result.append ("%N%T%Trename%N%T%T%Tmake as ");
				temp.to_lower;
			Result.append (temp);
			Result.append ("_make");
			from 
				n.reset;
				arguments.start
			until
				arguments.offright
			loop
				Result.append (", %N%T%T%T");
				n.next;
				Result.append (n.value);
				Result.append (" as ");
				Result.append (temp);
				Result.append ("_");
				Result.append (n.value);
				arguments.forth
			end;
			Result.append ("%N%T%Tredefine%N%T%T%Texecute");
			Result.append ("%N%T%Tselect%N%T%T%Texecute%N%T%Tend");
		end;

	eiffel_body_text: STRING is
		local
			temp: STRING;
		do
			!!Result.make (0);
			Result.append ("%Texecute is%N%T%Tdo%N%T%T%T");
				temp := eiffel_type.duplicate;
				temp.to_lower;
			Result.append (temp);
			Result.append ("_execute;%N%T%Tend;%N%N");
		end;

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is
		local
			temp: STRING
		do
			!!Result.make (0);
			Result.append ("%T%T%T");
				temp := eiffel_type.duplicate;
				temp.to_lower;
			Result.append (temp);
			Result.append ("_make");
			if not l.empty then
				Result.append (" (");
				from
					l.start
				until
					l.after
				loop
					Result.append (l.item);
					l.forth;
					if not l.after then
						Result.append (", ");
					end;
				end;
				Result.append (")");
			end;
			Result.append (";%N");
		end;

end 
