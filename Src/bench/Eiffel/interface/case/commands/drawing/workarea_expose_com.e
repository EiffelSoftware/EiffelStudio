indexing

	description: 
		"Command execute when an expose event on a workarea occurs.";
	date: "$Date$";
	revision: "$Revision $"

class WORKAREA_EXPOSE_COM

inherit

	WORKAREA_COM
		redefine
		--	context_data_useful, work
		end;

	ONCES

creation

	make

feature -- Execution

	context_data_useful: BOOLEAN is True;
			-- This command need a context_datas structure

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Refresh the area defined by `context_data.clip`.
		local
		--	expose_data: EXPOSE_DATA;
		--	clip: CLIP
		do
		--	check
		--		not_used: not_used = Void
		--	end
		--	expose_data ?= context_data;
		--	check
		--		has_expose_data: expose_data /= void
		--	end
		--	clip := expose_data.clip
	--
	--		workarea.to_refresh.merge_clip (clip)
	--		if expose_data.exposes_to_come = 0 then
	--			workarea.refresh
	--		end;
		end

	work (arg: ANY) is
			--| Current command should not popdown the error window,
			--| hence the redefinition
		do
		--	execute (arg)
		end

end -- class WORKAREA_EXPOSE_COM

