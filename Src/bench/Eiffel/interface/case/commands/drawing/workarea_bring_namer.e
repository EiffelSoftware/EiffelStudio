indexing

	description: 
		"Command associated to the workarea. Bring a namer tool %
		%targeted on the pointed object (no effect if none).";
	date: "$Date$";
	revision: "$Revision $"

class 
	WORKAREA_BRING_NAMER

inherit
	WORKAREA_COMMAND
		redefine
	--		context_data_useful
		end

creation

	make

feature -- Status report

	context_data_useful: BOOLEAN is True;
		-- Should the context data be available when Current 
		-- command is invoked as a callback ? Yes.

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Bring a namer tool targeted on the pointed object 
			-- (no effect if none)
		local
		--	bt_data: BUTTON_DATA;
		--	namable: NAMABLE;
		--	linkable: LINKABLE_DATA;
		--		-- locals to speed up acccess:
		--	active_entity: GRAPH_FORM
		--	wa: like workarea
		do
--			check
--				not_used: not_used = Void
--			end
--			wa := workarea
--			active_entity := wa.active_entity
--			if active_entity /= Void then
--				bt_data ?= context_data;
--				check
--					button_data_exists: bt_data /= Void
--				end
--				linkable ?= active_entity.data;
--				if linkable /= Void then
--					namable ?= linkable.stone
--					if namable /= Void then
--					--	wa.update_before_transport (bt_data);
--					--	Windows.namer_window.popup_at_current_position (namable);
--					end;
--				end;
--			end; --| if active_entity /= Void
		end

end -- class WORKAREA_BRING_EDITOR







