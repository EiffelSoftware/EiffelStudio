
deferred class EVENT 

inherit

	DATA;
	EVENT_STONE;
	SHARED_STORAGE_INFO;
	EB_HASHABLE;
	SHARED_APPLICATION
	SHARED_MODE
		rename
			current_mode as editing_or_executing_mode
		end
	MODE_CONSTANTS
	
feature {NONE}

	same (other: like Current): BOOLEAN is
		do
			Result := not (other = Void) and then
				(label.is_equal (other.label))
		end;
 
	hash_code: INTEGER is
		do
			Result := label.hash_code
		end;

	make is
		do
			event_table.put (Current, - identifier)
		end;

	Event_const: EVENT_CONSTANTS is
		once
			!! Result
		end;

	help_file_name: STRING is
		do
			Result := Help_const.event_help_fn
		end;

feature {CAT_EV_IS}

	exists_in_application: BOOLEAN is
		local
			s: BUILD_STATE;
			b: BEHAVIOR;
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off
			loop
				s ?= Shared_app_graph.key_for_iteration;
				if s /= Void then
					from
						s.start
					until
						s.after
					loop
						b := s.output.data;
						from
							b.start
						until
							b.after or else Result
						loop
							Result := b.input = Current;
							b.forth
						end;
						s.forth
					end;
				end;
				Shared_app_graph.forth
			end;
		end;
	
feature 

	data: EVENT is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		deferred
		end;

	label: STRING is
		do
			Result := internal_name
		end;

	internal_name: STRING is
		deferred
		end;

	identifier: INTEGER is
			-- Identifier for current event
		deferred
		end;
	
	eiffel_text: STRING is
			-- Eiffel Text for current event
		deferred
		end;
	
feature 

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
			-- Is the current event defined for `a_context'
		do
			Result := True
		end;

feature -- Interface Command

	associated_command_creation_arg: COMMAND_CREATION_ARGUMENT
			-- Arguments needed to instanciate the associated command.

	command_name: STRING
			-- Name of associated command.

	add_interface_command (a_context: CONTEXT; a_command: COMMAND) is
			-- Add `a_command' to the widget corresponding to `a_context'
			-- according to the kind of event.
		do
			specific_add (a_context.widget, a_command)
		end

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	`a_command' to `a_widget' according to the 
			-- kind of event.
		require else
			widget_not_void: a_widget /= Void
			command_not_void: a_command /= Void
		deferred
		end

	remove_interface_command (a_context: CONTEXT; a_command: COMMAND) is
			-- Remove `a_command' to the widget corresponding to `a_context'
			-- according to the kind of event.
		do
			specific_remove (a_context.widget, a_command)
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		require else
			widget_not_void: a_widget /= Void
			command_not_void: a_command /= Void
		deferred
		end

	convert (associated_command: CMD_INSTANCE) is
			-- Separate the data of `associated_command' into `command_name'
			-- and `associated_command_creation_arg'.
		require
			associated_command_not_void: associated_command /= Void
		local
			argument_instance: ARG_INSTANCE
		do
			command_name := associated_command.eiffel_type
			!! associated_command_creation_arg.make
			from 
				associated_command.arguments.start
			until
				associated_command.arguments.after
			loop
				argument_instance := associated_command.arguments.item
				if argument_instance.instantiated then
					associated_command_creation_arg.extend (argument_instance.context.widget)
				else
					associated_command_creation_arg.extend (Void)
				end
				associated_command.arguments.forth
			end
		end	
				
end
