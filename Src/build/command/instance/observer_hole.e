indexing
	description: "Hole to drop a command that is an observer of %
				% another one";
	date: "$Date$";
	revision: "$Revision$"

class
	OBSERVER_HOLE

inherit
	EB_BUTTON;
	HOLE
		redefine
			process_instance, compatible
		select
			init_toolkit
		end

creation

	make

feature {NONE}

	command_tool: COMMAND_TOOL;
			-- Associated command tool

feature 

	data: CMD_INSTANCE is
		do
			if command_tool.command_instance /= Void then
				Result := command_tool.command_instance.data
			end
		end;

	target, source: WIDGET is
		do
			Result := Current
		end;

	create_focus_label is
		do
			set_focus_string (Focus_labels.observer_label)
		end;

	associated_command: CMD is
		do
			Result := data.associated_command;
		end;

	make (ed: COMMAND_TOOL; a_parent: COMPOSITE) is
			-- Create the cmd_edit_hole with `ed' 
			-- as command_tool.
		require
			not_void_ed: not (ed = Void)
		do
			command_tool := ed;
			make_visible (a_parent);
			register
		end; 

	symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_pixmap
		end;

	full_symbol: PIXMAP is
		do
			Result := Pixmaps.command_instance_dot_pixmap
		end;

	compatible (st: STONE): BOOLEAN is
		do
			Result :=
				st.stone_type = Stone_types.command_type or else
				st.stone_type = Stone_types.instance_type
		end

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_symbol (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_symbol (full_symbol)
			end
		end

	stone_type: INTEGER is
			do
				Result := Stone_types.instance_type 
			end

feature {NONE}

	process_instance (dropped: CMD_INST_STONE) is
		local
			observer, observed_command: CMD_INSTANCE
			command: ADD_OBSERVER_CMD
			warning: WARNING_BOX
			error: BOOLEAN
			error_message: STRING
		do
			observer ?= dropped.data
			if observer /= Void then
				error_message := observer.label
				observed_command := command_tool.command_instance
				if observed_command.instance /= Void then
					if observed_command /= observer and then
							not observed_command.is_observer (observer) and then
							not observed_command.observers.has (observer) then  
						!! command.make (observed_command, observer)
						command.execute (Void)
					else
						error := True
						error_message.append (" can't observe ")
						error_message.append (observed_command.label)
						error_message.append (" since %Nit already observe or it will imply an infinite loop.")
					end
				else
					error := True
					error_message.append (" can't observe ")
					error_message.append (observed_command.label)
					error_message.append (" since %Nit hasn't be totally instantiated yet.")
				end
				if error then
					!! warning.make ("Warning", command_tool)
					warning.set_message (error_message)
					warning.popup
				end
			end
		end 

end

