
deferred class CMD 	

inherit

	DATA
	SHARED_APPLICATION
	WINDOWS
	EDITABLE
	
feature -- Editable

	create_editor is
			-- Create a new instance by raising a command tool.
		local
			cmd_tool: COMMAND_TOOL
		do
			if command_editor /= Void and then
				not command_editor.command_tool.destroyed
			then
				cmd_tool := command_editor.command_tool	
			else
				cmd_tool := window_mgr.command_tool
				cmd_tool.set_command (Current)
			end
			cmd_tool.display
		end	

	choose_instance is
		local
			instances_list: CMD_ED_CHOICE_WND
		do
			!! instances_list.make_with_cmd (main_panel.base, Current)
			instances_list.popup_with_list (instances)
		end

	has_instances: BOOLEAN is
			-- Does Current have instances?
		local
			s: BUILD_STATE
			b: BEHAVIOR
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off or Result
			loop
				s ?= Shared_app_graph.key_for_iteration
				if s /= Void then
					from
						s.start
					until
						s.after or Result
					loop
						if not s.input.deleted then
							b := s.output.data
							from
								b.start
							until
								b.after or
								Result
							loop
								Result := (b.output.associated_command = Current)
								b.forth
							end
						end
						s.forth
					end
				end
				Shared_app_graph.forth
			end
		end

	contexts_with_instances: LINKED_LIST [CONTEXT] is
			-- Contexts that use Current command instances
		local
			s: BUILD_STATE
			b: BEHAVIOR
			found: BOOLEAN
		do
			!! Result.make
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off 
			loop
				s ?= Shared_app_graph.key_for_iteration
				if s /= Void then
					from
						s.start
					until
						s.after
					loop
						if not s.input.deleted then
							b := s.output.data
							from
								b.start
								found := False
							until
								b.after or else found
							loop
								found := (b.output.associated_command = Current)
								b.forth
							end
							if found then
								if not Result.has (s.input) then
									Result.extend (s.input)
								end
							end
						end
						s.forth
					end
				end
				Shared_app_graph.forth
			end
		end

	instances: LINKED_LIST [CMD_INSTANCE] is
			-- Instances for Current command
		local
			s: BUILD_STATE
			b: BEHAVIOR
			command_tools: LINKED_LIST [COMMAND_TOOL]
			cmd_tool: COMMAND_TOOL
			observers: LINKED_LIST [CMD_INSTANCE]		
		do
			!! Result.make
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off 
			loop
				s ?= Shared_app_graph.key_for_iteration
				if s /= Void then
					from
						s.start
					until
						s.after
					loop
						if not s.input.deleted then
							b := s.output.data
							from
								b.start
							until
								b.after 
							loop
								if b.output.associated_command = Current
										and then not Result.has (b.output)
								then
									Result.extend (b.output)
								elseif b.output.has_observer then
									observers := b.output.observers
									from
										observers.start
									until
										observers.after
									loop
										if observers.item.associated_command = Current
											and then not Result.has (observers.item)
										then
											Result.extend (observers.item)
										end
										observers.forth
									end				
								end
								b.forth
							end
						end
						s.forth
					end
				end
				Shared_app_graph.forth
			end
				--| Get instances that hasn't been
				--| inserted into a behaviour yet
			command_tools := associated_command_tools
			from
				command_tools.start
			until
				command_tools.after
			loop
				cmd_tool := command_tools.item
				if not Result.has (cmd_tool.command_instance) then
					Result.extend (cmd_tool.command_instance)
				end
				command_tools.forth
			end
		end

	associated_command_tools: LINKED_LIST [COMMAND_TOOL] is
			-- Command tools having an instance of Current command.
		local
			tool_list: LINKED_LIST [COMMAND_TOOL]
			a_tool: COMMAND_TOOL
		do
			!! Result.make
			tool_list := window_mgr.command_tools
			from
				tool_list.start
			until
				tool_list.after
			loop
				a_tool := tool_list.item
				if a_tool.command_instance /= Void and then a_tool.edited_command = Current then
					Result.extend (a_tool)
				end
				tool_list.forth
			end
		end

	instance_counter: INT_GENERATOR

	instance_count: INTEGER is
		do
			if instance_counter = Void then
				!! instance_counter
			end
			Result := instance_counter.value
			instance_counter.next
		end

