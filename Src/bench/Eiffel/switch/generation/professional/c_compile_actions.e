class C_COMPILE_ACTIONS

inherit
	SHARED_WORKBENCH

feature {NONE}

	freeze_system is
			-- Action to perform to freeze a system
		do
			System.freeze_system
		end

	finalize_system (keep_assert: BOOLEAN) is
			-- Action to perform to finalize a system
		do
			System.finalized_generation (keep_assert)
		end

end
