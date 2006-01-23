indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class 
	TOOLKIT_IMP  

inherit

	SHARED_APPLICATION_CONTEXT	
	
	TOOLKIT


	ALL_CURS_X
		export
			{NONE} all
		end;

	EXCEPTIONS

create
	make

feature {NONE} -- Inititalization

	make (app_class: STRING) is
			-- Create the toolkit.
			-- `application_class' is used for the resource specifications.
		local
			app_context: MEL_APPLICATION_CONTEXT
		do 
			create app_context.make;
 			application_context_cell.put (app_context)
			if application_class = Void then
				application_class_cell.put (clone (app_class))
			end
		end;

feature -- Access

--samik	app_class: STRING;
			-- Application class name of the application

--samik	application_context: MEL_APPLICATION_CONTEXT;
			-- Xt context of current application

	name: STRING is "MOTIF";
			-- Toolkit implmentation name


feature -- Screen access

	
	--samik 	screen (a_screen: SCREEN): SCREEN_IMP is
-- samik			-- Motif implementation of `a_screen'
-- samik		do
-- samik			!! Result.make (application_context, a_screen, app_class)
-- samik		end;

feature -- Access

-- 	task (a_task: TASK): TASK_IMP is
-- 			-- Motif implementation of `a_task'
-- 		do
-- 			!! Result.make
-- 		end;

-- 	timer (a_timer: TIMER): TIMER_IMP is
-- 			-- Motif implementation of `a_timer'
-- 		do
-- 			!! Result
-- 		end;

-- 	widget_resource: WIDGET_RESOURCE_IMP is
-- 			-- X widget resource object
-- 		do
-- 			!! Result.make;
-- 		end;
	
feature -- Access
	-- these features should probably be removed from toolkit and 
	-- do !BASE_IMP!implementation
	
-- 	base (a_base: BASE): BASE_IMP is
-- 			-- Motif implementation of `a_base'
-- 		do
-- 			!! Result.make (a_base, app_class)
-- 		end; 
	
	
feature -- Iteration

	iterate is
			-- Loop the application.
		do
			application_context.main_loop
		end;

feature -- Status setting

	set_default_resources (a_list: ARRAY [WIDGET_RESOURCE]) is
			-- Set the default resource setting's
		local
			mel_list: ARRAY [MEL_WIDGET_RESOURCE];
			wr: MEL_WIDGET_RESOURCE;
			i: INTEGER
		do
			create mel_list.make (a_list.lower, a_list.upper);
			from
				i := a_list.lower
			until
				i > a_list.upper
			loop
				wr ?= a_list.item (i);
				check
					valid_widget_resource: wr /= Void
				end;
				mel_list.put (wr, i);
				i := i + 1
			end;
			application_context.set_default_resources (mel_list)
		end;
	
feature	
		exit is
			-- Exit from the application
		do
			application_context.exit
		end;

invariant

	non_void_application: application_context /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TOOLKIT_IMP

