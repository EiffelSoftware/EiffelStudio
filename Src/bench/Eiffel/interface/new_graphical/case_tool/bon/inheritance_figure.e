indexing
	description:
		"Graphical representations of an inheritance link without%N%
		%commitment to any notation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INHERITANCE_FIGURE

inherit
	LINK_FIGURE
		rename
			source as descendant,
			target as ancestor
		end

feature {NONE} -- Initialization

	make_with_classes (a_descendant, a_ancestor: CLASS_FIGURE) is
			-- Initialize with `a_ancestor' and `a_descendant'.
		require
			a_ancestor_not_void: a_ancestor /= Void
			a_descendant_not_void: a_descendant /= Void
		do
			default_create
			create {INHERIT_STONE} pebble.make (Current)
			set_accept_cursor (Cursors.cur_Inherit_link)
			descendant := a_descendant
			a_descendant.ancestor_figures.extend (Current)
			ancestor := a_ancestor
			a_ancestor.descendant_figures.extend (Current)
			initialize
			create unset_do_stack.make
			create unset_undo_stack.make
			create reset_do_stack.make
			create reset_undo_stack.make
			build_figure
		end

feature {CLASS_TEXT_MODIFIER} -- Access

	code: STRING
			-- Code of the whole inheritance clause after a removal.

feature -- Access

	cluster_figure: CLUSTER_FIGURE is
			-- Cluster figure `Current' is in directly.
			-- Void if none or more than one.
		local
			c: CLUSTER_FIGURE
		do
			c := ancestor.cluster_figure
			if c /= Void and then c = descendant.cluster_figure then
				Result := c
			end
		end

feature -- Status report

	is_reflexive: BOOLEAN is
			-- `ancestor' must be distinct from `descendant'.
		do
			Result := False
		end
		
	last_generation_successful: BOOLEAN
			-- Was last code generation actually done?

feature {CONTEXT_DIAGRAM} -- Status setting

	apply_right_angles is
			-- Make `Current' use right angles.
		local
			figure_right, figure_left, figure_top, figure_bottom: LINKABLE_FIGURE
			desc_x, desc_y, anc_x, anc_y: INTEGER
		do
			desc_x := descendant.x_position
			desc_y := descendant.y_position
			anc_x := ancestor.x_position
			anc_y := ancestor.y_position
			if desc_x = anc_x or
				desc_y = anc_y then
					reset
			else
				if desc_x < anc_x then
					figure_left := descendant
					figure_right := ancestor
				else
					figure_right := descendant
					figure_left := ancestor
				end
				if desc_y < anc_y then
					figure_top := descendant
					figure_bottom := ancestor
				else
					figure_bottom := descendant
					figure_top := ancestor
				end
				if figure_right = ancestor then
					put_handle_left
				else
					put_handle_right
				end
			end
		end

feature {LINKABLE_FIGURE} -- Status setting

	mask is
			-- `Current' no longer needs to be displayed.
		do
			hide
			disable_sensitive
		end

	unmask is
			-- `Current' needs to be displayed again, if possible.
		do
			if ancestor.is_show_requested and descendant.is_show_requested then
				show
				enable_sensitive
			end
		end

feature {CLASS_TEXT_MODIFIER} -- Element change

	set_code (a_code: STRING) is
			-- Assign `a_code' to `code'.
		do
			code := a_code
		ensure
			code_assigned: code = a_code
		end

feature {CONTEXT_DIAGRAM, EB_DELETE_DIAGRAM_ITEM_COMMAND} -- Removal

	remove_from_diagram (d: CONTEXT_DIAGRAM) is
			-- Remove `Current' graphically and in the code.
		local
			cg: CLASS_TEXT_MODIFIER
			desc: CLASS_FIGURE
			class_file: PLAIN_TEXT_FILE
			dial: EB_WARNING_DIALOG
		do
			last_generation_successful := False
			desc ?= descendant
			if not ancestor.name.is_equal ("ANY") and then desc /= Void then
				create class_file.make (desc.class_i.file_name)
				check class_file.exists end
				cg := desc.code_generator
				cg.set_diagram (d)
				if cg.date = class_file.date then
					cg.prepare_for_modification
					if cg.valid_syntax then
						cg.remove_ancestor (ancestor.name, Current)
						if cg.valid_syntax then
							cg.commit_modification
							create class_file.make (desc.class_i.file_name)
							check class_file.exists end
							cg.set_date (class_file.date)
							world.inheritance_layer.prune_all (Current)
							descendant.ancestor_figures.prune_all (Current)
							ancestor.descendant_figures.prune_all (Current)
							d.context_editor.projector.project
							last_generation_successful := True
						else
							create dial.make_with_text ("Error while generating code in " + descendant.name + "%N")
							dial.show_modal_to_window (desc.world.context_editor.development_window.window)
							cg.invalidate_text
						end
					else
						create dial.make_with_text (
							Warning_messages.w_Class_syntax_error_before_generation (descendant.name))
						dial.show_modal_to_window (desc.world.context_editor.development_window.window)
						cg.invalidate_text
					end
				else
					create dial.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
					dial.show_modal_to_window (desc.world.context_editor.development_window.window)
					d.context_editor.reset_history
					cg.set_date (class_file.date)
				end
			else
				create dial.make_with_text (Warning_messages.w_Inheritance_from_any)
				dial.show_modal_to_window (desc.world.context_editor.development_window.window)
			end
		end

feature {CONTEXT_DIAGRAM, EB_DELETE_DIAGRAM_ITEM_COMMAND} -- Retrieving

	put_on_diagram (d: CONTEXT_DIAGRAM) is
			-- Put `Current' back on `d' and re-generate code.
		local
			cg: CLASS_TEXT_MODIFIER
			cf, cf2: CLASS_FIGURE
			class_file: PLAIN_TEXT_FILE
			dial: EB_WARNING_DIALOG
		do
			last_generation_successful := False
			cf ?= descendant
			cf2 ?= ancestor
			if cf /= Void and cf2 /= Void then 
				if d.has_linkable_figure (ancestor) and then
					d.has_linkable_figure (descendant) then	
						create class_file.make (cf.class_i.file_name)
						check class_file.exists end
						cg := cf.code_generator
						cg.set_diagram (d)
						if cg.date = class_file.date then
							cg.prepare_for_modification
							if cg.valid_syntax then
								cg.extend_ancestor (ancestor.name, Current)
								if cg.valid_syntax then
									cg.commit_modification
									create class_file.make (cf.class_i.file_name)
									check class_file.exists end
									cg.set_date (class_file.date)
									d.add_inheritance_figure (Current)
									descendant.ancestor_figures.extend (Current)
									ancestor.descendant_figures.extend (Current)
									update
									world.context_editor.projector.project
									world.context_editor.on_inheritance_link_created
									last_generation_successful := True
								else
									create dial.make_with_text ("Error while generating code in " + descendant.name + "%N")
									dial.show_modal_to_window (cf.world.context_editor.development_window.window)
									cg.invalidate_text
								end
							else
								create dial.make_with_text (
									Warning_messages.w_Class_syntax_error_before_generation (descendant.name))
								dial.show_modal_to_window (cf.world.context_editor.development_window.window)
								cg.invalidate_text
							end
						else
							create dial.make_with_text (Warning_messages.w_Class_modified_outside_diagram)
							dial.show_modal_to_window (cf.world.context_editor.development_window.window)
							d.context_editor.reset_history
							cg.set_date (class_file.date)
						end
				end
			end
		end

end -- class INHERITANCE_FIGURE