/*
	description: "Private runtime global variables access."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_globals_access_h_
#define _rt_globals_access_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS

	/* copy.c and equal.c */
#define hclone				(rt_globals->hclone_cx)		/* rt_private */
#define eif_equality_table	(rt_globals->eif_equality_table_cx)		/* rt_private */

	/* debug.c */
#ifdef WORKBENCH
#define db_stack			(rt_globals->db_stack_cx)		/* rt_shared */
#define d_cxt				(rt_globals->d_cxt_cx)		/* rt_shared */
#endif

	/* eif_threads.c */
#define eif_thr_context		(rt_globals->eif_thr_context_cx)	/* rt_public */
#define last_child			(rt_globals->last_child_cx)
#define gc_thread_status	(rt_globals->gc_thread_status_cx)
#define gc_thread_collection_count	(rt_globals->gc_thread_collection_count_cx)
#define thread_can_launch_gc	(rt_globals->thread_can_launch_gc_cx)
#define thread_exiting		(rt_globals->thread_exiting_cx)

	/* except.c */
#define eif_trace			(rt_globals->eif_trace_cx)	/* rt_public */
#define ex_ign				(rt_globals->ex_ign_cx)	/* rt_public */
#define eif_except			(rt_globals->eif_except_cx)	/* rt_private */
#define print_history_table (rt_globals->print_history_table_cx)   /* rt_private */
#define ex_string			(rt_globals->ex_string_cx)	/* rt_public */
#ifdef EIF_WINDOWS
#define ex_buffer_1			(rt_globals->ex_buffer_1_cx)	/* rt_private */
#define ex_buffer_2			(rt_globals->ex_buffer_2_cx)	/* rt_private */
#endif
#ifdef WORKBENCH
#define db_ign				(rt_globals->db_ign_cx)	/* rt_public */
#endif

	/* interp.c - debug.c */
#ifdef WORKBENCH
#define iregs				(rt_globals->iregs_cx)			/* rt_private */
#define iregsz				(rt_globals->iregsz_cx)		/* rt_private */
#define argnum				(rt_globals->argnum_cx)		/* rt_private */
#define locnum				(rt_globals->locnum_cx)		/* rt_private */
#define tagval				(rt_globals->tagval_cx)		/* rt_private */
#define saved_scur			(rt_globals->saved_scur_cx)	/* rt_private */
#define saved_stop			(rt_globals->saved_stop_cx)	/* rt_private */
#define inv_mark_table		(rt_globals->inv_mark_table_cx)	/* rt_private */
#endif	/* WORKBENCH */

	/* gen_conf.c */
#define cid_array					(rt_globals->cid_array_cx)
#define non_generic_type_names		(rt_globals->non_generic_type_names_cx)
#define rt_context					(rt_globals->rt_context_cx)

	/* out.c */
#define buffero				(rt_globals->buffero_cx)		/* rt_private */
#define tagged_out			(rt_globals->tagged_out_cx)	/* rt_private */
#define tagged_max			(rt_globals->tagged_max_cx)	/* rt_private */
#define tagged_len			(rt_globals->tagged_len_cx)	/* rt_private */

	/* plug.c */
#define inv_mark_tablep		(rt_globals->inv_mark_tablep_cx)	/* rt_private */

	/* sig.c */
#define esigblk				(rt_globals->esigblk_cx)		/* rt_shared */
#define sig_stk				(rt_globals->sig_stk_cx)		/* rt_shared */
#define c_sig_stk			(rt_globals->c_sig_stk_cx)		/* rt_private */

	/* retrieve.c */
