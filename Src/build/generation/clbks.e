indexing
	description: "Hash table of callbacks indexed by contexts contains %
				% every callbacks for every context. %
				% Note: Context may be present as key even though they %
				% are cut from the interface, but it doesn't matter %
				% 'cause it will never be used. In the future, clean %
				% up!."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CLBKS 

inherit

	EXTEND_TABLE [CLBK, CONTEXT]
		rename
			make as extend_table_create
		end

	SHARED_APPLICATION
		undefine
			copy, is_equal
		end

creation

	make

feature 

	eiffel_text (c: CONTEXT): STRING is
		local
			pre_fix: STRING
			full_name: STRING
			con_group: GROUP_C
			g_name: STRING
		do
			!! Result.make (0)
			Result.append ("%N%Tset_")
			if not c.is_window then
				g_name := c.group_name
				if g_name = Void then
					full_name := clone (c.entity_name_in_lower_case)
					full_name.append ("_")
				else
					full_name := g_name
				end
				Result.append (full_name)
				pre_fix := c.full_name
			else
				pre_fix := ""
			end 
			Result.append ("callbacks is%N")
			if has (c) then			
				Result.append (item (c).eiffel_text (pre_fix))
			end
			if c.is_window then
				if not has (c) then
					Result.append ("%T%Tdo%N")
				end
				Result.append (c.eiffel_callback_calls)
			end
			Result.append ("%T%Tend%N")
		end

	make is
		do
			extend_table_create (10)
		end

	update is
		local
			state_list: LINKED_LIST [BUILD_STATE]
		do
			from
				state_list := Shared_app_graph.states
				state_list.start
			until
				state_list.after
			loop
				process_state (state_list.item)
				state_list.forth
			end
		end

	current_state: BUILD_STATE

	
feature {NONE}

	process_state (s: BUILD_STATE) is
		local
			clbk: CLBK
			old_pos: INTEGER
			b: BEHAVIOR
		do
			current_state := s
			from
				old_pos := s.position
				s.start
			until
				s.off
			loop
				clbk := item (s.input.data)
				b := s.output.data
				if not b.empty then
					if (clbk = Void) then
						!! clbk.make (s.output)
						put (clbk, s.input.data)
					else
						clbk.update (s.output)
					end
				end
				s.forth
			end
			s.go_i_th (old_pos)
		end

end