feature -- Stone

	identifier: INTEGER is
		deferred
		end

	eiffel_type: STRING is
			-- Name of the class representing
			-- Current command
		deferred
		end

	eiffel_type_to_lower: STRING is
			-- Name of the class representing
			-- Current command in lower case
		do
			Result := clone (eiffel_type)
			Result.to_lower
		end

	eiffel_type_to_upper: STRING is
			-- Name of the class representing
			-- Current command in upper case
		do
			Result := clone (eiffel_type)
			Result.to_upper
		end

	arguments: EB_LINKED_LIST [ARG] is
			-- Arguments of Current command
			-- (Currently restricted to contexts)
		deferred
		end

	labels: EB_LINKED_LIST [CMD_LABEL] is
			-- Exit labels of Current command
		deferred
		end

	eiffel_text: STRING is
			-- Eiffel class text of Current
			-- command
		deferred
		end

	data: CMD is
		do
			Result := Current
		end

	symbol: PIXMAP is
		deferred
		end

feature -- Editing

	set_eiffel_text (s: STRING) is
		do
		end

	command_editor: COMMAND_EDITOR
			-- Associated command_editor

	set_editor (ed: like command_editor) is
			-- Set command_editor to `ed'.
		do
			-- TODO: when setting an editor, it has to:
			-- 1. check that it is not currently edited in another editor
			-- 2a. If so, ask the question to the user if he wants to create
			--     a new command, of if his changes must be apllied to each
			--     instance of the command.
			-- 2b. If not, just edit the command
			command_editor := ed
		end

	reset is
			-- `Forget' command_editor.
		do
			command_editor := Void
		end

	edited: BOOLEAN is
			-- Is Current command being edited?
		do
			Result := command_editor /= Void and not command_editor.destroyed
						and then command_editor.shown
		end


feature -- Code Generation

	eiffel_inherit_text: STRING is
			-- Code generation for the 
			-- inherit clause of Current.
		local
			old_label, temp: STRING
			n: LOCAL_NAMER
		do
			!! n.make ("argument")
			!! Result.make (0)
			Result.append (eiffel_type_to_upper)
			if arguments.count > 0 then
				Result.append ("%N%T%Trename%N%T%T%T")
				temp := eiffel_type_to_lower
				Result.append ("argument1 as ")
				Result.append (temp)
				Result.append ("_argument1")
				from
					arguments.start
					arguments.forth
					n.next
				until
					arguments.after
				loop
					Result.append (",%N%T%T%T")
					n.next
					Result.append (n.value)
					Result.append (" as ")
					Result.append (temp)
					Result.append ("_")
					Result.append (n.value)
					arguments.forth
				end
			end
			Result.append ("%N%T%Tredefine%N%T%T%Texecute,%N%T%T%Tmake%N%T%Tend")
		end

	eiffel_body_text: STRING is
			-- Code generation for the 
			-- body of the command. 
		local
			temp: STRING
		do
			!! Result.make (0)
			Result.append ("%Texecute is%N%T%Tdo%N%T%T%T{")
			Result.append (eiffel_type)
			Result.append ("} Precursor%N%T%Tend")
		end

	eiffel_creation_text (l: LINKED_LIST [STRING]): STRING is
			-- Code generation for the 
			-- creation clause of Current.
		do
			!! Result.make (0)
			Result.append ("%T%T%T{")
			Result.append (eiffel_type)
			Result.append ("} Precursor")
			if not l.empty then
				Result.append (" (")
				from
					l.start
				until
					l.after
				loop
					Result.append (l.item)
					l.forth
					if not l.after then
						Result.append (", ")
					end
				end
				Result.append (")")
			end
			Result.append ("%N")
		end

	remove_class is
			-- Remove associated class file when command
			-- is deleted.
		deferred
		end

	recreate_class is
			-- Regenerate associated class file when class
			-- is undeleted
		deferred
		end

feature {NONE}

	popuper_parent: COMPOSITE is
		do
			if edited then	
				Result := command_editor
			else
				Result := main_panel.base
			end
		end

end 
