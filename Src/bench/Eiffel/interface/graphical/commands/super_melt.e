indexing
	description: "Command that super melts a class or a routine.";
	date: "$Date$";
	revision: "$Revision $"

class SUPER_MELT

inherit
	EB_CONSTANTS

	TOOL_COMMAND
		rename
			init as make
		end

	SHARED_APPLICATION_EXECUTION

create
	make, do_nothing

feature -- Access

	name: STRING is
		do
			Result := Interface_names.f_Stoppable
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Stoppable
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	insert_breakpoint: BOOLEAN is
			-- Super melt doesn't add a breakpoint.
		do
		end

feature -- Execution

	work (arg: ANY) is
			-- Super melt a class or routine. If associated `tool'
			-- is Void then the arg is checked if it is a stone.
		local
			c_stone: CLASSC_STONE;
			f_stone: FEATURE_STONE;
			disp_bp: DEBUG_STOPIN_HOLE;
			mp: MOUSE_PTR;
			stone: STONE
		do
			if tool = Void then	
				stone ?= arg	
			else
				stone := tool.stone
			end;
			f_stone ?= stone;
			c_stone ?= stone;
			create disp_bp.do_nothing;
			if f_stone /= Void then
				if f_stone.is_valid and then f_stone.e_feature.is_debuggable then
					create mp.set_watch_cursor;
					Application.super_melt_feature (f_stone.e_feature, insert_breakpoint);
					disp_bp.work (Void);
					mp.restore
				end
			elseif c_stone /= Void and then c_stone.is_valid then
				create mp.set_watch_cursor;
				Application.super_melt_class (c_stone.e_class, insert_breakpoint);
				disp_bp.work (Void);
				mp.restore
			end;
		end;

end -- class SUPER_MELT
