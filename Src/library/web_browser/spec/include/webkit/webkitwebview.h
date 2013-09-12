/*
 * Copyright (C) 2007 Holger Hans Peter Freyther
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#ifndef WEBKIT_WEB_VIEW_H
#define WEBKIT_WEB_VIEW_H

#include <gtk/gtk.h>
#include <JavaScriptCore/JSBase.h>

#include "webkitdefines.h"
#include "webkitwebsettings.h"

G_BEGIN_DECLS

#define WEBKIT_TYPE_WEB_VIEW            (webkit_web_view_get_type())
#define WEBKIT_WEB_VIEW(obj)            (G_TYPE_CHECK_INSTANCE_CAST((obj), WEBKIT_TYPE_WEB_VIEW, WebKitWebView))
#define WEBKIT_WEB_VIEW_CLASS(klass)    (G_TYPE_CHECK_CLASS_CAST((klass),  WEBKIT_TYPE_WEB_VIEW, WebKitWebViewClass))
#define WEBKIT_IS_WEB_VIEW(obj)         (G_TYPE_CHECK_INSTANCE_TYPE((obj), WEBKIT_TYPE_WEB_VIEW))
#define WEBKIT_IS_WEB_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE((klass),  WEBKIT_TYPE_WEB_VIEW))
#define WEBKIT_WEB_VIEW_GET_CLASS(obj)  (G_TYPE_INSTANCE_GET_CLASS((obj),  WEBKIT_TYPE_WEB_VIEW, WebKitWebViewClass))


typedef enum {
    WEBKIT_NAVIGATION_RESPONSE_ACCEPT,
    WEBKIT_NAVIGATION_RESPONSE_IGNORE,
    WEBKIT_NAVIGATION_RESPONSE_DOWNLOAD
} WebKitNavigationResponse;

typedef enum
{
    WEBKIT_WEB_VIEW_TARGET_INFO_HTML = - 1,
    WEBKIT_WEB_VIEW_TARGET_INFO_TEXT = - 2
} WebKitWebViewTargetInfo;

struct _WebKitWebView {
    GtkContainer parent;
};

struct _WebKitWebViewClass {
    GtkContainerClass parent;

    /*
     * default handler/virtual methods
     * DISCUSS: create_web_view needs a request and should we make this a signal with default handler? this would
     * require someone doing a g_signal_stop_emission_by_name
     * WebUIDelegate has nothing for create_frame, WebPolicyDelegate as well...
     */
    WebKitWebView*  (*create_web_view)  (WebKitWebView* web_view);

    /*
     * TODO: FIXME: Create something like WebPolicyDecisionListener_Protocol instead
     */
    WebKitNavigationResponse (*navigation_requested) (WebKitWebView* web_view, WebKitWebFrame* frame, WebKitNetworkRequest* request);

    void (*window_object_cleared) (WebKitWebView* web_view, WebKitWebFrame* frame, JSGlobalContextRef context, JSObjectRef window_object);
    gchar*   (*choose_file) (WebKitWebView* web_view, WebKitWebFrame* frame, const gchar* old_file);
    gboolean (*script_alert) (WebKitWebView* web_view, WebKitWebFrame* frame, const gchar* alert_message);
    gboolean (*script_confirm) (WebKitWebView* web_view, WebKitWebFrame* frame, const gchar* confirm_message, gboolean* did_confirm);
    gboolean (*script_prompt) (WebKitWebView* web_view, WebKitWebFrame* frame, const gchar* message, const gchar* default_value, gchar** value);
    gboolean (*console_message) (WebKitWebView* web_view, const gchar* message, unsigned int line_number, const gchar* source_id);
    void (*select_all) (WebKitWebView* web_view);
    void (*cut_clipboard) (WebKitWebView* web_view);
    void (*copy_clipboard) (WebKitWebView* web_view);
    void (*paste_clipboard) (WebKitWebView* web_view);

    /*
     * internal
     */
    void   (*set_scroll_adjustments) (WebKitWebView*, GtkAdjustment*, GtkAdjustment*);
};

WEBKIT_API GType
webkit_web_view_get_type (void);

WEBKIT_API GtkWidget*
webkit_web_view_new (void);

WEBKIT_OBSOLETE_API gboolean
webkit_web_view_can_go_backward (WebKitWebView* web_view);

WEBKIT_API gboolean
webkit_web_view_can_go_back (WebKitWebView* web_view);

WEBKIT_API gboolean
webkit_web_view_can_go_back_or_forward (WebKitWebView* web_view, gint steps);

WEBKIT_API gboolean
webkit_web_view_can_go_forward (WebKitWebView* web_view);

WEBKIT_OBSOLETE_API void
webkit_web_view_go_backward (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_go_back (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_go_back_or_forward (WebKitWebView* web_view, gint steps);

WEBKIT_API void
webkit_web_view_go_forward (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_stop_loading (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_open (WebKitWebView* web_view, const gchar* uri);

WEBKIT_API void
webkit_web_view_reload (WebKitWebView *web_view);

WEBKIT_API void
webkit_web_view_load_string (WebKitWebView* web_view, const gchar* content, const gchar* content_mime_type, const gchar* content_encoding, const gchar* base_uri);

WEBKIT_API void
webkit_web_view_load_html_string (WebKitWebView* web_view, const gchar* content, const gchar* base_uri);

WEBKIT_API gboolean
webkit_web_view_search_text (WebKitWebView* web_view, const gchar* string, gboolean case_sensitive, gboolean forward, gboolean wrap);

WEBKIT_API guint
webkit_web_view_mark_text_matches (WebKitWebView* web_view, const gchar* string, gboolean case_sensitive, guint limit);

WEBKIT_API void
webkit_web_view_set_highlight_text_matches (WebKitWebView* web_view, gboolean highlight);

WEBKIT_API void
webkit_web_view_unmark_text_matches (WebKitWebView* web_view);

WEBKIT_API WebKitWebFrame*
webkit_web_view_get_main_frame (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_execute_script (WebKitWebView* web_view, const gchar* script);

WEBKIT_API gboolean
webkit_web_view_can_cut_clipboard (WebKitWebView* web_view);

WEBKIT_API gboolean
webkit_web_view_can_copy_clipboard (WebKitWebView* web_view);

WEBKIT_API gboolean
webkit_web_view_can_paste_clipboard (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_cut_clipboard (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_copy_clipboard (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_paste_clipboard (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_delete_selection (WebKitWebView* web_view);

WEBKIT_API gboolean
webkit_web_view_has_selection (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_select_all (WebKitWebView* web_view);

WEBKIT_API gboolean
webkit_web_view_get_editable (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_set_editable (WebKitWebView* web_view, gboolean flag);

WEBKIT_API GtkTargetList*
webkit_web_view_get_copy_target_list (WebKitWebView* web_view);

WEBKIT_API GtkTargetList*
webkit_web_view_get_paste_target_list (WebKitWebView* web_view);

WEBKIT_API void
webkit_web_view_set_settings (WebKitWebView* web_view, WebKitWebSettings* settings);

WEBKIT_API WebKitWebSettings*
webkit_web_view_get_settings (WebKitWebView* web_view);

G_END_DECLS

#endif
