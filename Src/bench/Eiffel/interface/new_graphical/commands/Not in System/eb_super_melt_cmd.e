indexing
	description: "Command that super melts a class or a routine."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SUPER_MELT_CMD

inherit
	NEW_EB_CONSTANTS

	EB_EDITOR_COMMAND

	SHARED_APPLICATION_EXECUTION

creation
	make, do_nothing

feature -- Access

	name: STRING is
		do
			Result := Interface_names.f_Stoppable
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Stoppable
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	insert_breakpoint: BOOLEAN is True
			-- As supermelting is to be supressed,
			-- insert_breakpoint is made true.

feature -- Execution

	execute (arg: STONE) is
			-- Super melt a class or routine. If arg is Void then
			-- the stone's tool is taken in account.
		local
			c_stone: CLASSC_STONE
			f_stone: FEATURE_STONE
			disp_bp: EB_DEBUG_STOPIN_HOLE_CMD
--			mp: MOUSE_PTR
			stone: STONE
		do
			if arg = Void then	
				stone := tool.stone	
			else
				stone := arg
			end
			f_stone ?= stone
			c_stone ?= stone
			create disp_bp
			if f_stone /= Void then
				if f_stone.is_valid and then f_stone.e_feature.is_debuggable then
--					create mp.set_watch_cursor
					Application.super_melt_feature (f_stone.e_feature, insert_breakpoint)
					disp_bp.execute (Void)
--					mp.restore
				end
			elseif c_stone /= Void and then c_stone.is_valid then
--				create mp.set_watch_cursor
				Application.super_melt_class (c_stone.e_class, insert_breakpoint)
				disp_bp.execute (Void)
--				mp.restore
			end
		end

end -- class EB_SUPER_MELT_CMD
