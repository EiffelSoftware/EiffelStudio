indexing
	description: "A specific callback on a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CLBK 

inherit

	EXTEND_TABLE [META_CMD, EVENT]
		rename
			make as extend_table_create,
			key_for_iteration as current_event
		export
			{NONE} all
		end

	COM_NAMER
		export
			{NONE} all
		undefine
			copy, is_equal
		end


creation

	make

	
feature 

	eiffel_text (wid: STRING): STRING is
		do
			!! Result.make (0)
			Result.append ("%T%Tlocal%N")
			namer.reset
			Result.append (eiffel_declaration)
			Result.append ("%T%Tdo%N")
			namer.reset
			Result.append (eiffel_association (wid))
		end

	
feature {NONE}

	eiffel_declaration: STRING is
		do
			!! Result.make (0)
			from
				start
			until
				off
			loop
				Result.append (item (current_event).eiffel_declaration)
				forth
			end
			Result.append ("%T%T%Tmeta_command: META_COMMAND%N")
		end

	eiffel_association (wid: STRING): STRING is
		local
			pre_fix: STRING
		do
			!! Result.make (0)
			!! pre_fix.make (0)
			if not wid.empty then
				pre_fix.append (wid)
				pre_fix.append (".")
			end
			from
				start
			until
				off
			loop
				Result.append (item (current_event).eiffel_association)
				Result.append ("%T%T%T")
				Result.append (pre_fix)
				Result.append (current_event.eiffel_text)
				Result.append ("meta_command, Void)%N")
				forth
			end
		end

	
feature 

	make (b: BEHAVIOR) is
		do
			extend_table_create (5)
			update (b)
		end	

	update (b: BEHAVIOR) is
		local
			mc: META_CMD
			behavior: BEHAVIOR
			old_pos: INTEGER
		do
			behavior := b.data
			from
				old_pos := behavior.position
				behavior.start
			until
				behavior.off
			loop
				mc := item (behavior.input)
				if (mc = Void) then
					!!mc.make (behavior.output)
					put (mc, behavior.input)
				else
					mc.update (behavior.output)
				end
				behavior.forth
			end
			behavior.go_i_th (old_pos)
		end

end
