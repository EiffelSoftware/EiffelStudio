

class META_CMD 

inherit

	EXTEND_TABLE [CMD_INSTANCE, STATE]
		rename
			make as extend_table_create,
			key_for_iteration as current_state
		end

	CALLBACK_GENE
		undefine
			is_equal, copy
		end

	COM_NAMER
		undefine
			is_equal, copy
		end

creation

	make
	
feature 

	eiffel_declaration: STRING is
		do
			!! Result.make (0)
			observer_namer.reset
			from
				start
			until
				off
			loop
				namer.next
				Result.append ("%T%T%T")
				Result.append (namer.value)
				Result.append (": ")
				Result.append (item (current_state).eiffel_type_to_upper)
				Result.append ("%N")
				Result.append (eiffel_observer_declaration (item (current_state)))
				forth
			end
		end

	eiffel_observer_declaration (inst: CMD_INSTANCE): STRING is
			-- Generate declaration of variables for observers.
		do
			!! Result.make (0)
			if inst.has_observer then
				from
					inst.observers.start
				until
					inst.observers.after
				loop
					observer_namer.next
					Result.append ("%T%T%T")
					Result.append (observer_namer.value)
					Result.append (": ")
					Result.append (inst.observers.item.eiffel_type_to_upper)
					Result.append ("%N")
					inst.observers.forth
				end
			end
		end

	eiffel_association: STRING is
		local
			meta_command_initialization: STRING
		do
			!! Result.make (0)
			!! meta_command_initialization.make (0)
			observer_namer.reset
			from
				start
			until
				off
			loop
				namer.next

				Result.append ("%T%T%T!! ")
				Result.append (namer.value)
				Result.append (".make")
				Result.append (item (current_state).eiffel_arguments)
				Result.append ("%N")
				Result.append (eiffel_observer_association (item (current_state)))

				meta_command_initialization.append ("%T%T%Tmeta_command.add (")
				meta_command_initialization.append (current_state.label)
				meta_command_initialization.append (", ")
				meta_command_initialization.append (namer.value)
				meta_command_initialization.append (")%N")

				forth
			end
			Result.append ("%T%T%T!! meta_command.make%N")
			Result.append (meta_command_initialization)
		end

	eiffel_observer_association (inst: CMD_INSTANCE): STRING is
			-- Generate the code to associate an observer.
		do
			!! Result.make (0)
			if inst.has_observer then
				from
					inst.observers.start
				until
					inst.observers.after
				loop
					observer_namer.next
					Result.append ("%T%T%T!! ")
					Result.append (observer_namer.value)
					Result.append (".make")
					Result.append (inst.observers.item.eiffel_arguments)
					Result.append ("%N")
					Result.append ("%T%T%T")
					Result.append (namer.value)
					Result.append (".add_observer (")
					Result.append (observer_namer.value)
					Result.append (")%N")
					inst.observers.forth
				end
			end
		end


	make (c: CMD_INSTANCE) is
		do
			extend_table_create (5)
			update (c)
		end

	update (c: CMD_INSTANCE) is
		do
			put (c, callback_generator.current_state)
		end

feature {NONE}

	observer_namer: LOCAL_NAMER is
			-- Namer for observer varaibles.
		once
			!! Result.make ("obs")
		end

end