#define rt_table						(rt_globals->rt_table_cx)
#define nb_recorded						(rt_globals->nb_recorded_cx)
#define rt_kind							(rt_globals->rt_kind_cx)
#define rt_kind_version					(rt_globals->rt_kind_version_cx)
#define rt_kind_properties				(rt_globals->rt_kind_properties_cx)
#define eif_discard_pointer_values		(rt_globals->eif_discard_pointer_value_cx)
#define type_conversions				(rt_globals->type_conversions_cx)
#define mismatches						(rt_globals->mismatches_cx)
#define dattrib							(rt_globals->dattrib_cx)
#define dtypes							(rt_globals->dtypes_cx)
#define spec_elm_size					(rt_globals->spec_elm_size_cx)
#define old_overhead					(rt_globals->old_overhead_cx)
#define r_buffer						(rt_globals->r_buffer_cx)
#define r_fides							(rt_globals->r_fides_cx)
#define class_translations				(rt_globals->class_translations_cx)
#define retrieve_read_func				(rt_globals->retrieve_read_func_cx)
#define char_read_func					(rt_globals->char_read_func_cx)
#define old_retrieve_read_func			(rt_globals->old_retrieve_read_func_cx)
#define old_char_read_func				(rt_globals->old_char_read_func_cx)
#define old_buffer_size					(rt_globals->old_buffer_size_cx)
#define end_of_buffer					(rt_globals->end_of_buffer_cx)
#define stream_buffer					(rt_globals->stream_buffer_cx)
#define stream_buffer_position			(rt_globals->stream_buffer_position_cx)
#define stream_buffer_size				(rt_globals->stream_buffer_size_cx)
#define cidarr							(rt_globals->cidarr_cx)
#define mismatch_information_initialize	(rt_globals->mismatch_information_initialize_cx)
#define mismatch_information_add		(rt_globals->mismatch_information_add_cx)
#define mismatch_information_object		(rt_globals->mismatch_information_object_cx)
#define mismatch_information_set_versions	(rt_globals->mismatch_information_set_versions_cx)
#define eif_use_old_independent_retrieve (rt_globals->eif_use_old_independent_retrieve_cx)

	/* run_idr.c */
#define idr_temp_buf		(rt_globals->idr_temp_buf_cx)
#define amount_read			(rt_globals->amount_read_cx)
#define idrf_buffer_size	(rt_globals->idrf_buffer_size_cx)
#define idrf				(rt_globals->idrf_cx)
#define run_idr_read_func	(rt_globals->run_idr_read_func_cx)
#ifdef EIF_64_BITS
#define idr_ref_table		(rt_globals->idr_ref_table_cx)
#define idr_ref_table_counter		(rt_globals->idr_ref_table_counter_cx)
#endif

	/* store.c */
#define info_tag						(rt_globals->info_tag_cx)
#define object_count					(rt_globals->object_count_cx)
#define cmps_general_buffer				(rt_globals->cmps_general_buffer_cx)
#define general_buffer					(rt_globals->general_buffer_cx)
#define current_position				(rt_globals->current_position_cx)
#define buffer_size						(rt_globals->buffer_size_cx)
#define cmp_buffer_size					(rt_globals->cmp_buffer_size_cx)
#define s_fides							(rt_globals->s_fides_cx)
#define store_write_func				(rt_globals->store_write_func_cx)
#define char_write_func			 		(rt_globals->char_write_func_cx)
#define eif_is_discarding_attachment_marks	(rt_globals->eif_is_discarding_attachment_marks_cx)
#define eif_is_discarding_qat			(rt_globals->eif_is_discarding_qat_cx)
#define sorted_attributes				(rt_globals->sorted_attributes_cx)
#define store_stream_buffer				(rt_globals->store_stream_buffer_cx)
#define store_stream_buffer_position	(rt_globals->store_stream_buffer_position_cx)
#define store_stream_buffer_size		(rt_globals->store_stream_buffer_size_cx)

	/* option.c */
#define eif_trace_disabled	(rt_globals->eif_trace_disabled_cx)
#define last_dtype			(rt_globals->last_dtype_cx)
#define last_origin			(rt_globals->last_origin_cx)
#define last_name			(rt_globals->last_name_cx)
#define class_table			(rt_globals->class_table_cx)
#define init_date			(rt_globals->init_date_cx)
#define rt_nb_ticks_per_second	(rt_globals->rt_nb_ticks_per_second_cx)
#define rt_start_time		(rt_globals->rt_start_time_cx)

		/* memory.c */
#define m_largest			(rt_globals->m_largest_cx)

		/* file.c */
#define file_type			(rt_globals->file_type_cx)

		/* eif_type_id.c */
#define eif_pre_ecma_mapping_status			(rt_globals->eif_pre_ecma_mapping_status_cx)

#endif

#ifdef __cplusplus
}
#endif

#endif


